import UIKit

class PracticeViewController: UIViewController {
    
    @IBOutlet weak var answerText: UITextView!
    @IBOutlet weak var questionText: UITextView!
    
    let categories = ["生活用語", "機場", "餐廳", "飯店", "職場", "旅遊", "校園", "娛樂", "搞笑", "電影", "電視劇", "歌曲", "科技", "美食", "體育"]
    
    var q = ""
    var a = ""
    var language = ""
    var level = ""
    var length = 0 // 難度以句子長度當標準
    
    private let urlString = "https://api.openai.com/v1/completions"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answerText.clipsToBounds = true;
        answerText.layer.cornerRadius = 15.0;
        answerText.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        questionText.clipsToBounds = true;
        questionText.layer.cornerRadius = 15.0;
        questionText.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        if (level == "初級") {
            length = Int.random(in: 5..<8)
        } else if (level == "中級") {
            length = Int.random(in: 8..<11)
        } else if (level == "高級") {
            length = Int.random(in: 11..<15)
        }
        callChatGPTAPI(promptStr: "隨機給我一句\(categories[Int.random(in: 0..<categories.count)])類型、\(length)字的繁體中文句子給我")
//        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
//        view.addGestureRecognizer(tap)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? FeedbackViewController{
            vc.question = q
            vc.answer = answerText.text
            vc.language = language
            let backItem = UIBarButtonItem()
            backItem.title = "返回"
            navigationItem.backBarButtonItem = backItem
            
        }
    }
    
    private func callChatGPTAPI(promptStr: String) {
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("application/json",
                         forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(ChatGPTAPIKey.key)",
                         forHTTPHeaderField: "Authorization")
        let openAIBody = OpenAIBody(model: AIModel.model, prompt: promptStr)
        request.httpBody = try? JSONEncoder().encode(openAIBody)
        request.httpMethod = "post"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data,
                let content = String(data: data, encoding: .utf8) {
                print(content)
            }
            do {
                let data = try JSONDecoder().decode(JsonData.self, from: data!)
                DispatchQueue.main.async {
                    let str = data.choices[0].text
                    let start = str.index(str.startIndex, offsetBy: 2)
                    let end = str.index(str.endIndex, offsetBy: 0)
                    let range = start..<end
                    let subStr = str[range]
                    
                    self.questionText.text = String(subStr)
                    self.q = String(subStr)
                }
            } catch {
                print(error.localizedDescription)
                self.questionText.text = "抱歉，請回上一頁再重新試一次"
            }
        }.resume()
        
    }

    @IBAction func submitClk(_ sender: Any) {
//        let record = DataProvider()
    }
}

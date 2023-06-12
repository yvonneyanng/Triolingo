import UIKit

protocol DataUpdateDelegate: AnyObject {
    func didUpdateData(_ newQues: String, newImg: String)
}

class FeedbackViewController: UIViewController {

    @IBOutlet weak var questionTV: UITextView!
    @IBOutlet weak var feedbackTV: UITextView!
    
    var dataProvider = DataProvider()
    var uploadRecord: Sentences?
    
    var question = ""
    var answer = ""
    var language = ""
    
    private let urlString = "https://api.openai.com/v1/completions"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionTV.clipsToBounds = true;
        questionTV.layer.cornerRadius = 15.0;
        questionTV.textContainerInset = UIEdgeInsets(top: 20, left: 15, bottom: 20, right: 15)
        questionTV.text = "Q｜\(question)\nA｜\(answer)"
        
        feedbackTV.clipsToBounds = true;
        feedbackTV.layer.cornerRadius = 15.0;
        feedbackTV.textContainerInset = UIEdgeInsets(top: 20, left: 15, bottom: 20, right: 15)
        
        let inspectPrompt = "幫我檢查\(answer)是不是'\(question)'的正確\(language)翻譯。正確的話請回應'Bingo！你是最棒的！'。不正確的話請回應'Um...你可以這樣說：'後面接正確\(language)翻譯。"
        callChatGPTAPI(promptStr: inspectPrompt)
        
        dataProvider.loadData()
    }
    
    private func callChatGPTAPI(promptStr: String) {
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(ChatGPTAPIKey.key)", forHTTPHeaderField: "Authorization")
        let openAIBody = OpenAIBody(model: AIModel.model, prompt: promptStr)
        request.httpBody = try? JSONEncoder().encode(openAIBody)
        request.httpMethod = "post"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let content = String(data: data, encoding: .utf8){
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
                    self.feedbackTV.text = "回饋｜\(String(subStr))"
                    
                    // appending data to the dataprovider but not working
                    var status = ""
                    if subStr == "Bingo！你是最棒的！"{
                        status = "accept"
                    } else{
                        status = "cross"
                    }
                    self.dataProvider.imgData.append(status)
                    self.dataProvider.questionData.append(self.question)
                    self.dataProvider.answerData.append(self.answer)
                }
                                
            } catch {
                print(error.localizedDescription)
                self.feedbackTV.text = "抱歉，請回上一頁再重新試一次"
            }
        }.resume()
        
    }

    @IBAction func completeClk(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

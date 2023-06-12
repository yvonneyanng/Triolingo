import UIKit

class DetailViewController: UIViewController {
    
    var record: Sentences?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var answerTV: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answerTV.layer.cornerRadius = 15.0
        if let recordObj = record {
            imageView.image = UIImage(named: recordObj.img)
            answerTV.text = recordObj.question + "\n----------------------------\n" +  recordObj.answer
        }
//        answerTV.translatesAutoresizingMaskIntoConstraints = true
//        answerTV.sizeToFit()
//        answerTV.isScrollEnabled = false
        answerTV.textContainerInset = UIEdgeInsets(top: 25, left: 15, bottom: 25, right: 15)
    }
    
    @IBAction func back(_ sender: Any) {
    }
}

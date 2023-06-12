import UIKit

class Sentences: NSObject {
    var img: String
    var question: String
    var answer: String
    
    init(img: String, question: String, answer: String) {
        self.img = img
        self.question = question
        self.answer = answer
    }
}

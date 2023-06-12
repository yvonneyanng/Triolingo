import UIKit

class DataProvider: NSObject {

    var record:[Sentences] = []
    var imgData = [
        "accept",
        "accept",
        "cross",
        "accept",
        "accept",
        "cross",
        "accept",
        "cross",
        "cross",
        "accept",
        "accept",
        "cross",
        "accept",
        "accept",
        "accept"
    ]
    var questionData = [
        "請隨身攜帶行李",
        "來一場美食之旅吧",
        "我喜歡吃冰淇淋",
        "今天天氣很熱",
        "我正在學習新的語言",
        "這本書很有趣",
        "我喜歡旅遊世界各地",
        "我每天都喝咖啡",
        "我喜歡聽音樂",
        "我喜歡在大自然中散步",
        "我正在計劃下一個國外旅行",
        "在職場上與同事合作是重要的",
        "教育是改變世界的關鍵",
        "我正在學習新的工作技能",
        "旅遊可以擴展我們的視野"
    ]
    var answerData = [
        "Please carry on your peresonal luggage.",
        "Let's go on a culinary tour.",
        "アイスクリームが好きです",
        "El clima está frío hoy.",
        "Estoy aprendiendo un nuevo idioma.",
        "この本はつまらないです",
        "Me gusta viajar por todo el mundo.",
        "Bebo té todos los días.",
        "No me gusta escuchar música.",
        "大自然で散歩するのが好きです",
        "I'm planning on next trip abroad.",
        "It is important to cooperate with colleagues in the workplace.",
        "La educación es clave para cambiar el mundo.",
        "I am learning new job skills.",
        "旅行は私たちの視野を広げることができます"
    ]
    
    func loadData(){
        record = [Sentences]()
        
        for i in 0...questionData.count-1 {
            let data = Sentences(img: imgData[i], question: questionData[i], answer: answerData[i])
            record.append(data)
        }
    }
}

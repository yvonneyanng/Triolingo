struct JsonData: Codable {
    let id: String
    let object: String
    let created: Int
    let model: String
    let choices: [ChoiceSet]
}

struct ChoiceSet: Codable {
    let text: String
}

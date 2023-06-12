struct ChatGPTAPIKey {
    static let key = "YOUR_API_KEY"
}

struct AIModel {
    static let model = "text-davinci-003"
}

struct OpenAIBody: Encodable {
    let model: String
    let prompt: String
    let temperature = 0.0
    let max_tokens = 256
    let top_p = 1.0
    let frequency_penalty = 0.0
    let presence_penalty = 0.0
}

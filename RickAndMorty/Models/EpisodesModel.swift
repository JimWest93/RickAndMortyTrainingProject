import Foundation

class Episodes: Codable {
    
    var name: String
    var episode: String

    enum CodingKeys: String, CodingKey {
        case name
        case episode
    }

    init(name: String, episode: String) {
        self.name = name
        self.episode = episode
    }
}

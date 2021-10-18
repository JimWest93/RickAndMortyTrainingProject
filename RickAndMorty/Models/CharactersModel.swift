import Foundation

class Characters: Codable {
    var info: Info
    var results: [Result]
    
    init(info: Info, results: [Result]) {
        self.info = info
        self.results = results
    }
}

class Info: Codable {
    var count, pages: Int
    var next: String?
    var prev: String?
    
    init(count: Int, pages: Int, next: String?, prev: String?) {
        self.count = count
        self.pages = pages
        self.next = next
        self.prev = prev
    }
}

class Result: Codable {
    var id: Int
    var name: String
    var status: String
    var species: String
    var type: String
    var gender: String
    var origin, location: Location
    var image: String
    var episode: [String]
    var url: String
    var created: String
    
    init(id: Int, name: String, status: String, species: String, type: String, gender: String, origin: Location, location: Location, image: String, episode: [String], url: String, created: String) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = origin
        self.location = location
        self.image = image
        self.episode = episode
        self.url = url
        self.created = created
    }
}

class Location: Codable {
    var name: String
    var url: String
    
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}

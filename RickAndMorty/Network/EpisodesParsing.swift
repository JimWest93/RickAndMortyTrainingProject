import Foundation
import Alamofire

protocol EpisodesParsingDelegate {
    
    func episodesTableUpdate(name: String, episodeNumber: String)
    
}

class EpisodesParsing {
    
    var delegate: EpisodesParsingDelegate?
    
    func episodesParsing(url: String) {
        
        let url = url
        
        AF.request(url)
            
            .validate()
            .responseDecodable(of: Episodes.self, queue: .main) { response in
                
                guard let data = response.value
                else {return}
                self.delegate?.episodesTableUpdate(name: data.name, episodeNumber: data.episode)
                
            }
    }
}

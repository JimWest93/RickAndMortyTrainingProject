import Foundation
import Alamofire


protocol CharactersParsingDelegate {
    
    func charactersTableUpdate(charactersData: [Result], infoData: Info)
    
}


class CharactersParsing {
    
    var delegate: CharactersParsingDelegate?
    
    var url = allCharactersURL
    
    var isPagination = false
    
    func allCharactersParsing() {
        
        
        AF.request(self.url)
        
            .validate()
            .responseDecodable(of: Characters.self, queue: .main) { response in
                
                guard let data = response.value
                else {return}
                self.delegate?.charactersTableUpdate(charactersData: data.results, infoData: data.info)
                
            }
        
    }
    
    
    func parsingForPagination(url: String) {
        
        if isPagination {
            
            self.isPagination = false
            
            let url = url
            
            AF.request(url)
            
                .validate()
                .responseDecodable(of: Characters.self, queue: .main) { response in
                    
                    guard let data = response.value
                    else {return}
                    
                    DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
                        self.delegate?.charactersTableUpdate(charactersData: data.results, infoData: data.info)
                        
                    }
                }
        }
    }
    
}

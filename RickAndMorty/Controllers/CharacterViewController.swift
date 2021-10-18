import UIKit

class CharacterViewController: UIViewController {
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var episodeTable: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var firstSeenLabel: UILabel!
    @IBOutlet weak var indicatorView: UIView!
    
    var episodesURLsArray: [String] = []
    
    var characterInfo: Result?
    
    let loader = EpisodesParsing()
    
    var episodesNames: [String] = []
    var episodesNumbers: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loader.delegate = self
        episodeTable.delegate = self
        episodeTable.dataSource = self
        
        for url in episodesURLsArray {
            
            loader.episodesParsing(url: url)
            
        }
        
        setupView()
        
    }
    
    func setupView() {
        
        indicatorView.layer.cornerRadius = 5
        self.nameLabel.text = characterInfo?.name
        self.statusLabel.text = characterInfo?.status
        self.speciesLabel.text = characterInfo?.species
        self.locationLabel.text = characterInfo?.location.name
        self.genderLabel.text = "(\(characterInfo?.gender ?? ""))"
        
        switch characterInfo?.status {
        case "Alive": indicatorView.backgroundColor = .systemGreen
        case "Dead": indicatorView.backgroundColor = .systemRed
        case "unknown": indicatorView.backgroundColor = .systemOrange
        default: break
        }
        
        guard let url: URL = URL(string: characterInfo?.image ?? "") else {fatalError("Failed to load url")}
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.characterImageView.contentMode = .scaleAspectFill
                        self.characterImageView.image = image
                    }
                }
            }
            else { print("Invalid image")}
        }
    }
    
}


extension CharacterViewController: EpisodesParsingDelegate {
    func episodesTableUpdate(name: String, episodeNumber: String) {
        self.episodesNames.append(name)
        self.episodesNumbers.append(episodeNumber)
        episodeTable.reloadData()
        self.firstSeenLabel.text = episodesNames.first
    }
    
}


extension CharacterViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodesNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeCell") as! EpisodeCell
        
        cell.episodeNameLabel.text = episodesNames[indexPath.row]
        cell.episodeNumberLabel.text = episodesNumbers[indexPath.row]
        
        return cell
        
    }
}

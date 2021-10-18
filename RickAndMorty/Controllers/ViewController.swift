import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var charactersTable: UITableView!
    
    var infoData: Info?
    
    var charactersTableData: [Result] = []
    
    let loader = CharactersParsing()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        charactersTable.delegate = self
        charactersTable.dataSource = self
        loader.delegate = self
        loader.allCharactersParsing()
    }
    
    private func createSpiner() -> UIView {
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 100))
        
        let spinner = UIActivityIndicatorView()
        
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        
        return footerView
    }
    
}

extension ViewController: CharactersParsingDelegate {
    func charactersTableUpdate(charactersData: [Result], infoData: Info) {
        self.charactersTableData.append(contentsOf: charactersData)
        self.infoData = infoData
        DispatchQueue.main.async {
            self.charactersTable.reloadData()
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        charactersTableData.count 
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharactersCell") as! CharactersCell
        
        cell.initCell(data: charactersTableData[indexPath.row])
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let singleCharacterController = self.storyboard?.instantiateViewController(identifier: "SingleCharacter") as! CharacterViewController
        
        singleCharacterController.episodesURLsArray = (self.charactersTableData[indexPath.row].episode)
        
        singleCharacterController.characterInfo = self.charactersTableData[indexPath.row]
        
        self.present(singleCharacterController, animated: true, completion: nil)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if ((charactersTable.contentOffset.y + charactersTable.frame.size.height) >= charactersTable.contentSize.height - 100) && self.infoData?.next != nil
        {
            self.charactersTable.tableFooterView = createSpiner()
            print(self.infoData?.next ?? "")
            self.loader.isPagination = true
            self.loader.parsingForPagination(url: self.infoData?.next ?? "")
        } else if self.infoData?.next == nil {self.charactersTable.tableFooterView = nil}
    }
    
}

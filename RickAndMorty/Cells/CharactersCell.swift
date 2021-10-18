import UIKit

class CharactersCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var genderImage: UIImageView!
    
    @IBOutlet weak var genderLabel: UILabel!
    
    @IBOutlet weak var characterNameLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var speciesLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var indicatorView: UIView!
    
    @IBOutlet weak var characterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.indicatorView.layer.cornerRadius = 5
        self.containerView.layer.cornerRadius = 8
        self.containerView.layer.masksToBounds = true
        self.characterImageView.roundCorners(corners: [.topLeft, .bottomLeft], radius: 8)
        
    }
    
    func initCell(data: Result?) {
        
        guard let url: URL = URL(string: data?.image ?? "") else {fatalError("Failed to load url")}
        
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
        
        switch data?.status {
        case "Alive": indicatorView.backgroundColor = .systemGreen
        case "Dead": indicatorView.backgroundColor = .red
        case "unknown": indicatorView.backgroundColor = .systemOrange
        default: break
        }
        
        switch data?.gender {
        case "Female": self.genderImage.tintColor = .systemPink
        case "Male": self.genderImage.tintColor = .systemBlue
        case "unknown": self.genderImage.tintColor = .systemGray
        default: break
        }
        
        self.genderLabel.text = data?.gender //.rawValue
        self.characterNameLabel.text = data?.name
        self.statusLabel.text = data?.status
        self.speciesLabel.text = data?.species
        self.locationLabel.text = data?.location.name
        
    }
    
    
}



extension UIImageView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}




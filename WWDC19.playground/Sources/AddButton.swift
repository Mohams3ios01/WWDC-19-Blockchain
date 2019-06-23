import UIKit

class AddButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setTitle("", for: .normal)
        self.titleLabel?.textAlignment = .center
        
        self.backgroundColor = blockchainBlue
        self.layer.cornerRadius = 10
        self.setTitleColor(.white, for: .normal)
        self.titleLabel!.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

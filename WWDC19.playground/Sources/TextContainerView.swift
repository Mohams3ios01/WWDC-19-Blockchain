import UIKit

public class WhiteTextContainer: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public convenience init(label: UILabel) {
        self.init(frame: CGRect(x: 30, y: 20, width: 540, height: label.frame.height + 40))
    
        self.backgroundColor = blockchainBlue
        self.layer.cornerRadius = self.frame.height / 2
        
        label.frame = CGRect(x: 45, y: 20, width: 450, height: label.frame.height)
        label.textColor = UIColor.white
        self.addSubview(label)
    }
}

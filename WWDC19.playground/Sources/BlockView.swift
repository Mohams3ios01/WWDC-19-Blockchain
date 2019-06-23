import UIKit

// MARK: - Block View Class
public class BlockView: UIView {
    public let recipientTextField = BlockTextField(placeholder: "Recipient")
    public let senderTextField = BlockTextField(placeholder: "Sender")
    public let dataTextField = BlockTextField(placeholder: "Data")
    public let hashTextField = BlockTextField(placeholder: "Hash")
    public let previousHashField = BlockTextField(placeholder: "Previous Hash")

    let topLabel = UILabel()
        
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 10
        self.backgroundColor = blockchainBlue
        
        topLabel.text = "Block"
        topLabel.textColor = .white
        topLabel.frame = CGRect(x: 0, y: 13, width: self.frame.width, height: 25)
        topLabel.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        topLabel.textAlignment = .center
        
        senderTextField.frame = CGRect(x: 10, y: 50, width: self.frame.width - 20, height: 40)
        recipientTextField.frame = CGRect(x: 10, y: 100, width: self.frame.width - 20, height: 40)
        dataTextField.frame = CGRect(x: 10, y: 150, width: self.frame.width - 20, height: 40)
        
        addSubview(topLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func addSenderTextField(withParentView masterView: UIView) {
        UIView.animate(withDuration: 0.3) {
            let blockViewHeight: CGFloat = 100
            let blockViewWidth: CGFloat = 400
            
            self.frame = CGRect(x: masterView.frame.midX - (blockViewWidth / 2), y: masterView.frame.midY - (blockViewHeight / 2), width: blockViewWidth, height: blockViewHeight)
            
            self.fadeVewIn(view: self.senderTextField)
        }
    }
    
    public func addRecipientTextField(withParentView masterView: UIView) {
        UIView.animate(withDuration: 0.3) {
            let blockViewHeight: CGFloat = 150
            let blockViewWidth: CGFloat = 400
            
            self.frame = CGRect(x: masterView.frame.midX - (blockViewWidth / 2), y: masterView.frame.midY - (blockViewHeight / 2), width: blockViewWidth, height: blockViewHeight)
            
            self.fadeVewIn(view: self.recipientTextField)
        }
    }
    
    public func addDataTextfield(withParentView masterView: UIView) {
        UIView.animate(withDuration: 0.3) {
            let blockViewHeight: CGFloat = 200
            let blockViewWidth: CGFloat = 400
            
            self.frame = CGRect(x: masterView.frame.midX - (blockViewWidth / 2), y: masterView.frame.midY - (blockViewHeight / 2), width: blockViewWidth, height: blockViewHeight)
            
            self.fadeVewIn(view: self.dataTextField)
        }
    }
    
    public func convertToHash(withParentView masterView: UIView) {
        let sender = senderTextField.text
        let recipient = recipientTextField.text
        let data = dataTextField.text
        
        let dataCombined = sender! + recipient! + data!
        let hashedData = dataCombined.getHashValue()
        
        UIView.animate(withDuration: 0.3) {
            self.senderTextField.fadeOut()
            self.recipientTextField.fadeOut()

            let blockViewHeight: CGFloat = 150
            let blockViewWidth: CGFloat = 400
            
            self.dataTextField.frame = CGRect(x: 10, y: 50, width: self.frame.width - 20, height: 40)
            
            self.hashTextField.frame = CGRect(x: 10, y: 100, width: self.frame.width - 20, height: 40)
            self.hashTextField.text = "Hash: \(hashedData)"
            self.hashTextField.adjustsFontSizeToFitWidth = true
            
            self.frame = CGRect(x: masterView.frame.midX - (blockViewWidth / 2), y: masterView.frame.midY - (blockViewHeight / 2), width: blockViewWidth, height: blockViewHeight)
            
            self.fadeVewIn(view: self.hashTextField)
        }
    }
    
    public func addSecondBlockViewFormat(withParentView masterView: UIView) {
        let sender = "Test Sender"
        let recipient = "Test Recipient"
        let data = "Data: 12 BTC"
        
        let dataCombined = sender + recipient + data
        let hashedData = dataCombined.getHashValue()
        
        UIView.animate(withDuration: 0.3) {
            self.senderTextField.fadeOut()
            self.recipientTextField.fadeOut()
            
            let blockViewHeight: CGFloat = 150
            let blockViewWidth: CGFloat = 400
            
            self.dataTextField.frame = CGRect(x: 10, y: 50, width: self.frame.width - 20, height: 40)
            self.dataTextField.text = data
            
            self.hashTextField.frame = CGRect(x: 10, y: 100, width: self.frame.width - 20, height: 40)
            self.hashTextField.text = "Hash: \(hashedData)"
            self.hashTextField.adjustsFontSizeToFitWidth = true
            
            self.frame = CGRect(x: masterView.frame.midX - (blockViewWidth / 2), y: masterView.frame.midY + 95, width: blockViewWidth, height: blockViewHeight)
            
            self.fadeVewIn(view: self.dataTextField)
            self.fadeVewIn(view: self.hashTextField)
        }
    }
    
    public func addThirdPreviousHashField(withParentView masterView: UIView) {
        previousHashField.backgroundColor = lightGreen
        
        let blockViewHeight: CGFloat = 200
        let blockViewWidth: CGFloat = 400
        
        UIView.animate(withDuration: 0.3) {
            self.frame = CGRect(x: masterView.frame.midX - (blockViewWidth / 2), y: masterView.frame.midY + 95, width: blockViewWidth, height: blockViewHeight)
            
            self.previousHashField.frame = CGRect(x: 10, y: 150, width: self.frame.width - 20, height: 40)
            self.fadeVewIn(view: self.previousHashField)
        }
    }
}


// MARK: - Block Text Field Class
public class BlockTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = darkerBlockchainBlue
        
        self.textColor = UIColor.white
        self.layer.cornerRadius = 5
        self.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        self.attributedPlaceholder = NSAttributedString(string: "Recipient", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.7), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .semibold)])
        self.textAlignment = .center
    }
    
    public convenience init(placeholder: String) {
        self.init()
        
        self.backgroundColor = darkerBlockchainBlue
        
        self.textColor = UIColor.white
        self.layer.cornerRadius = 5
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.7), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .semibold)])
        self.textAlignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

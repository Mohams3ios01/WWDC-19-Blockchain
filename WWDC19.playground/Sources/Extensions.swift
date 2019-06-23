import UIKit
import SpriteKit
import CommonCrypto

// MARK: - UILabel Extension
extension UILabel {
    public convenience init(text: String, font: UIFont = UIFont.systemFont(ofSize: 80, weight: .bold), center: Bool = false, width: CGFloat = 560) {
        self.init()
        
        let height = heightForView(text: text, font: font, width: width)
        
        if center {
            self.frame = CGRect(x: 20, y: 800/2 - (height/2), width: 560, height: height)
            self.textAlignment = .center
        } else {
            self.frame = CGRect(x: 20, y: 800-height-20, width: 560, height: height)
        }
        
        // Assign extra values
        self.textColor = UIColor.blue
        self.text = text
        self.numberOfLines = 0
        self.font = font
    }
    
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
    }
}

// MARK: - UIView Extension
extension UIView {
    public func fadeOut() {
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 0.0
        }) { (success) in
            self.removeFromSuperview()
        }
    }
    
    public func fadeIn(toAlpha customAlpha: CGFloat = 1.0) {
        UIView.animate(withDuration: 0.5) {
            self.alpha = customAlpha
        }
    }
    
    public func fadeVewIn(view: UIView) {
        view.alpha = 0.0
        self.addSubview(view)
        
        UIView.animate(withDuration: 0.5) {
            view.alpha = 1.0
        }
    }
}

// MARK: - SKSpriteNode Extension
extension SKSpriteNode {
    public func walkLeft(completion: @escaping () -> Void) {
        let actionUp = SKAction.moveBy(x: -20, y: 10, duration: 0.3)
        let actionDown = SKAction.moveBy(x: -20, y: -10, duration: 0.3)
        
        let sequenceAction = SKAction.sequence([actionUp, actionDown])
        
        self.run(SKAction.repeat(sequenceAction, count: 5)) {
            completion()
        }
    }
    
    public func walkRight() {
        let actionUp = SKAction.moveBy(x: 20, y: 10, duration: 0.3)
        let actionDown = SKAction.moveBy(x: 20, y: -10, duration: 0.3)
        
        let sequenceAction = SKAction.sequence([actionUp, actionDown])
        
        self.run(SKAction.repeat(sequenceAction, count: 5))
    }
    
    public func flipAndWalkLeft(completion: @escaping () -> Void = {}) {
        self.xScale = self.xScale * -1
        
        let actionUp = SKAction.moveBy(x: -20, y: 10, duration: 0.3)
        let actionDown = SKAction.moveBy(x: -20, y: -10, duration: 0.3)
        
        let sequenceAction = SKAction.sequence([actionUp, actionDown])
        
        self.run(SKAction.repeat(sequenceAction, count: 5)) {
            completion()
        }
    }
    
    public func flipAndWalkRight() {
        self.xScale = self.xScale * -1
        
        let actionUp = SKAction.moveBy(x: 20, y: 10, duration: 0.3)
        let actionDown = SKAction.moveBy(x: 20, y: -10, duration: 0.3)
        
        let sequenceAction = SKAction.sequence([actionUp, actionDown])
        
        self.run(SKAction.repeat(sequenceAction, count: 5))
    }
    
    public func bounceInPlace() {
        let actionUp = SKAction.moveBy(x: 0, y: 10, duration: 0.2)
        let actionDown = SKAction.moveBy(x: 0, y: -10, duration: 0.2)
        
        let sequence = SKAction.sequence([actionUp, actionDown])
        sequence.timingMode = .easeIn
        
        self.run(SKAction.repeatForever(sequence))
    }
}

extension UITextView {
    func typeOn(string: String) {
        let characterArray = string.characterArray
        var characterIndex = 0
        
        Timer.scheduledTimer(withTimeInterval: 0.06, repeats: true) { (timer) in
            self.text.append(characterArray[characterIndex])
            characterIndex += 1
            if characterIndex == characterArray.count {
                timer.invalidate()
            }
        }
    }
}

extension String {
    var characterArray: [Character] {
        var characterArray = [Character]()
        
        for character in self {
            characterArray.append(character)
        }
        
        return characterArray
    }
    
    public func getHashValue() -> String {
        let data = self.data(using: .utf8)!
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA512_DIGEST_LENGTH))
        data.withUnsafeBytes({
            _ = CC_SHA512($0, CC_LONG(data.count), &digest)
        })
        return digest.map({ String(format: "%02hhx", $0) }).joined(separator: "")
    }
}

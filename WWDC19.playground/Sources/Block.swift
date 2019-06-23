import UIKit

public class Block {
    // MARK: - Variables
    var data: String?
    
    var senderHash: String?
    var recipientHash: String?
    
    var dataHash: String?
    var previousHash: String?
    
    // MARK: - Convenience Initialization
    public convenience init(sender: String, recipient: String, data: String, previousHash: String) {
        self.init()
        
        self.senderHash = sender.getHashValue()
        self.recipientHash = recipient.getHashValue()
        
        self.data = data
        self.previousHash = previousHash
        
        self.dataHash = data.getHashValue()
        self.previousHash = previousHash
    }

    // MARK: - Individual Update Methods
    public func updateData(string: String) {
        self.data = string
        self.dataHash = string.getHashValue()
    }
    
    public func setPreviousHash(previousHash: String) {
        self.previousHash = previousHash
    }
}


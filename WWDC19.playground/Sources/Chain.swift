import UIKit

public class Chain {
    static var instance = Chain()
    
    var currentChain: [Block] = []
    
    public func addToCurrentChain(block: Block) {
        currentChain.append(block)
    }
}


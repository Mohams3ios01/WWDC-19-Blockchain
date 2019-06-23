import UIKit
import SpriteKit
import AVFoundation

public class MainScene: SKScene {
    
    var player: AVAudioPlayer?
    var subPlayer: AVAudioPlayer?
    var backgroundPlayer: AVAudioPlayer?
    
    public override func didMove(to view: SKView) {
        let cameraNode = SKCameraNode()
        self.camera = cameraNode
    }
    
    // Calculates height for labele
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
    }
    
    // MARK: - History of Transactions
    // This plays the first part
    public func historyOfTransactions(withParentView masterView: UIView, completion: @escaping () -> () = {}) {
        
        let backgroundPath = Bundle.main.path(forResource: "BackgroundMusic.mp3", ofType:nil)!
        let backgroundURL = URL(fileURLWithPath: backgroundPath)
        
        do {
            try! AVAudioSession.sharedInstance().setCategory(.playback, mode: AVAudioSession.Mode.spokenAudio)
            self.backgroundPlayer = try AVAudioPlayer(contentsOf: backgroundURL)
            self.backgroundPlayer?.numberOfLoops = 2
            self.backgroundPlayer?.play()
        } catch {
            print("Failed to load audio file")
        }
        
        let graphNode = self.childNode(withName: "Graph")
        graphNode?.alpha = 0.0
        
        let passiveAction = SKAction.moveBy(x: -((graphNode?.frame.width)!), y: 0, duration: 1)
        
        let height = heightForView(text: "The\nBlockchain", font: UIFont.systemFont(ofSize: 80, weight: .bold), width: 560)
        
        let label = UILabel(frame: CGRect(x: 20, y: 800-height-20, width: 560, height: height))
        label.text = "The\nBlockchain";
        label.numberOfLines = 2
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 80, weight: .bold)
        
        masterView.addSubview(label)
        
        let path = Bundle.main.path(forResource: "Blockchain-1.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            try! AVAudioSession.sharedInstance().setCategory(.playback, mode: AVAudioSession.Mode.spokenAudio)
            self.player = try AVAudioPlayer(contentsOf: url)
            self.player?.setVolume(4, fadeDuration: 0)
            self.player?.play()
        } catch {
            print("Failed to load audio file")
        }
        
        // Show graph of Bitcoin and explains trend (voiceover)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            UIView.animate(withDuration: 0.5, animations: {
                label.alpha = 0.0
                graphNode?.alpha = 1
            }, completion: { (success) in
                graphNode?.run(passiveAction)
                
                let height = self.heightForView(text: "Bitcoin", font: UIFont.systemFont(ofSize: 80, weight: .bold), width: 560)
                
                let label = UILabel(frame: CGRect(x: 20, y: 10, width: 560, height: height))
                label.text = "Bitcoin";
                label.numberOfLines = 2
                label.textColor = .white
                label.font = UIFont.systemFont(ofSize: 80, weight: .bold)
                
                masterView.addSubview(label)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                    label.text = "How does it work?"
                    
                    let newHeight = self.heightForView(text: "How does it work?", font: UIFont.systemFont(ofSize: 80, weight: .bold), width: 560)
                    
                    label.frame = CGRect(x: 20, y: 10, width: 560, height: newHeight)
                })
                
                // Transition to "A Really Long Time Ago" background
                DispatchQueue.main.asyncAfter(deadline: .now() + 12.5, execute: {
                    UIView.animate(withDuration: 0.5, animations: {
                        label.alpha = 0.0
                        graphNode?.run(SKAction.fadeOut(withDuration: 0.4))
                        self.backgroundColor = UIColor.black
                        
                        let path = Bundle.main.path(forResource: "Blockchain-2.mp3", ofType:nil)!
                        let url = URL(fileURLWithPath: path)
                        
                        do {
                            try! AVAudioSession.sharedInstance().setCategory(.playback, mode: AVAudioSession.Mode.spokenAudio)
                            self.player = try AVAudioPlayer(contentsOf: url)
                            self.player?.play()
                        } catch {
                            print("Failed to load audio file")
                        }
                        
                        let texture = SKTexture(image: UIImage(named: "sky")!)
                        let sky = SKSpriteNode(texture: texture)
                        sky.setScale(2)
                        
                        let zoomAction = SKAction.scale(to: 1, duration: 1.5)
                        
                        self.addChild(sky)
                        
                        let cfURL = Bundle.main.url(forResource: "Starjhol", withExtension: "ttf")! as CFURL
                        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
                        
                        let cfURL2 = Bundle.main.url(forResource: "Starjedi", withExtension: "ttf")! as CFURL
                        CTFontManagerRegisterFontsForURL(cfURL2, CTFontManagerScope.process, nil)
                        
                        if let font = UIFont(name: "Star Jedi Hollow", size: 80) {
                            
                            let label = UILabel(text: "a really long time ago", font: font, center: true)
                            label.textAlignment = .center
                            label.textColor = starWars
                            
                            masterView.addSubview(label)
                            
                            sky.run(zoomAction)
                            
                            // Transition to the forest environment (941 BC)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                                let natureTexture = SKTexture(image: UIImage(named: "Nature")!)
                                let nature = SKSpriteNode(texture: natureTexture)
                                
                                nature.size = CGSize(width: 1700, height: 800)
                                nature.position = CGPoint(x: 400, y: 0)
                                
                                self.removeAllChildren()
                                self.addChild(nature)
                                
                                let path = Bundle.main.path(forResource: "Forest.mp3", ofType:nil)!
                                let url = URL(fileURLWithPath: path)

                                do {
                                    try! AVAudioSession.sharedInstance().setCategory(.playback, mode: AVAudioSession.Mode.spokenAudio)
                                    self.subPlayer = try AVAudioPlayer(contentsOf: url)
                                    self.subPlayer?.setVolume(0.3, fadeDuration: 0)
                                    self.subPlayer?.play()
                                } catch {
                                    print("Failed to load audio file")
                                }
                                
                                if let font = UIFont(name: "Star Jedi", size: 80) {
                                    label.text = "941 bc"
                                    label.font = font
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                                    label.fadeOut()
                                    
                                    let panAction = SKAction.moveBy(x: -600, y: 0, duration: 2.5)
                                    panAction.timingMode = SKActionTimingMode.easeInEaseOut
                                    
                                    nature.run(panAction, completion: {
                                        let leftPersonTexture = SKTexture(image: UIImage(named: "left-person")!)
                                        let leftPerson = SKSpriteNode(texture: leftPersonTexture)
                                        
                                        let rightPersonTexture = SKTexture(image: UIImage(named: "right-person")!)
                                        let rightPerson = SKSpriteNode(texture: rightPersonTexture)
                                        
                                        leftPerson.setScale(0.15)
                                        leftPerson.position = CGPoint(x: -360, y: -250)
                                        
                                        rightPerson.setScale(0.15)
                                        rightPerson.position = CGPoint(x: 360, y: -250)

                                        self.addChild(leftPerson)
                                        self.addChild(rightPerson)
                                        
                                        leftPerson.walkRight()
                                        rightPerson.walkLeft {
                                            
                                            let natureLabel = UILabel(text: "One-to-one transactions", font: UIFont.systemFont(ofSize: 30, weight: .bold), center: false)
                                            
                                            let natureContainerView = WhiteTextContainer(label: natureLabel)
                                            
                                            masterView.fadeVewIn(view: natureContainerView)
                                            
                                            let metalTexture = SKTexture(imageNamed: "metal")
                                            let metal = SKSpriteNode(texture: metalTexture)
                                            
                                            metal.setScale(0.4)
                                            
                                            self.addChild(metal)
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.4, execute: {
                                                
                                                metal.run(SKAction.fadeOut(withDuration: 0.3))
                                                
                                                let woodTexture = SKTexture(imageNamed: "wood")
                                                let wood = SKSpriteNode(texture: woodTexture)
                                                
                                                wood.setScale(0.4)
                                                
                                                self.addChild(wood)
                                                
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.4, execute: {
                                                    
                                                    wood.run(SKAction.fadeOut(withDuration: 0.3))
                                                    
                                                    natureContainerView.fadeOut()
                                                    natureContainerView.removeFromSuperview()
                                                    
                                                    rightPerson.flipAndWalkRight()
                                                    leftPerson.flipAndWalkLeft {
                                                        
                                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                                                            
                                                            let path = Bundle.main.path(forResource: "Blockchain-3.mp3", ofType:nil)!
                                                            let url = URL(fileURLWithPath: path)
                                                            
                                                            do {
                                                                try! AVAudioSession.sharedInstance().setCategory(.playback, mode: AVAudioSession.Mode.spokenAudio)
                                                                self.player = try AVAudioPlayer(contentsOf: url)
                                                                self.player?.play()
                                                            } catch {
                                                                print("Failed to load audio file")
                                                            }
                                                            
                                                            nature.run(SKAction.fadeOut(withDuration: 0.4), completion: {
                                                                self.removeAllChildren()
                                                                
                                                                let kingdomTexture = SKTexture(imageNamed: "Kingdom")
                                                                let kingdom = SKSpriteNode(texture: kingdomTexture)
                                                                
                                                                kingdom.size = CGSize(width: 1700, height: 800)
                                                                kingdom.position = CGPoint(x: 400, y: 0)
                                                                
                                                                self.addChild(kingdom)
                                                                
                                                                kingdom.run(panAction, completion: {
                                                                    let kingdomLabel = UILabel(text: "Rulers are needed to enforce rules as trade networks grow", font: UIFont.systemFont(ofSize: 30, weight: .bold), center: false, width: 450)
                                                                    
                                                                    let kingdomContainerView = WhiteTextContainer(label: kingdomLabel)
                                                                    
                                                                    masterView.fadeVewIn(view: kingdomContainerView)
                                                                    
                                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 9.0, execute: {
                                                                        kingdomContainerView.fadeOut()
                                                                        
                                                                        kingdom.run(SKAction.fadeOut(withDuration: 0.7), completion: {
                                                                            
                                                                            let path = Bundle.main.path(forResource: "Blockchain-4.mp3", ofType:nil)!
                                                                            let url = URL(fileURLWithPath: path)
                                                                            
                                                                            do {
                                                                                try! AVAudioSession.sharedInstance().setCategory(.playback, mode: AVAudioSession.Mode.spokenAudio)
                                                                                self.player = try AVAudioPlayer(contentsOf: url)
                                                                                self.player?.play()
                                                                            } catch {
                                                                                print("Failed to load audio file")
                                                                            }
                                                                            
                                                                            kingdomContainerView.removeFromSuperview()
                                                                            self.removeAllChildren()
                                                                            
                                                                            let presentTexture = SKTexture(imageNamed: "Present")
                                                                            let present = SKSpriteNode(texture: presentTexture)
                                                                            
                                                                            present.size = CGSize(width: 1700, height: 800)
                                                                            present.position = CGPoint(x: 400, y: 0)
                                                                            
                                                                            self.addChild(present)
                                                                            
                                                                            let smallerPanAction = SKAction.moveBy(x: -150, y: 0, duration: 2.5)
                                                                            smallerPanAction.timingMode = SKActionTimingMode.easeInEaseOut
                                                                            
                                                                            present.run(smallerPanAction, completion: {
                                                                                let presentLabel = UILabel(text: "We are more networked than ever before", font: UIFont.systemFont(ofSize: 30, weight: .bold), center: false, width: 450)
                                                                                
                                                                                let presentLabelView = WhiteTextContainer(label: presentLabel)
                                                                                presentLabelView.layer.zPosition = 999
                                                                                
                                                                                masterView.fadeVewIn(view: presentLabelView)
                                                                                
                                                                                DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                                                                                    let blackView = UIView(frame: masterView.frame)
                                                                                    blackView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
                                                                                    
                                                                                    masterView.fadeVewIn(view: blackView)
                                                                                    
                                                                                    let listLabel = UILabel(text: "Apps\nWebsites\nOnline Stores\nGames\nServices\nBusinesses\nPersonal Transactions", font: UIFont.systemFont(ofSize: 40, weight: .bold), center: false, width: 450)
                                                                                    listLabel.alpha = 0
                                                                                    listLabel.frame = CGRect(x: 75, y: presentLabelView.frame.height + 30, width: 450, height: listLabel.frame.height)
                                                                                    listLabel.textColor = UIColor.white
                                                                                    
                                                                                    masterView.addSubview(listLabel)
                                                                                    listLabel.fadeIn(toAlpha: 0.8)
                                                                                    
                                                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 9.0, execute: {
                                                                                        listLabel.fadeOut()
                                                                                        presentLabelView.fadeOut()
                                                                                        blackView.fadeOut()
                                                                                        
                                                                                        present.run(SKAction.fadeOut(withDuration: 0.8), completion: {
                                                                                            self.removeAllChildren()
                                                                                            
                                                                                            let path = Bundle.main.path(forResource: "Blockchain-5.mp3", ofType:nil)!
                                                                                            let url = URL(fileURLWithPath: path)
                                                                                            
                                                                                            do {
                                                                                                try! AVAudioSession.sharedInstance().setCategory(.playback, mode: AVAudioSession.Mode.spokenAudio)
                                                                                                self.player = try AVAudioPlayer(contentsOf: url)
                                                                                                self.player?.play()
                                                                                            } catch {
                                                                                                print("Failed to load audio file")
                                                                                            }
                                                                                            
                                                                                            let middlemanTexture = SKTexture(imageNamed: "Middleman")
                                                                                            let middleman = SKSpriteNode(texture: middlemanTexture)
                                                                                            
                                                                                            middleman.size = CGSize(width: 1700, height: 800)
                                                                                            middleman.position = CGPoint(x: 400, y: 0)
                                                                                            
                                                                                            self.addChild(middleman)
                                                                                            
                                                                                            let middlemanPanAction = SKAction.moveBy(x: -300, y: 0, duration: 2.5)
                                                                                            middlemanPanAction.timingMode = SKActionTimingMode.easeInEaseOut
                                                                                            
                                                                                            middleman.run(middlemanPanAction, completion: {
                                                                                                let middlemanLabel = UILabel(text: "Middlemen act as intermedaries between peoples transactions", font: UIFont.systemFont(ofSize: 30, weight: .bold), center: false, width: 450)
                                                                                                
                                                                                                let middlemanContainerView = WhiteTextContainer(label: middlemanLabel)
                                                                                                
                                                                                                masterView.fadeVewIn(view: middlemanContainerView)
                                                                                                DispatchQueue.main.asyncAfter(deadline: .now() + 18, execute: {
                                                                                                    middleman.run(SKAction.fadeOut(withDuration: 0.8), completion: {
                                                                                                        middlemanContainerView.fadeOut()
                                                                                                        middlemanContainerView.removeFromSuperview()
                                                                                                        
                                                                                                        let path = Bundle.main.path(forResource: "Blockchain-6.mp3", ofType:nil)!
                                                                                                        let url = URL(fileURLWithPath: path)

                                                                                                        do {
                                                                                                            try! AVAudioSession.sharedInstance().setCategory(.playback, mode: AVAudioSession.Mode.spokenAudio)
                                                                                                            self.player = try AVAudioPlayer(contentsOf: url)
                                                                                                            self.player?.play()
                                                                                                        } catch {
                                                                                                            print("Failed to load audio file")
                                                                                                        }
                                                                                                        
                                                                                                        self.removeAllChildren()
                                                                                                        
                                                                                                        let label = UILabel(text: "Blockchain", font: UIFont.systemFont(ofSize: 50, weight: .bold), center: true)
                                                                                                        label.textColor = UIColor.white
                                                                                                        
                                                                                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                                                                                                            masterView.addSubview(label)
                                                                                                            
                                                                                                            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                                                                                                                let textView = UITextView(frame: CGRect(x: 40, y: 450, width: 520, height: 400))
                                                                                                                textView.font = UIFont.systemFont(ofSize: 40, weight: .bold)
                                                                                                                textView.textColor = UIColor.white.withAlphaComponent(0.6)
                                                                                                                textView.backgroundColor = UIColor.clear
                                                                                                                textView.textAlignment = .center
                                                                                                                
                                                                                                                masterView.addSubview(textView)
                                                                                                                
                                                                                                                textView.typeOn(string: "Maybe..... Let's take a look at how it looks first.")
                                                                                                                
                                                                                                                DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: {
                                                                                                                    textView.fadeOut()
                                                                                                                    label.fadeOut()
                                                    
                                                                                                                    completion()
                                                                                                                })
                                                                                                            })
                                                                                                        })
                                                                                                    })
                                                                                                })
                                                                                            })
                                                                                        })
                                                                                    })
                                                                                })
                                                                            })
                                                                        })
                                                                    })
                                                                })
                                                            })
                                                        })
                                                    }
                                                })
                                            })
                                        }
                                    })
                                })
                            })
                        }
                    })
                })
            })
        }
    }
    
    var blockView: BlockView!
    var masterView: UIView!
    
    var addSenderLabel: UILabel!
    var addSenderButton: AddButton!
    
    var addRecipientLabel: UILabel!
    var addRecipientButton: AddButton!
    
    var addDataLabel: UILabel!
    var addDataButton: AddButton!
    
    var encryptLabel: UILabel!
    var encryptButton: AddButton!
    
    var blockViewHeight: CGFloat = 50
    var blockViewWidth: CGFloat = 400
       
    var secondBlockView: BlockView!
    
    // MARK: - Interactive Tutorial Method
    // Plays the interactive (second) part of the playground
    public func blockchainTutorial(withParentView masterView: UIView, completion: @escaping () -> () = {}) {
        
        self.backgroundColor = UIColor(red: 232/255, green: 243/255, blue: 255/255, alpha: 1)
       
        self.masterView = masterView
        
        let path = Bundle.main.path(forResource: "Tutorial-1.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            try! AVAudioSession.sharedInstance().setCategory(.playback, mode: AVAudioSession.Mode.spokenAudio)
            self.player = try AVAudioPlayer(contentsOf: url)
            self.player?.play()
        } catch {
            print("Failed to load audio file")
        }
        
        blockView = BlockView(frame: CGRect(x: masterView.frame.midX - (blockViewWidth / 2), y: masterView.frame.midY - (blockViewHeight / 2), width: blockViewWidth, height: blockViewHeight))
        blockView.topLabel.text = "Block #1 (GENISIS BLOCK)"
        
        masterView.fadeVewIn(view: blockView)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            
            let path = Bundle.main.path(forResource: "Tutorial-2.mp3", ofType:nil)!
            let url = URL(fileURLWithPath: path)
            
            do {
                try! AVAudioSession.sharedInstance().setCategory(.playback, mode: AVAudioSession.Mode.spokenAudio)
                self.player = try AVAudioPlayer(contentsOf: url)
                self.player?.play()
            } catch {
                print("Failed to load audio file")
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 7) {

                self.blockView.addSenderTextField(withParentView: masterView)
                
                self.addSenderLabel = UILabel(text: "Add Sender:\nJohn Appleseed", font: UIFont.systemFont(ofSize: 30, weight: .semibold), center: false, width: self.blockViewWidth)
                self.addSenderLabel.frame = CGRect(x: self.addSenderLabel.frame.minX, y: self.addSenderLabel.frame.midY - 110, width: self.addSenderLabel.frame.width, height: self.addSenderLabel.frame.height)
                self.addSenderLabel.textColor = .black
                self.addSenderLabel.textAlignment = .center
                masterView.fadeVewIn(view: self.addSenderLabel)
                
                self.addSenderButton = AddButton(frame: CGRect(x: masterView.frame.midX - (180 / 2), y: 720, width: 180, height: 60))
                self.addSenderButton.setTitle("Add Sender", for: .normal)
                self.addSenderButton.addTarget(self, action: #selector(self.addSender), for: .touchUpInside)
                
                masterView.fadeVewIn(view: self.addSenderButton)
                
            }
        }
    }
    
    @objc func addSender() {
        blockView.senderTextField.text = "From: John Appleseed"
        
        addSenderButton.fadeOut()
        addSenderLabel.fadeOut()
        
        let path = Bundle.main.path(forResource: "Tutorial-3.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            try! AVAudioSession.sharedInstance().setCategory(.playback, mode: AVAudioSession.Mode.spokenAudio)
            self.player = try AVAudioPlayer(contentsOf: url)
            self.player?.play()
        } catch {
            print("Failed to load audio file")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.blockView.addRecipientTextField(withParentView: self.masterView)
            
            self.addRecipientLabel = UILabel(text: "Add Recipient:\nBob Burner", font: UIFont.systemFont(ofSize: 30, weight: .semibold), center: false, width: self.blockViewWidth)
            self.addRecipientLabel.frame = CGRect(x: self.addRecipientLabel.frame.minX, y: self.addRecipientLabel.frame.midY - 110, width: self.addRecipientLabel.frame.width, height: self.addRecipientLabel.frame.height)
            self.addRecipientLabel.textColor = .black
            self.addRecipientLabel.textAlignment = .center
            
            self.addRecipientButton = AddButton(frame: CGRect(x: self.masterView.frame.midX - (180 / 2), y: 720, width: 180, height: 60))
            self.addRecipientButton.setTitle("Add Recipient", for: .normal)
            self.addRecipientButton.addTarget(self, action: #selector(self.addRecipient), for: .touchUpInside)
            
            self.masterView.fadeVewIn(view: self.addRecipientLabel)
            self.masterView.fadeVewIn(view: self.addRecipientButton)
        }
    }
    
    @objc func addRecipient() {
        blockView.recipientTextField.text = "To: Bob Burner"
        
        addRecipientLabel.fadeOut()
        addRecipientButton.fadeOut()
        
        let path = Bundle.main.path(forResource: "Tutorial-4.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            try! AVAudioSession.sharedInstance().setCategory(.playback, mode: AVAudioSession.Mode.spokenAudio)
            self.player = try AVAudioPlayer(contentsOf: url)
            self.player?.play()
        } catch {
            print("Failed to load audio file")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 9) {
            self.blockView.addDataTextfield(withParentView: self.masterView)
            
            self.addDataLabel = UILabel(text: "Add Transaction:\n10 BTC", font: UIFont.systemFont(ofSize: 30, weight: .semibold), center: false, width: self.blockViewWidth)
            self.addDataLabel.frame = CGRect(x: self.addDataLabel.frame.minX, y: self.addDataLabel.frame.midY - 110, width: self.addDataLabel.frame.width, height: self.addDataLabel.frame.height)
            self.addDataLabel.textColor = .black
            self.addDataLabel.textAlignment = .center
            
            self.addDataButton = AddButton(frame: CGRect(x: self.masterView.frame.midX - (180 / 2), y: 720, width: 180, height: 60))
            self.addDataButton.setTitle("Add Data", for: .normal)
            self.addDataButton.addTarget(self, action: #selector(self.addData), for: .touchUpInside)
            
            self.masterView.fadeVewIn(view: self.addDataLabel)
            self.masterView.fadeVewIn(view: self.addDataButton)
        }
    }
    
    @objc func addData() {
        blockView.dataTextField.text = "Data: 10 BTC"
        
        addDataLabel.fadeOut()
        addDataButton.fadeOut()
        
        let path = Bundle.main.path(forResource: "Tutorial-5.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            try! AVAudioSession.sharedInstance().setCategory(.playback, mode: AVAudioSession.Mode.spokenAudio)
            self.player = try AVAudioPlayer(contentsOf: url)
            self.player?.play()
        } catch {
            print("Failed to load audio file")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
            self.encryptLabel = UILabel(text: "Encrypt/Hash Data", font: UIFont.systemFont(ofSize: 30, weight: .semibold), center: false, width: self.blockViewWidth)
            self.encryptLabel.frame = CGRect(x: self.encryptLabel.frame.minX, y: self.encryptLabel.frame.midY - 110, width: self.encryptLabel.frame.width, height: self.encryptLabel.frame.height)
            self.encryptLabel.textColor = .black
            self.encryptLabel.textAlignment = .center
            
            self.encryptButton = AddButton(frame: CGRect(x: self.masterView.frame.midX - (180 / 2), y: 720, width: 180, height: 60))
            self.encryptButton.setTitle("Hash", for: .normal)
            self.encryptButton.addTarget(self, action: #selector(self.encrypt), for: .touchUpInside)
            
            self.masterView.fadeVewIn(view: self.encryptLabel)
            self.masterView.fadeVewIn(view: self.encryptButton)
        }
    }
    
    @objc func encrypt() {
        blockView.convertToHash(withParentView: masterView)
        
        encryptButton.fadeOut()
        encryptLabel.fadeOut()
        
        let path = Bundle.main.path(forResource: "Tutorial-6.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            try! AVAudioSession.sharedInstance().setCategory(.playback, mode: AVAudioSession.Mode.spokenAudio)
            self.player = try AVAudioPlayer(contentsOf: url)
            self.player?.play()
        } catch {
            print("Failed to load audio file")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            
            let path = Bundle.main.path(forResource: "Tutorial-7.mp3", ofType:nil)!
            let url = URL(fileURLWithPath: path)
            
            do {
                try! AVAudioSession.sharedInstance().setCategory(.playback, mode: AVAudioSession.Mode.spokenAudio)
                self.player = try AVAudioPlayer(contentsOf: url)
                self.player?.play()
            } catch {
                print("Failed to load audio file")
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
                self.blockView.topLabel.text = "Block #1"
                
                self.secondBlockView = BlockView(frame: CGRect(x: self.masterView.frame.midX - (self.blockViewWidth / 2), y: self.masterView.frame.midY + 95, width: self.blockViewWidth, height: self.blockViewHeight))
                
                self.secondBlockView.topLabel.text = "Block #2"
                self.secondBlockView.addSecondBlockViewFormat(withParentView: self.masterView)
                self.secondBlockView.backgroundColor = blockchainBlue.withAlphaComponent(0.8)
                self.masterView.fadeVewIn(view: self.secondBlockView)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: {
                    self.secondBlockView.addThirdPreviousHashField(withParentView: self.masterView)
                    self.secondBlockView.previousHashField.text = "Previous " + self.blockView.hashTextField.text!
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                        let path = Bundle.main.path(forResource: "Tutorial-8.mp3", ofType:nil)!
                        let url = URL(fileURLWithPath: path)
                        
                        do {
                            try! AVAudioSession.sharedInstance().setCategory(.playback, mode: AVAudioSession.Mode.spokenAudio)
                            self.player = try AVAudioPlayer(contentsOf: url)
                            self.player?.play()
                        } catch {
                            print("Failed to load audio file")
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                            self.blockView.dataTextField.text = "Data: 20 BTC"
                            
                            let sender = "From: John Appleseed"
                            let recipient = "To: Bob Burner"
                            let data = "20 BTC"
                            
                            let combinedData = sender + recipient + data
                            let hashedValue = combinedData.getHashValue()
                            
                            self.blockView.hashTextField.text = "Hash: " + hashedValue
                            
                            UIView.animate(withDuration: 0.4, animations: {
                                self.secondBlockView.previousHashField.backgroundColor = darkRed
                            })
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 17, execute: {
                                let path = Bundle.main.path(forResource: "Tutorial-9.mp3", ofType:nil)!
                                let url = URL(fileURLWithPath: path)
                                
                                do {
                                    try! AVAudioSession.sharedInstance().setCategory(.playback, mode: AVAudioSession.Mode.spokenAudio)
                                    self.player = try AVAudioPlayer(contentsOf: url)
                                    self.player?.play()
                                } catch {
                                    print("Failed to load audio file")
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 24, execute: {
                                    self.blockView.fadeOut()
                                    self.secondBlockView.fadeOut()
                                    
                                    self.backgroundPlayer?.setVolume(0, fadeDuration: 2)
                                    let label = UILabel(text: "Thank you for listening!", font: UIFont.systemFont(ofSize: 22, weight: .bold), center: true, width: 400)
                                    label.textColor = UIColor.black
                                    
                                    self.masterView.fadeVewIn(view: label)
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                                        label.fadeOut()
                                    })
                                })
                            })
                        })
                    })
                })
            }
        }
    }
}

//
//  FightViewController.swift
//  Happy
//
//  Created by 楊信之 on 10/2/16.
//  Copyright © 2016 楊信之. All rights reserved.
//

import UIKit
import AudioKit


class FightViewController: UIViewController {

    
    @IBOutlet weak var theHurt: UIImageView!
    @IBOutlet weak var theGoast: UIImageView!
    @IBOutlet weak var theBigAmulet: UIImageView!

    @IBOutlet weak var theHPText: UILabel!
    @IBOutlet weak var hpProgress: UIProgressView!
    
    
    var mic: AKMicrophone?
    var tracker: AKFrequencyTracker?
    var silence: AKBooster?
    
    var button : UIButton?
    let attackNumber = 0.1 as Float
    var nowF : Double! = 0
    var count : Int! = 0
    var didBlink : Bool = false
    var Beats  : Int = 10
    
    var music : MusicHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.hpProgress.progress = 1
        let image = UIImage(named: "Amulet.png")
        self.theBigAmulet.alpha = 0
        print("1")
        self.theGoast = UIImageView(image: UIImage(named: "monster0") )
        self.theHurt.alpha = 0
        
        print("2")
        self.button = UIButton()
        self.button?.frame = CGRect(x: 360, y: 800, width: 70, height: 150)
        self.button?.setImage(image, for: .normal)
//        self.button?.addTarget(self, action: #selector(self.attack), for: .touchUpInside)
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressGesture(sender:)))
        self.button?.addGestureRecognizer(longPress)
        
        self.view.addSubview(self.button!)
        
        print("3")
        // Audio Setting
        AKSettings.audioInputEnabled = true
        print("4")
        mic = AKMicrophone()
        print("5")
        tracker = AKFrequencyTracker.init(mic!)
        print("6")
        silence = AKBooster(tracker!, gain: 0)
        
        // audio
        self.music = MusicHandler.sharedInstance
        self.music?.changeMusic(name: "Battle_music")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //
        super.viewWillAppear(animated)
        AudioKit.output = silence
        AudioKit.start()
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.getPower), userInfo: nil, repeats: true)
    }
    
    func getPower(){
//        print("ldsjfsld >>> \(tracker!.amplitude * 10)")
        self.nowF = tracker!.amplitude * 10
        
        self.count = self.count == 2000 ? 0 : self.count + 1
        
        let times = 2
        
        if self.didBlink == true {
            
            for _ in 0..<times {
                self.theHurt.alpha = 1 - self.theHurt.alpha
            }
            
            self.didBlink = false
        }
    }
    
    func attack() {
        
        print(">>>>>>>>>>>>>>>>>>>>123123")
        self.Beats = self.Beats - 1
        self.hpProgress.progress = self.hpProgress.progress - self.attackNumber
        UIView.animate(withDuration: 0.8) {
            //
            
        }

        
        if self.Beats == 0 {
            self.nextVC()
        }

    }
    
    func longPressGesture(sender : UILongPressGestureRecognizer){
        
        print(">> \(self.nowF)")
        
        if self.nowF - 0.5 > 0.0 {
            self.didBlink = true
            attack()
        }
        
        if sender.state == .ended {
            print("UIGestureRecognizerStateEnded")
            //Do Whatever You want on End of Gesture
            self.theBigAmulet.alpha = 0
            self.button?.adjustsImageWhenDisabled = false
            self.viewDidAppear(true)
        }
        else if sender.state == .began {
            print("UIGestureRecognizerStateBegan.")
            //Do Whatever You want on Began of Gesture
            self.theBigAmulet.alpha = 1
            
            self.button?.adjustsImageWhenDisabled = true
            self.viewDidAppear(true)
        }
    }
    
    func nextVC () {
        
        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async(execute: {
            
            DispatchQueue.main.async(execute: {
                //
                self.music?.stop()
                let ptr = self.storyboard?.instantiateViewController(withIdentifier: "FinishViewController") as! FinishViewController
                self.present(ptr, animated: true, completion: nil)
            })
        })
    }

}

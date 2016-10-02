//
//  FinishViewController.swift
//  Happy
//
//  Created by 楊信之 on 10/2/16.
//  Copyright © 2016 楊信之. All rights reserved.
//

import UIKit


class FinishViewController: UIViewController {

    var theBack : UIButton?
    var music : MusicHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let image = UIImage(named: "whiteX.png")
        let rect = CGRect(x: 10, y: 10, width: 50, height: 50)
        self.theBack = UIButton()
        self.theBack!.frame = rect
        self.theBack!.setImage(image, for: .normal )
        
        
        self.theBack!.addTarget(self, action: #selector(self.backAction), for: .touchUpInside)
        self.view.addSubview(self.theBack!)
        
        
        // audio
        self.music = MusicHandler.sharedInstance
        self.music?.changeMusic(name: "Themes_music")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func backAction() {
        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async(execute: {
            
            DispatchQueue.main.async(execute: {
                //
                let ptr = self.storyboard?.instantiateViewController(withIdentifier: "GoogleMapViewController") as! GoogleMapViewController
                self.present(ptr, animated: true, completion: nil)
            })
        })
    }
    
    

}

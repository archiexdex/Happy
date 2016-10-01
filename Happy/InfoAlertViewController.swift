//
//  InfoAlertViewController.swift
//  Happy
//
//  Created by 楊信之 on 10/1/16.
//  Copyright © 2016 楊信之. All rights reserved.
//

import UIKit

class InfoAlertViewController: UIViewController {

    // MARK: IBOutlet
    @IBOutlet weak var theTitle: UILabel!
    @IBOutlet weak var theAddress: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBAction
    @IBAction func cancelAction(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clearAction(_ sender: AnyObject) {
        
        let ptr = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async(execute: {
            
            DispatchQueue.main.async(execute: {
                //
                self.present(ptr, animated: true, completion: nil)
            })
        })
        
    }

}

//
//  customButton.swift
//  Happy
//
//  Created by 楊信之 on 10/1/16.
//  Copyright © 2016 楊信之. All rights reserved.
//

import UIKit

class customButton: UIView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        UIColor.black.setFill()
        let outerPath = UIBezierPath(ovalIn: rect)
        outerPath.fill()
        //self.frame isn’t defined yet, so we can’t use self.center
        let viewCenter = CGPoint(x: rect.width/2, y: rect.height/2)
        //Semi Circles
        //...
        //Center circle
        UIColor.white.setFill()
        let centerPath = UIBezierPath(ovalIn:rect.insetBy(dx: rect.width * 0.55 / 2, dy: rect.height * 0.55 / 2))
        centerPath.fill()
        
        
    }

    func circle( context : CGContext ) {
        context.setFillColor(red: 0, green: 0, blue: 0, alpha: 1)
        context.addEllipse(in: CGRect(x: 0, y: 0, width: 70, height: 70) )
        context.drawPath(using: .fillStroke)
    }
    
}

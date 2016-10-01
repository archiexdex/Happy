//
//  myView.swift
//  Happy
//
//  Created by 楊信之 on 10/1/16.
//  Copyright © 2016 楊信之. All rights reserved.
//

import UIKit
import QuartzCore

class myView: UIView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        // 1. Get a drawing zone
        let context = UIGraphicsGetCurrentContext()!
        
        context.setLineWidth(3)
        context.setStrokeColor(red: 0, green: 0, blue: 0, alpha: 1)
//        self.arrow(context: context)
        self.line(context: context)
        
    }
    
    // MARK: - Function
    func arrow( context : CGContext ) {
        
        print("OAO")
        // center (192,256)
        context.move(to: CGPoint(x: 188, y: 256))
        context.addLine(to: CGPoint(x: 196, y: 256))
        context.drawPath(using: .stroke)
        
        context.move(to: CGPoint(x: 192, y : 252) )
        context.beginPath()
        context.addLine(to: CGPoint(x: 196, y : 256))
        context.addLine(to: CGPoint(x: 192, y: 260) )
        context.closePath()
        context.drawPath(using: .fill)
        
    }
    func line( context : CGContext ) {
        
        let theWidth  = Int(self.bounds.size.width)
        let theHeight = Int(self.bounds.size.height)
        print(">> \(theWidth) \(theHeight)")
        
        for i in 0..<(theWidth / 10) {
            //
            let u = CGPoint(x: i*50, y: 0)
            let v = CGPoint(x: i*50, y: theHeight)
            context.move(to: u)
            context.addLine(to: v)
            context.drawPath(using: .stroke)
        }
        
        for i in 0..<(theHeight / 10) {
            //
            let u = CGPoint(x: 0, y: i * 50)
            let v = CGPoint(x: theWidth, y: i * 50)
            context.move(to: u)
            context.addLine(to: v)
            context.drawPath(using: .stroke)
        }
    }
 
}

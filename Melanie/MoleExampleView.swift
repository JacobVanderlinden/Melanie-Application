//
//  MoleExampleView.swift
//  Melanie
//
//  Created by Ian Mobbs on 11/29/16.
//  Copyright © 2016 Ian Mobbs. All rights reserved.
//

import UIKit

class MoleExampleView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override func drawRect(rect: CGRect) {
        let border = UIBezierPath(roundedRect: rect, cornerRadius: CGFloat(5))
        let inner = UIBezierPath(
            roundedRect: CGRect(origin: CGPoint(x: CGFloat(rect.origin.x + 5), y: CGFloat(rect.origin.y + 5)), size: CGSize(width: CGFloat(rect.width - 10), height: CGFloat(rect.height - 10))),
            cornerRadius: CGFloat(5)
        )
        let moleBorder = UIBezierPath(arcCenter: CGPoint(x: CGFloat(CGRectGetMidX(rect)), y: CGFloat(CGRectGetMidY(rect))), radius: CGFloat(70), startAngle: CGFloat(0), endAngle: CGFloat(M_PI * 2), clockwise: true)
        let moleInner = UIBezierPath(arcCenter: CGPoint(x: CGFloat(CGRectGetMidX(rect)), y: CGFloat(CGRectGetMidY(rect))), radius: CGFloat(65), startAngle: CGFloat(0), endAngle: CGFloat(M_PI * 2), clockwise: true)
        UIColor.blackColor().setFill()
        border.fill()
        UIColor.whiteColor().setFill()
        inner.fill()
        UIColor.blackColor().setFill()
        moleBorder.fill()
        UIColor.whiteColor().setFill()
        moleInner.fill()
        
    }

}

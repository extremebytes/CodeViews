//
//  SquareView.swift
//  CodeViews
//
//  Created by John Woolsey on 2/25/15.
//  Copyright (c) 2015 ExtremeBytes Software. All rights reserved.
//


import UIKit


class SquareView: UIView {

   override func drawRect(rect: CGRect) {
      let strokeWidth:CGFloat = 4
      let context = UIGraphicsGetCurrentContext()
      CGContextSetLineWidth(context, strokeWidth)
      CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
      CGContextSetFillColorWithColor(context, UIColor.magentaColor().CGColor)
      CGContextAddRect(context, CGRect(x: strokeWidth/2, y: strokeWidth/2, width: self.bounds.width - strokeWidth, height: self.bounds.height - strokeWidth))
      CGContextDrawPath(context, kCGPathFillStroke)
   }
}

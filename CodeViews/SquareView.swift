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
      drawSquare(self.bounds)
   }
   
   
   /**
   Draws a square in the current graphics context.
   
   - parameter squareRect: The rectangular dimensions of the square.
   */
   func drawSquare(squareRect: CGRect) {
      let context = UIGraphicsGetCurrentContext()
      let strokeWidth:CGFloat = 4
      CGContextSetLineWidth(context, strokeWidth)
      CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
      CGContextSetFillColorWithColor(context, UIColor.magentaColor().CGColor)
      CGContextAddRect(context, CGRect(x: strokeWidth/2, y: strokeWidth/2, width: squareRect.width - strokeWidth, height: squareRect.height - strokeWidth))
      CGContextDrawPath(context, CGPathDrawingMode.FillStroke)
   }
   
   
   /**
   Returns a Quick Look object for display during debugging.
   
   - returns: The Quick Look object.
   */
   func debugQuickLookObject() -> AnyObject? {
      let imageRect = CGRect(x: 0, y: 0, width: 200, height: 200)
      UIGraphicsBeginImageContext(imageRect.size)
      drawSquare(imageRect)
      let squareImage:UIImage? = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      return squareImage ?? description
   }
}

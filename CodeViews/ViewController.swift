//
//  ViewController.swift
//  CodeViews
//
//  Created by John Woolsey on 2/23/15.
//  Copyright (c) 2015 ExtremeBytes Software. All rights reserved.
//


import UIKit


class ViewController: UIViewController {
   
   // MARK: - Properties
   
   /// Dictionary containing all views within the view hierarchy.
   var viewsDictionary: Dictionary<String,UIView> = Dictionary()
   
   /// Colored view width; 50 for iPhone 6 Plus and larger sizes, otherwise 0.
   var coloredViewWidth: Int {
      let screenWidth = Int(UIScreen.mainScreen().bounds.width)
      let minimumLabelWidth = 301
      let spacingWidth = 8
      let colorViewWidth = 50
      return screenWidth - minimumLabelWidth - 3 * spacingWidth > colorViewWidth ? colorViewWidth : 0
   }


   // MARK: - View Lifecycle
   
   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view, typically from a nib.
   }

   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
   
   
   override func loadView() {
      loadTopView()
      loadSubViews()
      finalizeViews()
   }
   
   
   // MARK: - Custom
   
   /**
   Adds the specified view to the top level view hierarchy.
   
   :param: viewName   The textual name of the view for use in visual formatting.
   :param: viewObject The actual name of the view object.
   */
   func addViewToHierarchy(#viewName: String, viewObject: UIView) {
      viewObject.setTranslatesAutoresizingMaskIntoConstraints(false)
      view.addSubview(viewObject)
      viewsDictionary[viewName] = viewObject
   }
   
   
   /**
   Creates and returns a circle image.
   
   :returns: An optional UIImage of a circle.
   */
   func circleImage() -> UIImage? {
      let imageSize = CGSize(width: 500, height: 500)
      let strokeWidth = CGFloat(20)
      let circlePath = UIBezierPath(ovalInRect: CGRect(x: strokeWidth/2, y: strokeWidth/2, width: imageSize.width - strokeWidth, height: imageSize.height - strokeWidth))
      UIGraphicsBeginImageContext(CGSize(width: imageSize.width, height: imageSize.height))
      circlePath.lineWidth = strokeWidth
      UIColor.blackColor().setStroke()
      circlePath.stroke()
      UIColor.cyanColor().setFill()
      circlePath.fill()
      let circleImage:UIImage? = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      return circleImage
   }

   
   /**
   Finalizes the top level view hierarchy.
   */
   func finalizeViews() {
      // Create buffer view
      let bufferView = UIView()
      addViewToHierarchy(viewName: "bufferView", viewObject: bufferView)
      
      // Finalize layout constraints
      view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-50-[redLabel]-[yellowLabel]-[greenLabel]-[bufferView][circleImageView]-20-|",
         options: nil, metrics: nil, views: viewsDictionary))
   }
   
   
   /**
   Creates and adds the geometric views along with their associated layout constraints to the top level view hierarchy.
   */
   func loadGeometricViews() {
      // Create circle image view
      let circleImageView = UIImageView(image: circleImage())
      circleImageView.contentMode = .ScaleAspectFit
      addViewToHierarchy(viewName: "circleImageView", viewObject: circleImageView)
      
      // Create square view
      let squareView = SquareView()
      addViewToHierarchy(viewName: "squareView", viewObject: squareView)
      
      // Create layout constraints for geometric views
      view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[circleImageView]-20-[squareView(==circleImageView)]-|",
         options: .AlignAllCenterY, metrics: nil, views: viewsDictionary))
      view.addConstraint(NSLayoutConstraint(item: circleImageView, attribute: .Height, relatedBy: .Equal, toItem: circleImageView, attribute: .Width, multiplier: 1, constant: 0))
      view.addConstraint(NSLayoutConstraint(item: squareView, attribute: .Height, relatedBy: .Equal, toItem: squareView, attribute: .Width, multiplier: 1, constant: 0))
   }

   
   /**
   Creates and adds the green views along with their associated layout constraints to the top level view hierarchy.
   */
   func loadGreenViews() {
      // Create green label
      let greenLabel = UILabel()
      greenLabel.text = "Green Label"
      addViewToHierarchy(viewName: "greenLabel", viewObject: greenLabel)
      
      // Create green view
      let greenView = UIView()
      greenView.backgroundColor = UIColor.greenColor()
      addViewToHierarchy(viewName: "greenView", viewObject: greenView)
      
      // Create layout constraints for green views
      view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[greenView(coloredViewWidth)]-[greenLabel]-|",
         options: .AlignAllCenterY, metrics: ["coloredViewWidth":coloredViewWidth], views: viewsDictionary))
      view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[greenView(==greenLabel)]",
         options: nil, metrics: nil, views: viewsDictionary))
   }

   
   /**
   Creates and adds the red views along with their associated layout constraints to the top level view hierarchy.
   */
   func loadRedViews() {
      // Create red label
      let redLabel = UILabel()
      redLabel.text = "Red Label"
      addViewToHierarchy(viewName: "redLabel", viewObject: redLabel)
      
      // Create red view
      let redView = UIView()
      redView.backgroundColor = UIColor.redColor()
      addViewToHierarchy(viewName: "redView", viewObject: redView)
      
      // Create layout constraints for red views
      view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[redView(coloredViewWidth)]-[redLabel]-|",
         options: .AlignAllCenterY, metrics: ["coloredViewWidth":coloredViewWidth], views: viewsDictionary))
      view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[redView(==redLabel)]",
         options: nil, metrics: nil, views: viewsDictionary))
   }
   
   
   /**
   Creates and adds all subviews along with their associated layout constraints to the top level view hierarchy.
   */
   func loadSubViews() {
      loadRedViews()
      loadYellowViews()
      loadGreenViews()
      loadGeometricViews()
   }
   
   
   /**
   Creates the top level view.
   */
   func loadTopView() {
      let topView = UIView()
      topView.backgroundColor = UIColor.whiteColor()
      view = topView
   }
   
   
   /**
   Creates and adds the yellow views along with their associated layout constraints to the view hierarchy.
   */
   func loadYellowViews() {
      // Create yellow label
      let yellowLabel = UILabel()
      yellowLabel.text = "Yellow Label"
      addViewToHierarchy(viewName: "yellowLabel", viewObject: yellowLabel)
      
      // Create yellow view
      let yellowView = UIView()
      yellowView.backgroundColor = UIColor.yellowColor()
      addViewToHierarchy(viewName: "yellowView", viewObject: yellowView)
      
      // Create layout constraints for yellow views
      view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[yellowView(coloredViewWidth)]-[yellowLabel]-|",
         options: .AlignAllCenterY, metrics: ["coloredViewWidth":coloredViewWidth], views: viewsDictionary))
      view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[yellowView(==yellowLabel)]",
         options: nil, metrics: nil, views: viewsDictionary))
   }
   
   
   /**
   Reloads all subviews along with their associated layout constraints in the top level view hierarchy.
   */
   func reloadSubviews() {
      unloadSubviews()
      loadSubViews()
      finalizeViews()
   }
   
   
   /**
   Removes all subviews and layout constraints from the top level view hierarchy.
   */
   func unloadSubviews() {
      view.removeConstraints(view.constraints())
      for subview in view.subviews {
         view.removeFromSuperview()
      }
   }
}


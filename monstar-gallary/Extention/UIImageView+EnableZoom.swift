//
//  UIImageView+EnableZoom.swift
//  monstar-gallary
//
//  Created by Sanjay on 11/6/22.
//

import Foundation
import UIKit


extension UIImageView{
    func enableZoomWithPinchGesture() {
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(startZooming(_:)))
        
        
        
        isUserInteractionEnabled = true
        addGestureRecognizer(pinchGesture)
      }
    
    static var zoomedInWhenTap:Bool = false
    
    
    
    
    
    
    static var scaling:CGFloat = 1.0

      @objc
      private func startZooming(_ sender: UIPinchGestureRecognizer) {
    
          
          UIImageView.scaling = UIImageView.scaling * sender.scale
          
          print("scaling", UIImageView.scaling)
          

          UIImageView.scaling = min(sender.scale, 6)
          let scaleResult = sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)
          guard let scale = scaleResult, scale.a > 1, scale.d > 1 else { return }
          sender.view?.transform = scale
          sender.scale = 1

        
      }
    
   
        

        

      
    
}

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
    
    
    func enableZoomWithTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(startZoomingWhenTap(_:)))
        
        tapGesture.numberOfTapsRequired = 2
        
        isUserInteractionEnabled = true
        addGestureRecognizer(tapGesture)
      }
    
    
    
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
    
    @objc
    private func startZoomingWhenTap(_ sender: UIPinchGestureRecognizer) {
  
        
 
        
        if UIImageView.zoomedInWhenTap == false{
            
            print("false")
            let scaleResult = sender.view?.transform.scaledBy(x: 2, y: 2)
            guard let scale = scaleResult, scale.a > 1, scale.d > 1 else { return }
            

            
            
            UIView.animate(withDuration: 0.2) {
                sender.view?.transform = scale
            }
            UIImageView.zoomedInWhenTap = true
        }else{
            print("true")
            let scaleResult = sender.view?.transform.scaledBy(x: 0.5, y: 0.5)
            guard let scale = scaleResult, scale.a > 0.5, scale.d > 0.5 else { return }
            UIView.animate(withDuration: 0.2) {
                sender.view?.transform = scale
            }
            UIImageView.zoomedInWhenTap = false
        }
        

        

      
    }
}

//
//  UiVIew+RoundedCorner.swift
//  monstar-gallary
//
//  Created by Sanjay on 11/6/22.
//

import Foundation
import UIKit


extension UIView{
func setRadius(radius: CGFloat? = nil) {
        self.layer.cornerRadius = radius ?? self.frame.width / 2;
        self.layer.masksToBounds = true;
    }
}

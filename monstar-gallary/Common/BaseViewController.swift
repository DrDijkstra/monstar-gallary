//
//  BaseViewController.swift
//  monstar-gallary
//
//  Created by Sanjay on 2/6/22.
//

import UIKit
import Kingfisher

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: UIDevice.orientationDidChangeNotification, object: nil)

        
    }
    
    @objc func rotated() {
        let height: CGFloat = 50 //whatever height you want to add to the existing height
        let bounds = UIScreen.main.bounds
        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height + height)
    }
    
    
    
    func showToast(message: String, duration : Double = 0.5){
        var toastWidth = CGFloat(UIScreen.main.bounds.width * 0.7)
        
        
        let toastLabel = UILabel()
        
        toastLabel.backgroundColor = UIColor.systemBackground.withAlphaComponent(1)
        toastLabel.textColor = UIColor.label
        toastLabel.font = UIFont.systemFont(ofSize: 15)
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 8
        toastLabel.clipsToBounds = true
        toastLabel.numberOfLines = 0
        
        let font = UIFont.systemFont(ofSize: 12.0)
        let text = toastLabel.text! as NSString
        
//        toastLabel.frame = CGRect(x: self.view.frame.size.width/2 - (toastWidth/2),
//                                  y: (self.view.frame.size.height / 2) + (self.view.frame.size.height / 2) * 0.65,
//                                  width: toastWidth,
//                                  height: toastLabel.intrinsicContentSize.height + 25)
        let size = text.size(withAttributes: [NSAttributedString.Key.font:font])
        
        
        toastLabel.frame = CGRect(x: UIScreen.main.bounds.width/2 - (toastWidth/2),
                                  y: (self.view.frame.size.height / 2) + (self.view.frame.size.height / 2) * 0.6,
                                  width: toastWidth,
                                  height: size.height)
        //for setting dynamic height
        toastLabel.sizeToFit()
        
        
        if toastLabel.frame.width <= toastWidth{
            toastWidth = toastLabel.frame.width
        }
//        debugPrint(UIScreen.main.bounds.width, UIScreen.main.bounds.width/2 - (toastWidth/2), toastWidth)
        
        //add padding
        toastLabel.frame = CGRect(x: UIScreen.main.bounds.width/2 - (toastWidth/2),
                                  y: toastLabel.frame.minY,
                                  width: toastLabel.frame.width + 30,
                                  height: toastLabel.frame.height + 20)
        self.view.addSubview(toastLabel)
        toastLabel.transform = CGAffineTransform(scaleX: 0.8, y: 1.2)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [],  animations: {
            toastLabel.transform = .identity
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            UIView.animate(withDuration: 1, delay: 0.1, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0.0
            }, completion: {
                (isCompleted) in
                toastLabel.removeFromSuperview()
            })
        }
        
        
    }
    
    func showAlert(title: String, message: String){
            let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    

    

}


public func print(_ items: Any...) {
    #if DEBUG
        Swift.print(items[0])
    #endif
}

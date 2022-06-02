//
//  PhotoViewController.swift
//  monstar-gallary
//
//  Created by Sanjay on 2/6/22.
//

import UIKit

class PhotoViewController: BaseViewController {
  
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 14.0, *) {
            menuButton.menu = makeMenu()
        } else {
            // Fallback on earlier versions
        }

        
    }
    
    @IBAction func onBackButtonPress(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    
    
    
    @IBAction func onOptionButtonClick(_ sender: Any) {
           let menu =  makeMenu()
       
    }
    

    


    func makeMenu() -> UIMenu {
        let menu = UIMenu(title: "", options: .displayInline, children: [
            UIAction(title: "save", image: UIImage(systemName: "square.and.arrow.down"),handler: {_ in
                print("save")
            }),
            UIAction(title: "copy", image: UIImage(systemName: "doc.on.doc"),handler: {_ in
                print("copy")
                let image = UIImage(named: "appstore.png")
                UIPasteboard.general.image = image;
                self.showToast(message: "Copied")
                
                
            }),
            UIAction(title: "share", image: UIImage(systemName: "square.and.arrow.up"),handler: {_ in
                print("share")
                let image = UIImage(named: "appstore.png")
                       
               let imageToShare = [ image! ]
               let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
               activityViewController.popoverPresentationController?.sourceView = self.view
               
               activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
               
               self.present(activityViewController, animated: true, completion: nil)
            })
            
        ])
        return menu
    }
    
    
   
    
}

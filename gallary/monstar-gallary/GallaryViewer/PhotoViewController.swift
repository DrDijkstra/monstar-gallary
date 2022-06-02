//
//  PhotoViewController.swift
//  monstar-gallary
//
//  Created by Sanjay on 2/6/22.
//

import UIKit
import AVFoundation

class PhotoViewController: BaseViewController {
  
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    

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
       
    }
    

    


    func makeMenu() -> UIMenu {
        let menu = UIMenu(title: "", options: .displayInline, children: [
            UIAction(title: "save", image: UIImage(systemName: "square.and.arrow.down"),handler: {
                [weak self] (_)in
                self?.savePhoto()
            }),
            UIAction(title: "copy", image: UIImage(systemName: "doc.on.doc"),handler: {
                 [weak self](_) in
                self?.copyPhoto()
            }),
            UIAction(title: "share", image: UIImage(systemName: "square.and.arrow.up"),handler: { [weak self](_) in
                self?.sharePhoto()
            })
            
        ])
        return menu
    }
    
    func sharePhoto(){
       let image = UIImage(named: "appstore.png")
               
       let imageToShare = [ image! ]
       let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
       activityViewController.popoverPresentationController?.sourceView = self.view
       
       activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
       
       self.present(activityViewController, animated: true, completion: nil)
    }
    
    func copyPhoto(){
        let image = UIImage(named: "appstore.png")
        UIPasteboard.general.image = image;
        self.showToast(message: "Copied")
    }
    
    func savePhoto(){
        UIImageWriteToSavedPhotosAlbum(UIImage(named: "appstore.png")!, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
            if let error = error {
                // we got back an error!
                showAlert(title: "Save error", message: error.localizedDescription)
            } else {
                showAlert(title: "Saved!", message: "Your image has been saved to your photos.")
            }
    }
    
    
   
    
}

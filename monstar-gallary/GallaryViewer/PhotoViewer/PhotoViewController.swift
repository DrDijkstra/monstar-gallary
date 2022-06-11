//
//  PhotoViewController.swift
//  monstar-gallary
//
//  Created by Sanjay on 2/6/22.
//

import UIKit
import AVFoundation
import Kingfisher

class PhotoViewController: BaseViewController,UIScrollViewDelegate {
  
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    var thumbImage: UIImage!
    
    var imageUrl:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 14.0, *) {
            menuButton.menu = makeMenu()
        } else {
            // Fallback on earlier versions
        }
        menuButton.isEnabled = false
        print("imageUrl:    ",imageUrl ?? "")
        showImage()
        setupScrollView()
       
        
    }
    
    func setupScrollView(){
        scrollView.delegate = self
    }
    
    
   
    
 
    @IBAction func onScreenTap(_ sender: Any) {
        navBar.isHidden  = !navBar.isHidden
    }
    


       


    
    
    
    func showImage(){
        print("image sanjay", imageUrl ?? "")
        //imageUrl = imageUrl?.replacingOccurrences(of: "\", with: "")
        let urlString = URL(string: imageUrl!)
        print("sanjay url", urlString ?? "")
        imageView.kf.setImage(with: urlString, placeholder: thumbImage,completionHandler: {_ in
            print("Sanjay cahed")
            self.menuButton.isEnabled = true
        })
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
        let image = imageView.image
               
       let imageToShare = [ image! ]
       let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
       activityViewController.popoverPresentationController?.sourceView = self.view
       
       activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
       
       self.present(activityViewController, animated: true, completion: nil)
    }
    
    func copyPhoto(){
        
        UIPasteboard.general.image = imageView.image;
        self.showToast(message: "Copied")
    }
    
    func savePhoto(){
        UIImageWriteToSavedPhotosAlbum(imageView.image!, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
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


extension PhotoViewController{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        if scale == 1{
            navBar.isHidden = false
        }
        else{
            navBar.isHidden = true
        }
    }
    
    
    
}

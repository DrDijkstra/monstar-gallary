//
//  PhotoCollectionVC.swift
//  gallary
//
//  Created by Sanjay on 2/6/22.
//

import UIKit

class PhotoCollectionVC: BaseViewController {

    @IBOutlet weak var navBar: UINavigationBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
    }
    
    var responseUrlList:[ImageUrlData]?

    @IBAction func onButtonClick(_ sender: Any) {

        
        let serviceManager = ServiceManger.getInstance()
        serviceManager.getMonstarGalleryService()?.getPhotosBy(page: "2", callback: {
            result in
            switch result {
            case .success(let response):
                self.responseUrlList = response.urls
                self.performSegue(withIdentifier: "goToImageView", sender: self)
                break
            case .failure(let error):
                self.showToast(message: error.message ?? "something went wrong")
                break
            }
            
        })
       
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToImageView"{
            let vc = segue.destination as! PhotoViewController
            vc.imageUrl = responseUrlList?[1].regular
            
        }
    }
    

}

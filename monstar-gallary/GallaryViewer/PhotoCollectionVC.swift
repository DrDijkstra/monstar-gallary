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
        ServiceManger.initManager(sdkConfig: ServiceManagerConfig())
        
    }
    

    @IBAction func onButtonClick(_ sender: Any) {
//        performSegue(withIdentifier: "goToImageView", sender: self)
        let presenter = PhotoViewerPresenter()
        
        
        
    }
    

}

//
//  SplashViewController.swift
//  gallary
//
//  Created by Sanjay on 2/6/22.
//

import UIKit

class SplashViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        UserDefaults.lastImageIndex = 0
        let sm = ServiceManger.getInstance()
        DispatchQueue.main.async {
            sm.getDatabaseService()?.deleteImageUrlData(callback: {[weak self]_ in
                sleep(1)
                self?.performSegue(withIdentifier: "goToImageCollectionView", sender: self)
            })
        }
        


    }
    



}

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
        
        let seconds = 0.1
        UserDefaults.lastImageIndex = 0
        let sm = ServiceManger.getInstance()
        DispatchQueue.main.async {
            sm.getDatabaseService()?.deleteImageUrlData(callback: {_ in
                sleep(1)
                self.performSegue(withIdentifier: "goToImageCollectionView", sender: self)
            })
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[weak self] in
          
        }

    }
    



}

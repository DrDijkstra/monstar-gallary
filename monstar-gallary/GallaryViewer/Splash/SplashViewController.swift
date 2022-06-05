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
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[weak self] in
            self?.performSegue(withIdentifier: "goToImageCollectionView", sender: self)
        }

    }
    



}

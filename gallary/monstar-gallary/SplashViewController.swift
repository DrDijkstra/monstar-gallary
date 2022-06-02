//
//  SplashViewController.swift
//  gallary
//
//  Created by Sanjay on 2/6/22.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let seconds = 0.1
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[weak self] in
            // Put your code which should be executed with a delay here
            self?.performSegue(withIdentifier: "goToImageCollectionView", sender: self)
        }

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

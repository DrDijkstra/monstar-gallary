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
    

    @IBAction func onButtonClick(_ sender: Any) {
//        performSegue(withIdentifier: "goToImageView", sender: self)
        
        let presenter = PhotoViewerPresenter()
        performSegue(withIdentifier: "goToImageView", sender: self)
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToImageView"{
            let vc = segue.destination as! PhotoViewController
            vc.imageUrl =  "https://images.unsplash.com/photo-1654260449841-90d7feb2d768?crop=entropyu0026cs=tinysrgbu0026fm=jpgu0026ixid=MnwzMzM5OTR8MHwxfGFsbHwxMHx8fHx8fDJ8fDE2NTQzNDkxMjYu0026ixlib=rb-1.2.1u0026q=80"
        }
    }
    

}

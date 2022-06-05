//
//  PhotoCollectionVC.swift
//  gallary
//
//  Created by Sanjay on 2/6/22.
//

import UIKit


protocol  PhotoCollectionView:AnyObject{
    var presenter: PhotoCollectionPresenter? {get set}
    func onSuccessGetPhotoList(response: [ImageUrlData])
    func onFailureGetPhotoList(msg: String)
}

class PhotoCollectionVC: BaseViewController, PhotoCollectionView {
    var presenter: PhotoCollectionPresenter?
    
    func onSuccessGetPhotoList(response: [ImageUrlData]) {
        print(response)
    }
    
    func onFailureGetPhotoList(msg: String) {
        
    }
    

    @IBOutlet weak var navBar: UINavigationBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        presenter = PhotoCollectionPresenterImpl(view: self)
    }
    
    var responseUrlList:[ImageUrlData]?

    @IBAction func onButtonClick(_ sender: Any) {

        
        
        
        presenter?.getAllPhotoListAccorddingTo(pageNumber: "1")
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToImageView"{
            let vc = segue.destination as! PhotoViewController
            vc.imageUrl = responseUrlList?[1].regular
            
        }
    }
    

}

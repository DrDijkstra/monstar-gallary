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
        responseUrlList = response
        if responseUrlList?.count != 0{
            noPhotosText.isHidden = true
        }
        collectionView.reloadData()
    }
    
    func onFailureGetPhotoList(msg: String) {
        showToast(message: msg)
    }
    

    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var noPhotosText: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = PhotoCollectionPresenterImpl(view: self)
    }
    
    var responseUrlList:[ImageUrlData]?
    var selectedIndex:IndexPath = IndexPath(row: 0, section: 0)


    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.getAllPhotoListAccorddingTo(pageNumber: "1")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToImageView"{
            let vc = segue.destination as! PhotoViewController
            vc.imageUrl = responseUrlList?[selectedIndex.row].regular
            vc.thumbImage = (collectionView.cellForItem(at: selectedIndex) as! PhotoCollectionViewCell).imageView.image
            
        }
    }
    

}


extension PhotoCollectionVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return responseUrlList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoView", for: indexPath) as! PhotoCollectionViewCell
        
        let urlString = URL(string: responseUrlList?[indexPath.row].thumb ?? "")
        
        cell.imageView.kf.setImage(with: urlString, placeholder: UIImage(named: "appstore"))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath
        performSegue(withIdentifier: "goToImageView", sender: self)
    }
    
    
}

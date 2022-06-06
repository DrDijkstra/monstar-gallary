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
    var isFirstTime:Bool = true
    
    
    func onSuccessGetPhotoList(response: [ImageUrlData]) {
        isFirstTime = false
        
        totalImageCount += response.count
        if response.count != 0{
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
        collectionView.decelerationRate = .fast
        collectionView.prefetchDataSource = self
        presenter = PhotoCollectionPresenterImpl(view: self)
    }
    
    var totalImageCount:Int = 0
    var selectedUrlData:ImgUrlData?
    var selectedIndex:IndexPath = IndexPath(row: 0, section: 0)


    
    override func viewWillAppear(_ animated: Bool) {
        if isFirstTime{
            presenter?.getAllPhotoListAccorddingTo()
        }
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToImageView"{
            let vc = segue.destination as! PhotoViewController
            vc.imageUrl = selectedUrlData?.raw
            vc.thumbImage = (collectionView.cellForItem(at: selectedIndex) as! PhotoCollectionViewCell).imageView.image
            
        }
    }
    

}


extension PhotoCollectionVC: UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate, UICollectionViewDataSourcePrefetching{
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
    }
    
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalImageCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoView", for: indexPath) as! PhotoCollectionViewCell
        
      
        let urlData = presenter?.getPhotosBy(id: indexPath.row)
        let urlString = URL(string: urlData?.thumb ?? "")
        
        cell.imageView.kf.setImage(with: urlString, placeholder: UIImage(named: "appstore"))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath
        let urlData = presenter?.getPhotosBy(id: indexPath.row)
        selectedUrlData = urlData
        performSegue(withIdentifier: "goToImageView", sender: self)
       
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (collectionView.contentSize.height - 100 - scrollView.frame.size.height) {
            //infinity scrolling
            presenter?.getAllPhotoListAccorddingTo()
        }
    }
    
    
}
 

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

class PhotoCollectionVC: BaseViewController, PhotoCollectionView, PinterestLayoutDelegate{
    
    
    
    
    var presenter: PhotoCollectionPresenter?
    var isFirstTime:Bool = true
    
    
    func onSuccessGetPhotoList(response: [ImageUrlData]) {
        
        
        
        
        if response.count != 0{
            noPhotosText.isHidden = true
        }
        
        
        
        if isFirstTime == true{
            isFirstTime = false
            
            print("total image count", totalImageCount)
            totalImageCount += response.count
            
            
            collectionView.reloadData()
            
        }else{
            var count = 0
            var indexPathList:[IndexPath] = []
            for _ in response{
                count += 1;
                
                
                let indexPath = IndexPath(item: totalImageCount + count, section: 0)
                indexPathList.append(indexPath)
                
            }
            
            

            totalImageCount += response.count
            

            
            

            collectionView.performBatchUpdates({
                collectionView.reloadData()
            })

            
        }
        
        
        
        
        
       
    }
    
    func onFailureGetPhotoList(msg: String) {
        showToast(message: msg)
    }
    

    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var noPhotosText: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //collectionView.decelerationRate = .fast
        collectionView.prefetchDataSource = self
        // Do any additional setup after loading the view, typically from a nib.
//        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
//        layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width/4, height: UIScreen.main.bounds.size.width/4)
//        layout.minimumInteritemSpacing = 10
//        layout.minimumLineSpacing = 10
//        collectionView!.collectionViewLayout = layout
//        collectionView.numberOfItems(inSection: totalImageCount)
      
        
        if let layout = collectionView?.collectionViewLayout as? PinterestLayout {
          layout.delegate = self
        }
        
        presenter = PhotoCollectionPresenterImpl(view: self)
        
        
    }
    
    var totalImageCount:Int = 0
    var selectedUrlData:ImgUrlData?
    var selectedIndex:IndexPath = IndexPath(row: 0, section: 0)
    
    
    var preloadedImageUrlData:[String:ImgUrlData] = [:]

    
    override func viewWillAppear(_ animated: Bool) {
        print("is first time", isFirstTime)
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


extension PhotoCollectionVC: UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate, UICollectionViewDataSourcePrefetching, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalImageCount
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        //print("test", indexPaths)
        if indexPaths.count > 0{
            preloadedImageUrlData =  presenter?.getPhotosBy(indexPaths: indexPaths) ?? [:]
            //print("test", preloadedImageUrlData)
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let strId = String(indexPath.item)
        
        var imageHeight:Int = 0
        if let imgUrlData = preloadedImageUrlData[strId]{
            
        

            let height:Int = Int(imgUrlData.height ?? "1")!
            let width:Int = Int(imgUrlData.width ?? "1")!
            
            let heightMultiplier = height/width
            
            let screenWidth = UIScreen.main.bounds.width
            let imageWidth = (screenWidth - 4 * 6) / 3
            imageHeight = Int(imageWidth) * heightMultiplier
            
        }else{
            let urlData = presenter?.getPhotosBy(id: indexPath.row)
            
            print("urldata sanjay", urlData?.width)
            let height:Int = Int(urlData?.height ?? "1")!
            let width:Int = Int(urlData?.width ?? "1")!
            
            let heightMultiplier = height/width
            
            let screenWidth = UIScreen.main.bounds.width
            let imageWidth = (screenWidth - 4 * 6) / 3
            imageHeight = Int(imageWidth) * heightMultiplier
            
            
        }
        
        
       
        
        return CGFloat(imageHeight)
    }
    
   

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoView", for: indexPath) as! PhotoCollectionViewCell
        
        
        let strId = String(indexPath.item)
        
        if let imgUrlData = preloadedImageUrlData[strId]{
            let urlString = URL(string: imgUrlData.thumb ?? "")
            cell.imageView.kf.setImage(with: urlString, placeholder: UIImage(named: "appstore"))
        }else{
            let urlData = presenter?.getPhotosBy(id: indexPath.row)
            let urlString = URL(string: urlData?.thumb ?? "")
            
            cell.imageView.kf.setImage(with: urlString, placeholder: UIImage(named: "appstore"))
        }
        
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
 

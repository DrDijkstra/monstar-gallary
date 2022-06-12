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
        
        
        
        
        if response.count != 0{
            noPhotosText.isHidden = true
        }
        
        
        
        if isFirstTime == true{
            isFirstTime = false
            
            print("total image count", totalImageCount)
            totalImageCount += response.count
            
            
   //         collectionView.numberOfItems(inSection: totalImageCount)
            
            collectionView.reloadData()
            print("collectionView.reloadData()")
            
        }else{
            
            
            //collectionView.numberOfItems(inSection: 0)
            
            //print("total image count", totalImageCount)
            
            //print(indexPathList[0].section)
            
//                collectionView.reloadData()
            var count = 0
            var indexPathList:[IndexPath] = []
            for _ in response{
                count += 1;
                
                
                let indexPath = IndexPath(item: totalImageCount + count - 1, section: 0)
                indexPathList.append(indexPath)
                
            }
            
            
            //print("total image count", totalImageCount)
            totalImageCount += response.count
     
            

            collectionView.performBatchUpdates({

                collectionView.insertItems(at: indexPathList)

                
            })

            
        }
        
        
        
        
        
       
    }
    
    func onFailureGetPhotoList(msg: String) {
        noPhotosText.isHidden = false
        showToast(message: msg)
    }
    

    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var noPhotosText: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //collectionView.decelerationRate = .fast
        collectionView.prefetchDataSource = self

//        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
//        layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width/5, height: UIScreen.main.bounds.size.width/5)
//        layout.minimumInteritemSpacing = 10
//        layout.minimumLineSpacing = 10
//        collectionView!.collectionViewLayout = layout
//        collectionView.numberOfItems(inSection: totalImageCount)
        
//        if let layout = collectionView?.collectionViewLayout as? WaterFallGridCollectionLayoutLayout {
//            layout.delegate = self
//        }
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


extension PhotoCollectionVC: UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate, UICollectionViewDataSourcePrefetching, UICollectionViewDelegateFlowLayout, WaterFallGridCollectionLayoutDelegate{
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        
        let urlImgData :ImgUrlData?
        let strId = String(indexPath.item)
        
        if let imgUrlData = preloadedImageUrlData[strId]{
            urlImgData = imgUrlData
        }else{
            let urlData = presenter?.getPhotosBy(id: indexPath.row)
           urlImgData = urlData
        }
        
        let hm = CGFloat(Double((urlImgData?.heightMultiplier)!) ?? 1)
        
        let cellWidth = (UIScreen.main.bounds.width - 2 * 2) / 3
        
        let height = cellWidth * hm
        
        print("heightx", height, "widthx", collectionView.cellForItem(at: indexPath)?.frame.width)
       
        
        return height
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         print("numberOfItemsInSection \(totalImageCount)")
        return totalImageCount
    }
    

    
    
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        //print("test", indexPaths)
        if indexPaths.count > 0{
            preloadedImageUrlData =  presenter?.getPhotosBy(indexPaths: indexPaths) ?? [:]
            //print("test", preloadedImageUrlData)
        }
        
        
    }
    
   

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoView", for: indexPath) as! PhotoCollectionViewCell
        
        
        let strId = String(indexPath.item)
        
        let urlImgData :ImgUrlData?
        
        if let imgUrlData = preloadedImageUrlData[strId]{
            let urlString = URL(string: imgUrlData.thumb ?? "")
            cell.imageView.kf.setImage(with: urlString, placeholder: UIImage(named: "appstore"))
            urlImgData = imgUrlData
        }else{
            let urlData = presenter?.getPhotosBy(id: indexPath.row)
            let urlString = URL(string: urlData?.thumb ?? "")
            urlImgData = urlData
            cell.imageView.kf.setImage(with: urlString, placeholder: UIImage(named: "appstore"))
        }
        
        cell.imageView.setRadius(radius: 10)
        
        
        
        let height = cell.frame.width * (Double(urlImgData?.heightMultiplier ?? "1")!)
        
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
 

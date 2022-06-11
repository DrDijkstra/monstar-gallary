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
            
        }else{
            var count = 0
            var indexPathList:[IndexPath] = []
            for _ in response{
                count += 1;
                
                
                let indexPath = IndexPath(item: totalImageCount + count, section: 0)
                indexPathList.append(indexPath)
                
            }
            
            
            //print("total image count", totalImageCount)
            totalImageCount += response.count
            
            //collectionView.numberOfItems(inSection: 0)
            
            //print("total image count", totalImageCount)
            
            //print(indexPathList[0].section)
            
            

            collectionView.performBatchUpdates({
                
                collectionView.reloadData()
                //collectionView.insertItems(at: indexPathList)
                
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
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width/5, height: UIScreen.main.bounds.size.width/5)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        collectionView!.collectionViewLayout = layout
        collectionView.numberOfItems(inSection: totalImageCount)
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
        
        
        print("img data", urlImgData)
        
        let height = cell.frame.width * (Double(urlImgData?.heightMultiplier ?? "1")!)
        
        cell.frame = CGRect(x: cell.frame.minX, y: cell.frame.minY, width: cell.frame.width, height: height)
        
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
 

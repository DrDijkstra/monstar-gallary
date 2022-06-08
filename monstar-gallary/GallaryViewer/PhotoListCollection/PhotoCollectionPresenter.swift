//
//  Presenter.swift
//  monstar-gallary
//
//  Created by Sanjay on 3/6/22.
//

import Foundation


protocol PhotoCollectionPresenter:AnyObject{
    var router: PhotoRouter? {get set}
    var view:PhotoCollectionView?{get set}
    var interactor:PhotoCollectionInetractor? {get set}
    
    func getAllPhotoListAccorddingTo()
    func getPhotosBy(id: Int)->ImgUrlData?
    func getPhotosBy(indexPaths: [IndexPath])->[String: ImgUrlData]
    
    
}

class PhotoCollectionPresenterImpl:PhotoCollectionPresenter{
    func getPhotosBy(indexPaths: [IndexPath]) -> [String:ImgUrlData] {
        var dict: [String:ImgUrlData] = [String :ImgUrlData]()
        
        var idList:[Int] = []
        
        for indexPath in indexPaths {
            idList.append(indexPath.item)
        }
        let imgUrlList = interactor?.getPhotoListBy(idList: idList)
        for imgUrl in imgUrlList ?? []{
            dict[imgUrl.id!] = imgUrl
        }
        return dict
    }
    
    func getPhotosBy(id: Int) -> ImgUrlData?{
        return interactor?.getPhotosBy(id: id)
    }
    
    
    
    
    weak var router: PhotoRouter?
    weak var view: PhotoCollectionView?
    var interactor: PhotoCollectionInetractor?
    
    
    static var pageNumber = 1
    
    func getAllPhotoListAccorddingTo() {
       
        let pageNumberString = String(PhotoCollectionPresenterImpl.pageNumber)
        PhotoCollectionPresenterImpl.pageNumber += 1
        interactor?.getAllPhotoListAccorddingTo(pageNumber: pageNumberString, callback: {
            result in
            switch result{
            case .success(let sc):
                self.view?.onSuccessGetPhotoList(response: sc.urlList ?? [])
                
                break
            case .failure(let error):
                self.view?.onFailureGetPhotoList(msg: error.message ?? "unknown error")
                
            }
        })
    }
    
   
    
    

    
    

    
    init(view: PhotoCollectionView) {
       
        self.interactor = PhotoCollectionInetractorImpl(presenter: self)
        self.router = PhotoRouterImpl.start(view: view, presenter: self, interactor: self.interactor!)
    }
    
    
}

  


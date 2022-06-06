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
    
    func getAllPhotoListAccorddingTo(pageNumber: String)
    func getPhotosBy(id: Int)->ImgUrlData?
    
    
}

class PhotoCollectionPresenterImpl:PhotoCollectionPresenter{
    func getPhotosBy(id: Int) -> ImgUrlData?{
        return interactor?.getPhotosBy(id: id)
    }
    
    
    
    
    weak var router: PhotoRouter?
    weak var view: PhotoCollectionView?
    var interactor: PhotoCollectionInetractor?
    
    
    func getAllPhotoListAccorddingTo(pageNumber: String) {
       
      
        interactor?.getAllPhotoListAccorddingTo(pageNumber: pageNumber, callback: {
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

  


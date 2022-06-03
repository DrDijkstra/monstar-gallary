//
//  Presenter.swift
//  monstar-gallary
//
//  Created by Sanjay on 3/6/22.
//

import Foundation


class PhotoViewerPresenter{
    
    
    
    
    init(){
        let serviceManager = ServiceManger.getInstance()
        print("initiated")
        serviceManager.getMonstarGalleryService()?.getPhotosBy(page: "1", callback: {_ in 
            
        })
    }
    
}

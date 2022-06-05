//
//  Router.swift
//  monstar-gallary
//
//  Created by Sanjay on 3/6/22.
//

import Foundation
import UIKit

typealias EntryPoint = PhotoCollectionView & UIViewController

protocol PhotoRouter:AnyObject{
    var entry:EntryPoint? {get}
    static func start(view:PhotoCollectionView, presenter: PhotoCollectionPresenter, interactor: PhotoCollectionInetractor)->PhotoRouter
}

class PhotoRouterImpl: PhotoRouter{
    weak var entry: EntryPoint?
    
    static func start(view:PhotoCollectionView, presenter: PhotoCollectionPresenter, interactor: PhotoCollectionInetractor) -> PhotoRouter {
        let router = PhotoRouterImpl()
        //
        

        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? EntryPoint
        
        return router
    }
    
    func present(viewController: UIViewController){
        
    }
    

    
    
    
    
}

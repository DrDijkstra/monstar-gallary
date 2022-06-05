//
//  Router.swift
//  monstar-gallary
//
//  Created by Sanjay on 3/6/22.
//

import Foundation



protocol PhotoRouter{
    static func start()->PhotoRouter
}

class PhotoRouterImpl: PhotoRouter{
    static func start() -> PhotoRouter {
        let router = PhotoRouterImpl()
        //
        
        return router
    }
    
    
}

//
//  Router.swift
//  monstar-gallary
//
//  Created by Sanjay on 3/6/22.
//

import Foundation



protocol AnyRouter{
    static func start()->AnyRouter
}

class PhotoRouter: AnyRouter{
    static func start() -> AnyRouter {
        let router = PhotoRouter()
        //
        
        return router
    }
    
    
}

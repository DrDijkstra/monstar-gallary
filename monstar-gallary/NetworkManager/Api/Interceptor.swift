//
//  Interceptor.swift
//  monstar-gallary
//
//  Created by Sanjay on 3/6/22.
//

import Foundation
import Alamofire

class Interceptor: RequestInterceptor {
    
    
    typealias AdapterResult = Swift.Result<URLRequest, Error>
    
    
    init() {
        
    }
    

    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        
        let authtoken :String? = "Client-ID 8SFITXbEwzilN-NZIIHXEtEBDHfAisWyulw1jSmIWac"
        
        urlRequest.setValue( authtoken , forHTTPHeaderField: HeaderName.auth.rawValue)

        completion(.success(urlRequest))
        
    }
    

    

    
 

}

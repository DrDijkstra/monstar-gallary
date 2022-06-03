//
//  Interceptor.swift
//  monstar-gallary
//
//  Created by Sanjay on 3/6/22.
//

import Foundation
import Alamofire

class Interceptor: RequestInterceptor {
    private typealias RefreshCompletion = (_ succeeded: Bool, _ accessToken: String?) -> Void
    
  
    private let lock = NSLock()
    

    

    

    
    typealias AdapterResult = Swift.Result<URLRequest, Error>
    
    
    init() {
        
    }
    

    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        
        //let clientId :String? = "8SFITXbEwzilN-NZIIHXEtEBDHfAisWyulw1jSmIWac"
        
        //urlRequest.setValue( clientId , forHTTPHeaderField: HeaderName.clientId.rawValue)

        completion(.success(urlRequest))
        
    }
    

    

    
 

}

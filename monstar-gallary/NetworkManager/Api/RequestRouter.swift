//
//  RequestRouter.swift
//  monstar-gallary
//
//  Created by Sanjay on 3/6/22.
//

import Foundation
import Alamofire

enum RequestRouter : URLRequestConvertible, URLConvertible{
    case getAllPhotosBy(pageNumber:String)
    
    static var baseUrl = "http://10.88.250.90:20002"
    
    
    var method: HTTPMethod {
        switch self {
        case .getAllPhotosBy:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getAllPhotosBy:
            return ApiUrl.checkUserStatus.rawValue
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: try getFullUrl())
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .checkUserStatus(let moblieNumber):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: ["msisdn" : moblieNumber])
        
        return urlRequest
        }
    }
    
    func asURL() throws -> URL {
        return URL(string: path)!
    }
    
   
    
    

    public func getFullUrl()throws -> URL{
        return try RequestRouter.baseUrl.asURL().appendingPathComponent(path)
    }
    
   
    

    

}

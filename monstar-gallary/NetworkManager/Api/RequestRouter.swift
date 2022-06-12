//
//  RequestRouter.swift
//  monstar-gallary
//
//  Created by Sanjay on 3/6/22.
//

import Foundation
import Alamofire

enum RequestRouter : URLRequestConvertible, URLConvertible{
    case getAllPhotos(request:PhotoListRequest)
    
    //static var baseUrl = ""
    
    
    var method: HTTPMethod {
        switch self {
        case .getAllPhotos:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getAllPhotos(_):
            return ApiUrl.photos.rawValue
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: try getFullUrl())
        urlRequest.httpMethod = method.rawValue
        
        
        switch self {
        case .getAllPhotos(let request):
            urlRequest = try URLEncoding.default.encode(urlRequest,
                                                        with: ["page" : request.pageNumber ?? "1",
                                                               "per_page" : request.perPageListNumber ?? "20"])
        
        return urlRequest
        }
    }
    
    func asURL() throws -> URL {
        return URL(string: path)!
    }
    
   
    
    

    public func getFullUrl()throws -> URL{
        return try AppConfig.serverUrl.asURL().appendingPathComponent(path)
    }
    
   
    

    

}

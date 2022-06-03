//
//  NetworkServiceImpl.swift
//  monstar-gallary
//
//  Created by Sanjay on 3/6/22.
//

import Foundation
import Alamofire

class NetworkServiceImpl: NetworkService {
    func getPhotosBy(pageNumber: String, gwCallback: @escaping (ApiGwCallResult<ApiPhotosResponse>) -> Void) {
        executeRequest(RequestRouter.getAllPhotosBy(pageNumber: pageNumber), gwCallback: gwCallback)
    }
    
   
    
    init(){
        self.sm = Session()
    }
    
    
    let sm : Session
    
    private func isSuccessResponse(httpStatusCode: Int?)-> Bool{
        return httpStatusCode != nil && httpStatusCode == 200
    }
    
    private func converApiGwStatusToResponseStatus<T: ApiGwResponse>(apiGwStatus:ApiGwResponse , response : T)-> ResponseStatus{
        let code = apiGwStatus.reason ?? ApiCallResponseCode.unknown.rawValue
        return ResponseStatus(responseCode: code, message: apiGwStatus.message, devMessage: apiGwStatus.devMessage, response: response)
    }
    
    
    private func executeRequest<T:ApiGwResponse>(_ urlRequest: URLRequestConvertible, gwCallback: @escaping (ApiGwCallResult<T>) -> Void) -> Void {

    }
    

    

    
    
    fileprivate func printRequestResponse<T>(_ response: AFDataResponse<T>) {
        let request = response.request
        print("➡️➡️➡️ ------------ Request ------------ ➡️➡️➡️")
    
        print("Headers:{")
        request?.allHTTPHeaderFields?.forEach{print("\t\($0): \($1)")}
        print("}")
        print("\(request!.httpMethod!) - \(request!.url!.absoluteString)")
        print("\(request!.httpBody.map { body in String(data: body, encoding: .utf8) ?? "" } ?? "")")
    
        switch response.result {
        case .success(let value):
            print("✅✅✅ ------------ Response ------------ ✅✅✅")
            print("Headers:{")
            response.response?.allHeaderFields.forEach{print("\t\($0): \($1)")}
            print("}")
            print("Response with content \(value)")
        case .failure( let error):
    
            if isSuccessResponse(httpStatusCode: response.response?.statusCode ) {
                print("✅✅✅ ------------ Response ------------ ✅✅✅")
            }else{
                print("❌❌❌ ------------ Response ------------ ❌❌❌")
            }
    
    
            let isServerTrustEvaluationError =
                    error.asAFError?.isServerTrustEvaluationError ?? false
    
            if isServerTrustEvaluationError {
                print("Certificate Pinning Error")
            }
    
            let responseBodyRawString = response.data?.convertDataToUtf8String()
            guard responseBodyRawString != nil else{
                print("Empty Response body")
                print("Could not parse Response")
                print("------------------- End --------------------")
                return
            }
            print("Response : " + responseBodyRawString!)
        }
        print("------------------- End --------------------")
    }
      

    
    
    
    
    
}




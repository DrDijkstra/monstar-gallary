//
//  NetworkServiceImpl.swift
//  monstar-gallary
//
//  Created by Sanjay on 3/6/22.
//

import Foundation
import Alamofire

class NetworkServiceImpl: NetworkService {
    func checkUserStatus(moibleNumber: String, gwCallback: @escaping (ApiGwCallResult<ApiPhotosResponse>) -> Void) {
        
        
    }
    
    init(){
        
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
//        sm.request(urlRequest)
//            .validate()
//            .responseString { (response: AFDataResponse<String>) in
//                
//                #if DEBUG
//                self.printRequestResponse(response)
//                #endif
//
//                if ( response.data == nil  && self.isSuccessResponse(httpStatusCode: response.response?.statusCode)){
//                    gwCallback(ApiGwCallResult<T>.success(sc :  ApiGwResponse() as! T))
//                    return
//                }
//
//                switch response.result{
//                case .success(var responseString):
//
//                    _ = response.response?.statusCode
//
//
//
//
//
//
//
//                case .failure(let error):
//                    let apiGwError = self.prepareApiGwError(response: response, error: error, castingClassType: T.self)
//
//                    gwCallback(ApiGwCallResult<T>.failure(error : self.convertToApiGwErrorResponse(error: apiGwError)))
//
//                }
//            }
    }
    
    func prepareApiGwError<T : ApiGwResponse, U>(response: AFDataResponse<U>, error: Error, castingClassType : T.Type) -> ApiGwError{
        
       
        guard let data = response.data else {
            return ApiGwError.unknownError(error: error, httpStatusCode: response.response?.statusCode)
        }
        
        guard let responseBodyRawString = data.convertDataToUtf8String() else {
            return ApiGwError.responseBodyDeserialization(error: error, data: data)
        }
        
        let apiGwStatus = Mapper<T>().map(JSONString: responseBodyRawString)
        return ApiGwError.responseError(error: error, gwErrorStatus: apiGwStatus)
        
    }
    
    private func convertToApiGwErrorResponse(error:Error) -> ResponseStatus{
        if error is ApiGwError{
            switch error as! ApiGwError {
            case ApiGwError.network( _):
                return ResponseStatus(responseCode: ApiCallResponseCode.unknown.rawValue, message: nil, devMessage: "Alamofire Network error")
            case ApiGwError.responseError( _ , let gwErrorStatus):
                let code = gwErrorStatus?.reason ?? ApiCallResponseCode.unknown.rawValue
                return ResponseStatus(responseCode: code, message: gwErrorStatus?.message, devMessage: gwErrorStatus?.devMessage, response: gwErrorStatus)
            case ApiGwError.requestBodySerialization( _,  _):
                return ResponseStatus(responseCode: ApiCallResponseCode.requestEncodeError.rawValue, message: nil, devMessage: "Cannot encode request")
            case ApiGwError.responseBodyDeserialization( _, _):
                return ResponseStatus(responseCode: ApiCallResponseCode.requestEncodeError.rawValue, message: nil, devMessage: "Cannot decode response")
            case ApiGwError.unknownError( _ , _):
                return ResponseStatus(responseCode: ApiCallResponseCode.unknown.rawValue, message: nil, devMessage: "Unknow error")
            }
        }
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

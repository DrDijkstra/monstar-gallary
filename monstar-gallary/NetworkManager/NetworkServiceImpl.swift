//
//  NetworkServiceImpl.swift
//  monstar-gallary
//
//  Created by Sanjay on 3/6/22.
//

import Foundation
import Alamofire
import ObjectMapper

class NetworkServiceImpl: NetworkService {
    func getPhotosBy(pageNumber: String, gwCallback: @escaping (ApiGwCallResult<ApiPhotosResponse>) -> Void) {
      
        executeRequest(RequestRouter.getAllPhotos(pageNumber: pageNumber), gwCallback: gwCallback)
    }
    
    
   
    var requestInterceptor:Interceptor
    
    init(interceptor:Interceptor){
       print("hello sanjay")
        let smConfig = URLSessionConfiguration.default
        smConfig.timeoutIntervalForRequest = 10
        smConfig.requestCachePolicy = .returnCacheDataElseLoad
        
        self.requestInterceptor = interceptor
        
        self.sm = Session(configuration: smConfig, interceptor: requestInterceptor)
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
        print(urlRequest)
       
        sm.request(urlRequest)
            .validate()
            .responseString { (response: AFDataResponse<String>) in
                print("Sanjay")
                #if DEBUG
                self.printRequestResponse(response)
                #endif
                
                
                switch response.result{
                case .success(var responseString):
                   
                    
                    
                    
                    
                    let statusCode = response.response?.statusCode
                    //print(responseString.prefix(2))
                    
                    responseString = "{\"photos\":" + responseString + "}"
                    //print(responseString)
                    
                    guard let object = Mapper<T>().map(JSONString: responseString) else{
                        
                        let error = self.convertToApiGwErrorResponse(error: ApiGwError.unknownError(error: nil, httpStatusCode: statusCode))
                        
                        
                        //print(error.code)
                        gwCallback(ApiGwCallResult<T>.failure(
                                    error : error))
                        
                        
                        
                        return
                    }
                    

                    gwCallback(ApiGwCallResult<T>.success(sc : object))
                    
                    
                    
                case .failure(let error):
                    //print(error)
                    let apiGwError = self.prepareApiGwError(response: response, error: error, castingClassType: T.self)
                    gwCallback(ApiGwCallResult<T>.failure(error : self.convertToApiGwErrorResponse(error: apiGwError)))
                    
                }
                

    
            }
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
                return ResponseStatus(responseCode: code, message: gwErrorStatus?.errors?[0], devMessage: nil, response: gwErrorStatus)
            case ApiGwError.requestBodySerialization( _,  _):
                return ResponseStatus(responseCode: ApiCallResponseCode.requestEncodeError.rawValue, message: nil, devMessage: "Cannot encode request")
            case ApiGwError.responseBodyDeserialization( _, _):
                return ResponseStatus(responseCode: ApiCallResponseCode.requestEncodeError.rawValue, message: nil, devMessage: "Cannot decode response")
            case ApiGwError.unknownError( _ , _):
                return ResponseStatus(responseCode: ApiCallResponseCode.unknown.rawValue, message: nil, devMessage: "Unknow error")
            }
        }
        return ResponseStatus(responseCode: ApiCallResponseCode.unknown.rawValue, message: nil, devMessage: "Unknow error")
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
        case .success(_):
            print("✅✅✅ ------------ Response ------------ ✅✅✅")
            print("Headers:{")
            response.response?.allHeaderFields.forEach{print("\t\($0): \($1)")}
            print("}")
            
            
            let string = response.data?.prettyPrintedJSONString

            print("Response with content \(string ?? "{}")")
           
            
           
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
        
        

        
        





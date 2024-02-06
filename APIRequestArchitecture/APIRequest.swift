//
//  APIRequest.swift
//  APIRequestArchitecture
//
//  Created by devang bhavsar on 02/04/22.
//

import Alamofire
import UIKit

class APIRequest {
    func isConnectedToInterNet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
   func getRequest<T:Decodable>(serviceName:String,success successBlock: @escaping ((T) -> Void), andFailureBlock failedBlock:@escaping ((String) -> Void)){
        if isConnectedToInterNet() {
            
            
            //        var headers:HTTPHeaders?
            //        print("Service Name = \(serviceName)")
            //               let credentialData = "\(usernameapi):\(passwordapi)".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
            //
            //               let base64Credentials = credentialData.base64EncodedString()
            //                   headers = [
            //                           "Authorization": "Basic \(base64Credentials)",
            //                           "Accept": "application/json",
            //                           "Content-Type": "application/json" ]
            
            Alamofire.request(serviceName, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (responseValue) in  // header
                switch responseValue.response?.statusCode {
                case .none:
                    failedBlock(ErrorMessages.urlSide.value())
                    break
                case .some(let value):
                    switch value {
                    case 200...299:
                        switch responseValue.result {
                        case .success(_):
                            do {
                                let obj = try JSONDecoder().decode(T.self , from: responseValue.data!)
                                successBlock(obj)
                            }
                            catch {
                                failedBlock(ErrorMessages.interNetCheck.value())
                            }
                            break
                        case .failure( let error):
                            failedBlock("\(error.localizedDescription)")
                            break
                        }
                        break
                    case 400...499:
                        failedBlock(ErrorMessages.clientSide.value())
                        break
                    case 500...599:
                        failedBlock(ErrorMessages.serverSide.value())
                        break
                    default:
                        break
                    }
                    break
                }
            }
        } else {
            failedBlock(ErrorMessages.interNetCheck.value())
        }
    }
    
    func postRequest<T:Decodable>(serviceName:String,andParams params: [String:Any],success successBlock: @escaping ((T) -> Void), andFailureBlock failedBlock:@escaping ((String) -> Void)) {
        if isConnectedToInterNet() {
            Alamofire.request(serviceName, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (responseValue) in
                switch responseValue.response?.statusCode {
                case .none:
                    failedBlock(ErrorMessages.urlSide.value())
                    break
                case .some(let value):
                    switch value {
                    case 200...299:
                        switch responseValue.result {
                        case .success(_):
                            do {
                                let obj = try JSONDecoder().decode(T.self , from: responseValue.data!)
                                successBlock(obj)
                            }
                            catch {
                                failedBlock(ErrorMessages.interNetCheck.value())
                            }
                            break
                        case .failure( let error):
                            failedBlock("\(error.localizedDescription)")
                            break
                        }
                        break
                    case 400...499:
                        failedBlock(ErrorMessages.clientSide.value())
                        break
                    case 500...599:
                        failedBlock(ErrorMessages.serverSide.value())
                        break
                    default:
                        break
                    }
                    break
                }
            }
        } else {
            failedBlock(ErrorMessages.interNetCheck.value())
        }
    }
    
    func putRequest<T:Decodable>(serviceName:String,andParams params: [String:Any],success successBlock: @escaping ((T) -> Void), andFailureBlock failedBlock:@escaping ((String) -> Void)) {
        if isConnectedToInterNet() {
            Alamofire.request(serviceName, method: .put, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (responseValue) in
                switch responseValue.response?.statusCode {
                case .none:
                    failedBlock(ErrorMessages.urlSide.value())
                    break
                case .some(let value):
                    switch value {
                    case 200...299:
                        switch responseValue.result {
                        case .success(_):
                            do {
                                let obj = try JSONDecoder().decode(T.self , from: responseValue.data!)
                                successBlock(obj)
                            }
                            catch {
                                failedBlock(ErrorMessages.interNetCheck.value())
                            }
                            break
                        case .failure( let error):
                            failedBlock("\(error.localizedDescription)")
                            break
                        }
                        break
                    case 400...499:
                        failedBlock(ErrorMessages.clientSide.value())
                        break
                    case 500...599:
                        failedBlock(ErrorMessages.serverSide.value())
                        break
                    default:
                        break
                    }
                    break
                }
            }
        } else {
            failedBlock(ErrorMessages.interNetCheck.value())
        }
    }
    
    func uploadMultipartImages<T:Decodable>(serviceName:String,andParams params: [String:Any],success successBlock: @escaping ((T) -> Void), andFailureBlock failedBlock:@escaping ((String) -> Void)) {
        if isConnectedToInterNet() {
            Alamofire.upload(multipartFormData: { (result) in
                for(key,value) in params {
                    if key == "images" {
                        for _ in value as! [Data] {
                            //  result.append(objData, withName: key, fileName: "image.jpeg",mimeType: "image/jpeg")
                        }
                    } else if value is String {
                        result.append( (value as! String).data(using: .utf8)!, withName: key)
                    }
                }
            }, usingThreshold: UInt64(), to: serviceName, method: .post) { (encodingResult) in
                print("Encoding Result = \(encodingResult)")
                switch encodingResult {
                case .success(let upload,_,_):
                    upload.validate().responseJSON { (responseValue) in
                        switch responseValue.response?.statusCode {
                        case .none:
                            failedBlock(ErrorMessages.urlSide.value())
                            break
                        case .some(let value):
                            switch value {
                            case 200...299:
                                switch responseValue.result {
                                case .success(_):
                                    do {
                                        let obj = try JSONDecoder().decode(T.self , from: responseValue.data!)
                                        successBlock(obj)
                                    }
                                    catch {
                                        failedBlock(ErrorMessages.interNetCheck.value())
                                    }
                                    break
                                case .failure( let error):
                                    failedBlock("\(error.localizedDescription)")
                                    break
                                }
                                break
                            case 400...499:
                                failedBlock(ErrorMessages.clientSide.value())
                                break
                            case 500...599:
                                failedBlock(ErrorMessages.serverSide.value())
                                break
                            default:
                                break
                            }
                            break
                        }
                    }
                    break
                case .failure(let encodingError):
                    failedBlock(encodingError.localizedDescription)
                    break
                }
            }
        } else {
            failedBlock(ErrorMessages.interNetCheck.value())
        }
    }
}

//
//  APICallSetUp.swift
//  APIRequestArchitecture
//
//  Created by devang bhavsar on 02/04/22.
//

import UIKit

class APICallSetUp: NSObject {
    var objAPIRequest = APIRequest()
    func makeAPICall() {
        self.objAPIRequest.getRequest(serviceName: "") { (rm:[RegisterModel]) in
        } andFailureBlock: { (result) in
        }
    }
}

//
//  ViewController.swift
//  APIRequestArchitecture
//
//  Created by devang bhavsar on 02/04/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupAPIRequest()
    }

    func  setupAPIRequest() {
        let url = "https://gfmbusiness-1c43d-default-rtdb.firebaseio.com/" //"https://jsonplaceholder.typicode.com/posts"
        DispatchQueue.global(qos: .userInteractive).sync {
//            APIRequestURL().getRequest(serviceName: url) { (rm:GFMList) in
//                print("Data = \(rm.gFM?.farsan)")
////                for value in rm {
////                    print("selected Data = \(value.title ?? "")")
////                }
//            } andFailureBlock: { (result) in
//                print("Failed Error = \(result)")
//            }
            
            APIRequest().getRequest(serviceName: url) { (rm:GFMList) in
                print("Data = \(rm.gFM?.farsan)")
            } andFailureBlock: { (error) in
                print("Failed Error = \(error)")
            }

        }
    }
}


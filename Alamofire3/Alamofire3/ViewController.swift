//
//  ViewController.swift
//  Alamofire3
//
//  Created by Droadmin on 17/08/23.
//

import UIKit
import Alamofire
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ApiManager.objApiManager.getAPICall(url: "https://jsonplaceholder.typicode.com/todos") { result in
            print(result)
        }
        // Do any additional setup after loading the view.
    }


}


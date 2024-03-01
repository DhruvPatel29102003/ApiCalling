//
//  ViewController.swift
//  AlamoFire2
//
//  Created by Droadmin on 10/08/23.
//

import UIKit
import Alamofire
class ViewController: UIViewController {
    var apiData:[Model] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        ApiManager.objApiManager.getAPICall(url: "https://jsonplaceholder.typicode.com/todos") { result in
            print(result)
            switch result{
            case .success(let data):
                if let dataArray = data as? [[String:Any]]{
                    for item in dataArray{
                        if let id = item["id"] as? Int,let completed = item["completed"] as? Bool{
                            let model = Model(id: id, complition: completed)
                            self.apiData.append(model)
                        }
                    }
                }
                print(self.apiData)
            case .failure(_):
                print("error")
            }
        }
        // Do any additional setup after loading the view.
    }
    
}





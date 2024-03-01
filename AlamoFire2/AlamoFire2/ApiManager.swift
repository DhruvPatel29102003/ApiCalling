//
//  ApiManager.swift
//  AlamoFire2
//
//  Created by Droadmin on 11/08/23.
//

import Foundation
import Alamofire
class ApiManager{
    static let objApiManager = ApiManager()
    private init(){}
    func getAPICall(url: String, completion: @escaping(Result<[Any],Error>) -> Void) {
        AF.request(url).response { response in
            if let data = response.data{
                do{
                    let jasonData = try JSONSerialization.jsonObject(with: data) as? [[String : Any]]
                     completion(.success(jasonData ?? []))
                }catch{
                    
                }
            }
        }
    }
}

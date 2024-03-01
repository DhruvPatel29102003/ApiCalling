//
//  SingleTone.swift
//  Singleton
//
//  Created by Droadmin on 8/2/23.
//

import Foundation
class Singletone{
    static let singleTone = Singletone()
    
    
    private init(){}
   
    func fatchApiData( url:String, completion: @escaping(Result<[Any],Error>) -> Void) {
       
       let url = URL(string: url)
        let session = URLSession.shared.dataTask(with: url!) { data, response, error in
            if let error = error{
                completion(.failure(error))
                return
            }
            
            do{
              //  let responseData = try JSONDecoder().decode([ApiData].self, from: data!)
               // completion(.success(responseData))
                if let jsonData = data{
                    
                    if let jsonDict = try JSONSerialization.jsonObject(with: jsonData) as? [[String : Any]]{
//                        var storeData: [Any] = []
//                        for item in jsonDict{
//
//                            if let id = item["id"] as? Int, let completed = item["completed"] as? Bool, let title = item["title"] as? String{
//                                let data = ApiData(id: id, completed: completed, title: title)
//                                storeData.append(data)
//                            }
//                        }

                        completion(.success(jsonDict))
                    }
                }
            }catch{
                completion(.failure(error))
            }
        
        }
        session.resume()
    }
    
    
       
}

//
//  ViewController.swift
//  ApiCalling 2
//
//  Created by Droadmin on 7/14/23.
//

import UIKit

class ViewController: UIViewController {
    var read: [readData] = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchApi(URL: "https://api-dev-scus-demo.azurewebsites.net/api/Animal/GetAnimals") { result in
            print(result)
            self.read = result
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    func fetchApi(URL url:String, completion: @escaping([readData])-> Void){
        let url = URL(string: url)
        let session = URLSession.shared.dataTask(with: url!) {data,response,error in
            
            do{
                if let jsonData = data{
                    if let jsonDict = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                        
                        
                        if let item = jsonDict["data"] as? [[String: Any]] {
                            var result:[readData] = []
                            for item in item{
                                if let title = item["name"] as? String, let img = item["image"] as? String {
                                    let toDoItem = readData(title:title , img: img)
                                    result.append(toDoItem)
                                }
                            }
                            completion(result)
                        }
                        
                    }
                }
            }catch{
                print("error\(error)")
            }
        }
        session.resume()
    }
    
}
extension UIImageView{
    private static var imageCache = NSCache<NSString, UIImage>()
    func downloadImage(from url: URL) {
        DispatchQueue.main.async {
            self.image = nil
        }
        
        
        
        if let cachedImage = UIImageView.imageCache.object(forKey: url.absoluteString as NSString)  {
            DispatchQueue.main.async {
                self.image = cachedImage
            }
            
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpRosponse = response as? HTTPURLResponse,httpRosponse.statusCode == 200,let mimeType = response?.mimeType,mimeType.hasPrefix("image"),let data = data,
                  let image = UIImage(data: data),
                  error == nil else {
                //multipurpose internet mail extensions
                return
            }
            UIImageView.imageCache.setObject(image, forKey: url.absoluteString as NSString)
            DispatchQueue.main.async {
                
                self.image = image
            }
        }
        dataTask.resume()
    }
}

extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return read.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as! MyTableViewCell
        
        cell.name.text = read[indexPath.row].title
        if let imageUrlString = read[indexPath.row].img,
           let imageUrl = URL(string: imageUrlString) {
            DispatchQueue.global().async {
                cell.apiImage.downloadImage(from: imageUrl)
            }
        }
        return cell
    }
    
    
}

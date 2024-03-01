//
//  ViewController.swift
//  Apicalling SD
//
//  Created by Droadmin on 7/14/23.
//

import UIKit
import SDWebImage
class ViewController: UIViewController {
    var readData:[FatchData] = []
    var activityIndicator: UIActivityIndicatorView!

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoader()
        showLoader()
        fetchApi(URL: "https://api-dev-scus-demo.azurewebsites.net/api/Animal/GetAnimals") { result in

            print(result)
            self.readData = result
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.hideLoader()

            }

        }
        // Do any additional setup after loading the view.
    }
    func setupLoader() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        activityIndicator.color = UIColor.red
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
    }

    func showLoader() {
        activityIndicator.startAnimating()
        //view.isUserInteractionEnabled = false
    }

    func hideLoader() {
        activityIndicator.stopAnimating()
        //view.isUserInteractionEnabled = true
    }

    func fetchApi(URL url:String, completion: @escaping([FatchData])-> Void){
        let url = URL(string: url)
        let session = URLSession.shared.dataTask(with: url!) {data,response,error in
            
            do{
                if let jsonData = data{
                    if let jsonDict = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                        
                        
                        if let item = jsonDict["data"] as? [[String: Any]] {
                            var result:[FatchData] = []
                            for item in item{
                                if let title = item["name"] as? String, let img = item["image"] as? String {
                                    let toDoItem = FatchData(name: title, image: img)
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
extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return readData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as! MyTableViewCell
        cell.fatchNameLbl.text = readData[indexPath.row].name
        cell.fatchImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.fatchImage.sd_imageIndicator?.startAnimatingIndicator()
        cell.fatchImage.sd_setImage(with: URL(string: readData[indexPath.row].image), placeholderImage: UIImage(named: "Blank Image"), context: nil)

        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        let transform = CATransform3DTranslate(CATransform3DIdentity, -250 , 20, 0)
        cell.layer.transform = transform
        UIView.animate(withDuration: 1.0) {
            cell.alpha = 1
            cell.layer.transform = CATransform3DIdentity
        }
    }
    
    
}



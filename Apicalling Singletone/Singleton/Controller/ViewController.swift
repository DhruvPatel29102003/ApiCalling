//
//  ViewController.swift
//  Singleton
//
//  Created by Droadmin on 8/2/23.
//

import UIKit
import SDWebImage
class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource{
    
    var apiData:[ApiData] = []

    @IBOutlet weak var collctionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collctionView.delegate = self
        collctionView.dataSource = self

        Singletone.singleTone.fatchApiData(url: "https://dummyapi.online/api/products") { result in
            print(result)
            switch result{
                
            case .success(let data):
                if let dataArray = data as? [[String: Any]] {
                    //var storeData: [ApiData] = []
                    for item in dataArray {
                        if let title = item["name"] as? String,let image = item["image"] as? String{
                            let data = ApiData(title: title, image: image)
                            self.apiData.append(data)
                        }
                    }
                    //self.apiData = storeData
                    DispatchQueue.main.async {
                        self.collctionView.reloadData()
                    }
                }
            case .failure(_):
                print("error")
            }
     
        }
        
        // Do any additional setup after loading the view.
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apiData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath) as! MyCollectionViewCell
        cell.movieName.text = apiData[indexPath.row].title
        
        cell.movieImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.movieImage.sd_imageIndicator?.startAnimatingIndicator()
        cell.movieImage.sd_setImage(with: URL(string: apiData[indexPath.row].image ?? "" ), placeholderImage: UIImage(named: "movie-clapper-open"), context: nil)
//        cell.idLbl.text = String(apiData[indexPath.row].id)
//        cell.tfLbl.backgroundColor = apiData[indexPath.row].completed ? UIColor.green : UIColor.red
 //     cell.tfLbl.layer.cornerRadius = 10
//        cell.tfLbl.clipsToBounds = true
//        cell.titleLbl.text = apiData[indexPath.row].title
        cell.layer.cornerRadius = 10
        
        
        cell.layer.shadowColor = UIColor.green.cgColor
        cell.layer.shadowOpacity = 1
        cell.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.layer.shadowRadius = 4
        cell.layer.masksToBounds = false
        
        return cell
    }


}


//https://jsonplaceholder.typicode.com/todos

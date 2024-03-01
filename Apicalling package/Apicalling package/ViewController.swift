//
//  ViewController.swift
//  Apicalling package
//
//  Created by Droadmin on 7/14/23.
//

import UIKit
import SDWebImage
class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var objDbManger = DbManger()
    var readData:[FatchData] = []
    var serching = false
    var serchingName:[FatchData] = []
    let searchController = UISearchController(searchResultsController: nil)
    var sectionDic:[String: [FatchData]] = [:]
    var animalName = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Animal"
        objDbManger.openDatabase()
        objDbManger.createTable()
    
        
        configureSerachController()
        fetchApi(URL: "https://api-dev-scus-demo.azurewebsites.net/api/Animal/GetAnimals") { result in
            print(result)
            self.readData = result
            self.indexing()
            
            DispatchQueue.main.async {
                self.tableView.reloadData()

            }
        }
        // Do any additional setup after loading the view.
    }
    func configureSerachController(){
         searchController.loadViewIfNeeded() //Ensures that the search controller's view is loaded if needed.

         searchController.searchResultsUpdater = self  // Set the delegate for handling search results updates.
         searchController.searchBar.delegate = self  // Set the delegate for handling search bar-related events.
         searchController.obscuresBackgroundDuringPresentation = false
         //searchController.searchBar.enablesReturnKeyAutomatically = false
         //searchController.searchBar.returnKeyType = UIReturnKeyType.done
         self.navigationItem.searchController = searchController
         self.navigationItem.hidesSearchBarWhenScrolling = false
         //definesPresentationContext = true
         searchController.searchBar.placeholder = "Search Animal Name"
        tableView.tableHeaderView = searchController.searchBar

     }
    func indexing(){
        animalName = Array(Set(readData.map({String($0.name.prefix(1))})))
        animalName.sort()

        for item in animalName {
            sectionDic[item] = []
        }
        for item in readData {
            if let firstLetter = item.name.first {
                let key = String(firstLetter)
                sectionDic[key]?.append(item)
            }
        }


       // tableView.reloadData()
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
                                    
                                    self.objDbManger.insertData(name: title, image: img)
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
extension ViewController:UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            if searchText.isEmpty {
                serching = false
                
                
            } else {
                serching = true
                serchingName = readData.filter { $0.name.lowercased().contains(searchText.lowercased()) }
            }
            tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if serching{
            return 1
        }else{
            return animalName.count
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if serching{
            return serchingName.count
        }else{
            return sectionDic[animalName[section]]?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as! MyTableViewCell
        let rowData: FatchData
        if serching{
            rowData = serchingName[indexPath.row]
        }else{
            rowData = (sectionDic[animalName[indexPath.section]]?[indexPath.row])!
        }
        //objDbManger.insertData(name: cell.fatchNameLbl.text ?? "", image: cell.fatchImage.image)
       
              
                   cell.fatchNameLbl.text = rowData.name
                   cell.fatchImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
                   cell.fatchImage.sd_imageIndicator?.startAnimatingIndicator()
                   cell.fatchImage.sd_setImage(with: URL(string: rowData.image), placeholderImage: UIImage(named: "Blank Image"), context: nil)
       
              
           
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if serching{
            return nil
        }else{
        return animalName[section]
      }
    }
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        if serching{
            return nil
        }else{
            return animalName
        }
    }
    
}







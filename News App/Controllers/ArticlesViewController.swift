//
//  ArticlesViewController.swift
//  News App
//
//  Created by Mohamed Ali on 3/14/20.
//  Copyright © 2020 Mohamed Ali. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class ArticlesViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
   
    @IBOutlet weak var TXTTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var x = 0
    var url = ""
    var apiKey = "37ec23115f1f4c94bec11b635203f9b6"
    var ArticleArray = [ArticleData]()
    var dic : [String:String]?

    override func viewDidLoad() {
        super.viewDidLoad()

        // identifier Cell.
        tableView.register(UINib(nibName: "ArticleCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        LoadPage()
    }
    
    @IBAction func BTNBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ArticleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ArticleCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ArticleCell
        
        cell.TXTArticleName.text = ArticleArray[indexPath.row].Title
        Tools.getPhoto(URL: ArticleArray[indexPath.row].ImageURL, Image: cell.ArticleCover)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ArticleDetails", sender: ArticleArray[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ArticleDetails" {
            if let a1 = sender as? ArticleData {
                let vc = segue.destination as! DetailsViewController
                vc.ob = a1
            }
        }
    }
    
    func LoadPage() {
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let result = formatter.string(from: date)
        
        switch x {
        case 1:
            TXTTitle.text = "All Articles About BitCoin News"
            url = "http://newsapi.org/v2/everything"
            dic = ["q":"bitcoin","from":result,"sortBy":"publishedAt","apiKey":apiKey]
            getDataFromAPI()
            break
        case 2:
            TXTTitle.text = "All Articles About Bussiness News"
            url = "http://newsapi.org/v2/top-headlines?country=us&category=business"
            dic = ["apiKey":apiKey]
            getDataFromAPI()
            break
        case 3:
            TXTTitle.text = "All Articles About Apple News"
            url = "http://newsapi.org/v2/everything"
            dic = ["q":"apple","from":result,"to":result,"sortBy":"popularity","apiKey":apiKey]
            getDataFromAPI()
            break
        case 4:
            TXTTitle.text = "All Articles About TechCranch News"
            url = "http://newsapi.org/v2/top-headlines?sources=techcrunch"
            dic = ["apiKey":apiKey]
            getDataFromAPI()
            break
        default:
            break
        }
    }
    
    func getDataFromAPI () {
        Alamofire.request(url, method: .get, parameters: dic!).responseJSON {
            response in
            if response.result.isSuccess {
                print ("Sucess for getting data!")
                let quary:JSON = JSON(response.result.value!)
                self.pareJSON(json:quary,count: quary["articles"].count)
            }
            else {
                print("Error \(response.result.error!)")
            }
        }
    }
    
    func pareJSON(json:JSON , count:Int){
        for i in 0...(count-1) {
            let ob = ArticleData()
            ob.Title = json["articles"][i]["title"].stringValue
            ob.content = json["articles"][i]["content"].stringValue
            ob.Author = json["articles"][i]["author"].stringValue
            ob.publishAt = json["articles"][i]["publishedAt"].stringValue
            ob.ImageURL = json["articles"][i]["urlToImage"].stringValue
            ob.url = json["articles"][i]["url"].stringValue
            
            ArticleArray.append(ob)
            tableView.reloadData()
        }
        SVProgressHUD.dismiss()
    }
}

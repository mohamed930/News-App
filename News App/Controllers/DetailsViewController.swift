//
//  DetailsViewController.swift
//  News App
//
//  Created by Mohamed Ali on 3/14/20.
//  Copyright © 2020 Mohamed Ali. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import MarqueeLabel

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var CoverArticle: UIImageView!
    @IBOutlet weak var TXTArticleAuthor: UILabel!
    @IBOutlet weak var TXTArticleDetails: UITextView!
    @IBOutlet weak var TXTArticleTime: UILabel!
    @IBOutlet weak var TXTArticletitle: MarqueeLabel!
    
    
    var ob:ArticleData?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadData()
    }
    
    @IBAction func BTNBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func BTNSave(_ sender: Any) {
        SaveOnCoreData()
    }
    
    @IBAction func BTNReadMore(_ sender: Any) {
        let url1 = URL(string: ob!.url)
        Tools.openSafari(for: url1!, ob: self)
    }
    
    func loadData () {
        Tools.setRounded(ImageName: "TXTArea", TXTArticleDetails)
        TXTArticleDetails.backgroundColor = .clear
        Tools.setMarqueeSpead(for: TXTArticletitle)
        TXTArticletitle.text = ob?.Title
        TXTArticleDetails.text = ob?.content
        TXTArticleAuthor.text = ob?.Author
        TXTArticleTime.text = ob?.publishAt
        Tools.getPhoto(URL: ob!.ImageURL, Image: CoverArticle)
        
    }
    
    func SaveOnCoreData() {
        let ob = Article(context: context)
        
        ob.title = TXTArticletitle.text
        ob.article = TXTArticleDetails.text
        ob.readmore =  URL(string: self.ob!.url)
        
        // This Sektion Of Code For Download Image And Save it in CoreData.
        SVProgressHUD.show()
        Alamofire.request(URL(string: self.ob!.ImageURL)!).responseData {
            (response) in
            if response.error != nil {
                Tools.createAlert(Title: "Failed", Mess: "\(response.result)", ob: self)
            }
            
            if let data = response.data {
                ob.image = UIImage(data: data)
                ad.saveContext()
                SVProgressHUD.dismiss()
                Tools.createAlert(Title: "Success", Mess: "Your Article is Saved Successfully", ob: self)
            }
        }
    }
    
}

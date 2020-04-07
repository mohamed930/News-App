//
//  DetailsSavedViewController.swift
//  News App
//
//  Created by Mohamed Ali on 3/15/20.
//  Copyright © 2020 Mohamed Ali. All rights reserved.
//

import UIKit
import MarqueeLabel

class DetailsSavedViewController: UIViewController {
    
    @IBOutlet weak var TXTTitle: MarqueeLabel!
    @IBOutlet weak var ArticleImage: UIImageView!
    @IBOutlet weak var TXTDetails: UITextView!
    var aob:Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ReadData()
    }
    
    @IBAction func BTNBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func BTNMoreArticle(_ sender: Any) {
        Tools.openSafari(for: (self.aob?.readmore!)!, ob: self)
    }
    
    func ReadData () {
        TXTTitle.text = aob?.title
        TXTDetails.text = aob?.article
        ArticleImage.image = (aob?.image as! UIImage)
        Tools.setMarqueeSpead(for: TXTTitle)
        Tools.setRounded(ImageName: "TXTArea", TXTDetails)
        TXTDetails.backgroundColor = .clear
    }
}

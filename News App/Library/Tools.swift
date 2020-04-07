//
//  Tools.swift
//  News App
//
//  Created by Mohamed Ali on 3/15/20.
//  Copyright © 2020 Mohamed Ali. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SVProgressHUD
import MarqueeLabel
import SafariServices

class Tools {
    
    public static func getPhoto (URL:String,Image:UIImageView) {
        SVProgressHUD.show()
        Alamofire.request(URL).responseImage(completionHandler: {
            (response) in
            if let image1 = response.result.value {
                let size = CGSize(width: 1000.0, height: 1000.0)
                let scaleImage = image1.af_imageScaled(to: size)
                DispatchQueue.main.async {
                    Image.image = scaleImage
                    SVProgressHUD.dismiss()
                }
            }
        })
    }
    
    public static func setMarqueeSpead (for Label:MarqueeLabel) {
        Label.type = .continuous
        Label.speed = .duration(10.0)
        Label.animationCurve = .easeInOut
        Label.fadeLength = 10.0
        Label.leadingBuffer = 5.0
        Label.trailingBuffer = 5.0
    }
    
    public static func createAlert (Title:String , Mess:String , ob:UIViewController)
    {
        let alert = UIAlertController(title: Title , message:Mess
            , preferredStyle:UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title:"OK",style:UIAlertAction.Style.default,handler: {(action) in alert.dismiss(animated: true, completion: nil)}))
        ob.present(alert,animated:true,completion: nil)
    }
    
    public static func setRounded (ImageName:String , _ textArea : AnyObject) {
        let img = UIImageView(frame: textArea.bounds)
        img.image = UIImage(named: ImageName)
        textArea.addSubview(img)
        textArea.sendSubviewToBack(img)
        //textArea.backgroundColor = .clear
    }
    
    public static func openSafari(for url:URL,ob:UIViewController) {
        let safariVC = SFSafariViewController(url: url)
        ob.present(safariVC, animated: true)
    }
}

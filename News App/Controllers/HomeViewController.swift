//
//  ViewController.swift
//  News App
//
//  Created by Mohamed Ali on 3/14/20.
//  Copyright © 2020 Mohamed Ali. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var home = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.        
    }
    
    @IBAction func BTNBitCoin(_ sender: Any) {
        switch (sender as AnyObject).tag {
        case 1:
            home = 1
            break
        case 2:
            home = 2
            break
        case 3:
            home = 3
            break
        case 4:
            home = 4
            break
        default: break
        }
        performSegue(withIdentifier: "GetArticles", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GetArticles" {
            let vc = segue.destination as! ArticlesViewController
            vc.x = home
        }
    }
    
}


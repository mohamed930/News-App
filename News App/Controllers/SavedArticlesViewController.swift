//
//  SavedArticlesViewController.swift
//  News App
//
//  Created by Mohamed Ali on 3/15/20.
//  Copyright © 2020 Mohamed Ali. All rights reserved.
//

import UIKit
import CoreData

class SavedArticlesViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
   
    @IBOutlet weak var tableView: UITableView!
    var ArticleArray = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "ArticleCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        fetchData()
    }
    
    @IBAction func BTNBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func fetchData() {
        let fetchrequest:NSFetchRequest<Article> = Article.fetchRequest()
        do {
            ArticleArray = try! context.fetch(fetchrequest)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ArticleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ArticleCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ArticleCell
        cell.TXTArticleName.text = ArticleArray[indexPath.row].title
        cell.ArticleCover.image = (ArticleArray[indexPath.row].image as? UIImage)
        cell.backgroundColor = UIColor.lightGray
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            
            let alert = UIAlertController(title: "Attention", message: "Are You Sure To Delete Article?", preferredStyle: .alert)
            let action1 = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(action1)
            let action2 = UIAlertAction(title: "Delete", style: .destructive) { (alert) in
                do {
                    context.delete(self.ArticleArray[indexPath.row])
                    ad.saveContext()
                    self.fetchData()
                }
            }
            alert.addAction(action2)
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "Details", sender: ArticleArray[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Details" {
            if let f1 = sender as? Article{
                let vc = segue.destination as! DetailsSavedViewController
                vc.aob = f1
            }
        }
    }
    
}

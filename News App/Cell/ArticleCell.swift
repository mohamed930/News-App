//
//  ArticleCell.swift
//  News App
//
//  Created by Mohamed Ali on 3/14/20.
//  Copyright © 2020 Mohamed Ali. All rights reserved.
//

import UIKit
import MarqueeLabel

class ArticleCell: UITableViewCell {

    @IBOutlet weak var Cell: UIView!
    @IBOutlet weak var ArticleCover: UIImageView!
    @IBOutlet weak var TXTArticleName: MarqueeLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.Cell.layer.cornerRadius = 15
        self.Cell.layer.masksToBounds = true
        
        // Set Marquee Label :-
        Tools.setMarqueeSpead(for: TXTArticleName)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 10, bottom: 10, right: 10))
    }
}

//
//  MovieTableViewCell.swift
//  TheMovieApp
//
//  Created by juanki on 2/16/22.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var imageMovie: UIImageView!
    
    @IBOutlet weak var titleMovieLabel: UILabel!
    @IBOutlet weak var descriptionMovieLabel: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        self.descriptionMovieLabel.lineBreakMode = .byWordWrapping
        self.descriptionMovieLabel.numberOfLines = 0
     
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       

        // Configure the view for the selected state
    }
    
}

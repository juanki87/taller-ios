//
//  CustomMovieCellTableViewCell.swift
//  TheMovieApp
//
//  Created by juanki on 2/10/22.
//

import UIKit

class CustomMovieCell: UITableViewCell {

    @IBOutlet weak var imageMovie: UIImageView!
    
    
    @IBOutlet weak var titleMovieLabel: UILabel!
    
    @IBOutlet weak var descriptionMovieLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

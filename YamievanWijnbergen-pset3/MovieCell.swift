//
//  MovieCell.swift
//  YamievanWijnbergen-pset3
//
//  Created by Yamie van Wijnbergen on 21/04/2017.
//  Copyright © 2017 Yamie van Wijnbergen. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {


    @IBOutlet weak var movieTitle: UITextView!
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieYear: UILabel!
    
    var imdbID: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

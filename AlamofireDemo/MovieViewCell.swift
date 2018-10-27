//
//  MovieDetailsViewCell.swift
//  AlamofireDemo
//
//  Created by Dmitry on 10/26/18.
//  Copyright © 2018 Dmitry. All rights reserved.
//

import UIKit

class MovieViewCell: UITableViewCell {

    
    @IBOutlet weak var movieImage: UIImageView!
    var movieId : String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

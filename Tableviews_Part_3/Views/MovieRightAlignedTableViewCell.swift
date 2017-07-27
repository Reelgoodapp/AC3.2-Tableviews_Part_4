//
//  MovieRightAlignedTableViewCell.swift
//  Tableviews_Part_3
//
//  Created by Louis Tur on 7/27/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class MovieRightAlignedTableViewCell: UITableViewCell {
	
	@IBOutlet weak var moviePosterImageView: UIImageView!
	@IBOutlet weak var movieTitleLabel: UILabel!
	@IBOutlet weak var movieSummaryLabel: UILabel!
 
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
	
}

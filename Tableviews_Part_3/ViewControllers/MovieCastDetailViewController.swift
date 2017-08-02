//
//  MovieCastDetailViewController.swift
//  Tableviews_Part_4
//
//  Created by Louis Tur on 8/2/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class MovieCastDetailViewController: UIViewController {

	@IBOutlet weak var castTitleLabel: UILabel!
	@IBOutlet weak var castListLabel: UILabel!
	
	var selectedMovie: Movie!
    override func viewDidLoad() {
        super.viewDidLoad()
		self.updateViews(for: selectedMovie)
		
		self.title = selectedMovie.title
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	
	func updateViews(for movie: Movie) {
		var castString = ""
		for actor in movie.cast {
			castString += "- \(actor.firstName) \(actor.lastName)\n"
		}
		
		self.castListLabel.text = castString
	}
}

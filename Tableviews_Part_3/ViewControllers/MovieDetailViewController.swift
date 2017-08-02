//
//  MovieDetailViewController.swift
//  Tableviews_Part_4
//
//  Created by Louis Tur on 8/2/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
	@IBOutlet weak var moviePosterImageView: UIImageView!
	@IBOutlet weak var genreLabel: UILabel!
	@IBOutlet weak var locationLabel: UILabel!
	@IBOutlet weak var summaryFullTextLabel: UILabel!
	@IBOutlet weak var summaryLabel: UILabel!
	
	var selectedMovie: Movie!
	override func viewDidLoad() {
        super.viewDidLoad()
		self.updateViews(for: selectedMovie)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func updateViews(for movie: Movie) {
		self.moviePosterImageView.image = UIImage(named: movie.poster)!
		self.genreLabel.text = "Genre: " + movie.genre.capitalized
		self.locationLabel.text = "Locations: " + movie.locations.joined(separator: ", ")
		self.summaryFullTextLabel.text = movie.summary
	}
}

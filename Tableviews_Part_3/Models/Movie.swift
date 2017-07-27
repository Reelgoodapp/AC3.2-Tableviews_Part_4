//
//  Movie.swift
//  Tableviews_Part_3//
//  Created by Louis Tur on 9/20/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

import Foundation

class Movie {
	
	var title: String
	var year: Int
	var genre: String
	var cast: [Actor]
	var locations: [String]
	var summary: String
	var poster: String
	
	init(title: String, year: Int, genre: String, cast: [String], locations: [String], summary: String, poster: String) {
		self.title = title
		self.year = year
		self.genre = genre
		self.cast = cast.map{ Actor(from: $0) }
		self.locations = locations
		self.summary = summary
		self.poster = poster
	}
	
	convenience init(from dict: [String : Any]) {
		if let movieTitle = dict["name"] as? String,
			let movieYear = dict["year"] as? Int,
			let movieGenre = dict["genre"] as? String,
			let movieCast = dict["cast"] as? [String],
			let movieLocations = dict["locations"] as? [String],
			let movieSummary = dict["description"] as? String,
			let moviePoster = dict["poster"] as? String {
			
			self.init(title: movieTitle, year: movieYear, genre: movieGenre, cast: movieCast, locations: movieLocations, summary: movieSummary, poster: moviePoster)
		}
		else {
			self.init()
		}
	}
	
	init() {
		self.title = ""
		self.year = 1970
		self.genre = ""
		self.cast = []
		self.locations = []
		self.summary = ""
		self.poster = ""
	}
}

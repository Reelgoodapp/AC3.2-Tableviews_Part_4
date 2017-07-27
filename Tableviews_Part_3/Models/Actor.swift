//
//  Actor.swift
//  Tableviews_Part_3//
//  Created by Louis Tur on 9/20/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

class Actor {
	
	var firstName: String
	var lastName: String
	
	init() {
		self.firstName = ""
		self.lastName = ""
	}
	
	init(firstName: String, lastName: String) {
		self.firstName = firstName
		self.lastName = lastName
	}
	
	convenience init(from string: String) {
		let nameComponents: [String] = string.components(separatedBy: " ")
		if let firstName: String = nameComponents.first,
			let lastName:String = nameComponents.last {
			self.init(firstName: firstName, lastName: lastName)
		}
		else {
			self.init()
		}
		
	}
}

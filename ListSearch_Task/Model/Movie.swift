//
//  Movie.swift
//  ListSearch_Task
//
//  Created by Admin on 12/14/20.
//

import Foundation

struct Movie : Codable {
	let title : String?
	let image : String?
	let rating : Double?
	let releaseYear : Int?
	let genre : [String]?
}

//
//  MovieAPIService.swift
//  ListSearch_Task
//
//  Created by Admin on 12/14/20.
//

import Foundation
import UIKit

class MovieAPIService: NSObject, Requestable {

	static let instance = MovieAPIService()
	public var movies: [Movie]?
	
	func fetchMovies(callback: @escaping Handler) {
		request(method: .get, url: Domain.baseUrl() + APIEndpoint.movies) { (result) in
		   callback(result)
		}
	}
}

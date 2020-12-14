//
//  MovieViewModel.swift
//  ListSearch_Task
//
//  Created by Admin on 12/14/20.
//

import Foundation
import UIKit

protocol MovieViewModelProtocol {
	var movieDidChanges: ((Bool, Bool) -> Void)? { get set }
	func fetchMovieList()
}


class MovieViewModel: MovieViewModelProtocol {

	//MARK: - Internal Properties
	var movieDidChanges: ((Bool, Bool) -> Void)?
	var movies: [Movie]? {
		didSet {
			self.movieDidChanges!(true, false)
		}
	}
	
	func fetchMovieList() {
		self.movies = [Movie]()
		MovieAPIService.instance.fetchMovies { result in
			switch result {
			case .success(let data):
				let mappedModel = try? JSONDecoder().decode([Movie].self, from: data) as [Movie]
				self.movies = mappedModel ?? []
				break
			case .failure(let error):
				
				print(error.description)
			}
		}
	}
}


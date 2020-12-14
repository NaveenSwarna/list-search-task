//
//  MovieDetailViewController.swift
//  ListSearch_Task
//
//  Created by Admin on 12/14/20.
//

import UIKit

class MovieDetailViewController: UIViewController {
	@IBOutlet var titleLabel: UILabel!
	@IBOutlet var yearLabel: UILabel!
	@IBOutlet var picture: UIImageView!
	@IBOutlet var ratingsView: UILabel!
	
	@IBOutlet var genreLabel: UILabel!
	var selectedMovie : Movie?
	

    override func viewDidLoad() {
        super.viewDidLoad()
		setUpData()
	
    }
	
	func setUpData()  {
		if let movie = selectedMovie {
			self.titleLabel?.text = movie.title ?? ""
			if let year = movie.releaseYear {
				self.yearLabel?.text = "\(year)"
			}
			if let rating = movie.rating {
				self.ratingsView?.text = "\(rating)"
			}
			
			if let genere = movie.genre?.joined(separator: ", ") {
				self.genreLabel?.text = genere
			}
			self.picture?.setImage(withImageId: movie.image ?? "", placeholderImage: #imageLiteral(resourceName: "placeholder"), size: .original)
			self.picture?.contentMode = .scaleToFill
		}
	}
}

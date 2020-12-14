//
//  MovieViewCell.swift
//  ListSearch_Task
//
//  Created by Admin on 12/14/20.
//

import UIKit

class MovieViewCell: UITableViewCell {
	
	@IBOutlet weak var picture: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var releaseYearLabel: UILabel!
	var movieItem: Movie? {
		didSet {
			if let movie = movieItem {
				self.titleLabel.text = movie.title ?? ""
				
				if let year = movie.releaseYear {
					self.releaseYearLabel.text = "\(year)"
				}
				self.picture.setImage(withImageId: movie.image ?? "", placeholderImage: #imageLiteral(resourceName: "placeholder"), size: .original)
				self.picture.contentMode = .scaleToFill
			}
		}
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		self.selectionStyle = .none
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		// Configure the view for the selected state
	}
}

//
//  MovieViewController.swift
//  ListSearch_Task
//
//  Created by Admin on 12/14/20.
//

import Foundation
import UIKit

class MovieViewController: UIViewController {
	
	//MARK: Internal Properties
	
	let tableView = UITableView()
	let viewModel = MovieViewModel()
	var safeArea: UILayoutGuide!
	
	let searchController = UISearchController(searchResultsController: nil)
	var filteredMovies: [Movie] = []
	
	var searchFooterBottomConstraint: NSLayoutConstraint!
	
	var isSearchBarEmpty: Bool {
		return searchController.searchBar.text?.isEmpty ?? true
	}
	
	var isFiltering: Bool {
		let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
		return searchController.isActive && (!isSearchBarEmpty || searchBarScopeIsFiltering)
	}
	
	
	override func loadView() {
		super.loadView()
		safeArea = view.layoutMarginsGuide
		prepareTableView()
		setSearchBar()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		prepareViewModelObserver()
		setHeaderTitle()
		fetchMovieList()
	}
	
	func setHeaderTitle() {
		self.navigationItem.title = Strings.appTitle
	}
	
	func setSearchBar() {
		searchController.searchResultsUpdater = self
		searchController.obscuresBackgroundDuringPresentation = false
		searchController.searchBar.placeholder = "Search Movies"
		navigationItem.searchController = searchController
		definesPresentationContext = true
		searchController.searchBar.delegate = self
		let notificationCenter = NotificationCenter.default
		notificationCenter.addObserver(forName: UIResponder.keyboardWillChangeFrameNotification,
									   object: nil, queue: .main) { (notification) in
			self.handleKeyboard(notification: notification) }
		notificationCenter.addObserver(forName: UIResponder.keyboardWillHideNotification,
									   object: nil, queue: .main) { (notification) in
			self.handleKeyboard(notification: notification) }
	}
	
	
	
	
	func filterContentForSearchText(_ searchText: String) {
		filteredMovies = (viewModel.movies ?? []).filter { (movie: Movie) -> Bool in
			return (movie.title?.lowercased().contains(searchText.lowercased()) ?? false)
		}
		tableView.reloadData()
	}
	
	func handleKeyboard(notification: Notification) {
		guard notification.name == UIResponder.keyboardWillChangeFrameNotification else {
			searchFooterBottomConstraint.constant = 0
			view.layoutIfNeeded()
			return
		}
		
		guard
			let info = notification.userInfo,
			let keyboardFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
		else {
			return
		}
		let keyboardHeight = keyboardFrame.cgRectValue.size.height
		UIView.animate(withDuration: 0.1, animations: { () -> Void in
			self.searchFooterBottomConstraint.constant = keyboardHeight
			self.view.layoutIfNeeded()
		})
	}
}

//MARK: Prepare UI

extension MovieViewController {
	func prepareTableView() {
		self.view.backgroundColor = .white
		self.tableView.separatorStyle   = .none
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.accessibilityIdentifier = "tableView"
		self.tableView.register(UINib(nibName: "MovieViewCell", bundle: nil), forCellReuseIdentifier: "MovieViewCell")
		self.view.addSubview(self.tableView)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
		tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		searchFooterBottomConstraint = tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
		searchFooterBottomConstraint.isActive = true
		tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
	}
}

//MARK: Private Methods

extension MovieViewController {
	
	func fetchMovieList() {
		viewModel.fetchMovieList()
	}
	
	func prepareViewModelObserver() {
		self.viewModel.movieDidChanges = { (finished, error) in
			if !error {
				self.reloadTableView()
			}
		}
	}
	func reloadTableView() {
		self.tableView.reloadData()
	}
}

// MARK: - UITableView Delegate And Datasource Methods

extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return isFiltering ? filteredMovies.count : viewModel.movies!.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell: MovieViewCell = tableView.dequeueReusableCell(withIdentifier: "MovieViewCell", for: indexPath as IndexPath) as? MovieViewCell else {
			fatalError("MovieViewCell cell is not found")
		}
		let movie =  isFiltering ? filteredMovies[indexPath.row] : viewModel.movies![indexPath.row]
		cell.movieItem = movie
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 100
	}
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.view.endEditing(true)
		let vc = MovieDetailViewController(nibName: nil, bundle: nil)
		let movie =  isFiltering ? filteredMovies[indexPath.row] : viewModel.movies![indexPath.row]
		vc.selectedMovie = movie
		self.navigationController?.pushViewController(vc, animated: true)
	}
}

extension MovieViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
	let searchBar = searchController.searchBar
	filterContentForSearchText(searchBar.text!)
  }
}

extension MovieViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
	filterContentForSearchText(searchBar.text!)
  }
}


//
//  HomeView.swift
//  StoriTest
//
//  Created by Cristian Hernandez Garcia on 01/03/24.
//

import UIKit

class HomeView: UIViewController {
    
    var presenter: HomePresenterProtocol?
    
    var movies: [Results]?
    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()
    private var currentPage = 0
    private var isFetchingData = false
    
    override func viewDidLoad() {
        configUI()
        presenter?.fetchMovies(currentPage: currentPage)
    }
    
    private func configUI() {
        configureNavBar()
        configureTableView()
    }
    
    private func configureNavBar() {
        title = Constants.title
        let backButton = UIBarButtonItem(title: Constants.empty, style: .plain, 
                                         target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.tintColor = UIColor(hex: Colors.green900)
        navigationController?.navigationBar.barTintColor = UIColor(hex: Colors.green200)
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(hex: Colors.green900)
        ]
    }
    
    private func configureTableView() {
        tableView.frame = view.bounds
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HomeViewCell.self,
                           forCellReuseIdentifier: Constants.homeCell)
        view.addSubview(tableView)
    }
}

extension HomeView: HomeViewProtocol {
    func showErrorData() {
        showCustomAlert(title: Constants.sorry,
                        message: Constants.errorData)
    }
    
    func showErrorInternet() {
        showCustomAlert(title: Constants.sorry,
                        message: Constants.errorInternet)
    }
    
    func setMovieData(movies: [Results]) {
        defer { self.isFetchingData = false }
        
        guard let existingMovies = self.movies, !existingMovies.isEmpty else {
            self.movies = movies
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
            return
        }
        
        let startIndex = existingMovies.count
        self.movies?.append(contentsOf: movies)
        let indexPaths = (startIndex..<self.movies!.count).map { IndexPath(row: $0,
                                                                           section: 0) }
        
        DispatchQueue.main.async { [weak self] in
            self?.tableView.insertRows(at: indexPaths, with: .automatic)
        }
    }
}

extension HomeView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies?.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.homeCell,
                                                 for: indexPath) as! HomeViewCell
        guard let movie = movies?[indexPath.row] else { return cell }
        cell.selectionStyle = .none
        cell.setData(movie: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat.twoHundred
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movie = movies?[indexPath.row] else { return }
        presenter?.goToDetail(movie: movie)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.size.height, !isFetchingData {
            isFetchingData = true
            currentPage += 1
            presenter?.fetchMovies(currentPage: currentPage)
        }
    }
}

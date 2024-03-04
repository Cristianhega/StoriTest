//
//  HomeInteractor.swift
//  StoriTest
//
//  Created by Cristian Hernandez Garcia on 01/03/24.
//

import UIKit

class HomeInteractor: HomeInteractorProtocol {
    
    weak var presenter: HomeOutputInteractorProtocol?
    var allMovies: [Results] = []
    let itemsPerPage = Int(.ten)

    func getMovies(from view: UIViewController, currentPage: Int) {
        let urlString = "\(Constants.baseUrl)\(currentPage)"
        guard let url = URL(string: urlString) else { return }

        let headers = [
            Constants.accept: Constants.appjson,
            Constants.authorization: Constants.token
        ]

        URLSession.shared.fetchData(from: url, headers: headers) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let data):
                self.handleMoviesData(data, currentPage: currentPage)
            case .failure(_):
                self.presenter?.errorData()
            }
        }
    }

    private func handleMoviesData(_ data: Data, currentPage: Int) {
        do {
            let movies = try JSONDecoder().decode(Movies.self, from: data)
            guard let results = movies.results else { return }
            self.allMovies.append(contentsOf: results)
            self.presenter?.sendInfo(movies: self.currentPageMovies(for: currentPage))
        } catch {
            self.presenter?.errorData()
        }
    }

    private func currentPageMovies(for currentPage: Int) -> [Results] {
        let startIndex = (currentPage - Int(.one)) * itemsPerPage
        let endIndex = min(startIndex + itemsPerPage, allMovies.count)
        return Array(allMovies[startIndex..<endIndex])
    }
}


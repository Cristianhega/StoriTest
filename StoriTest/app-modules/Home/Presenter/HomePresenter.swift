//
//  HomePresenter.swift
//  StoriTest
//
//  Created by Cristian Hernandez Garcia on 01/03/24.
//

import UIKit

class HomePresenter: HomePresenterProtocol {
    
    weak var view: HomeViewProtocol?
    var interactor: HomeInteractorProtocol?
    var presenter: HomePresenterProtocol?
    var router: HomeRouterProtocol?

    func fetchMovies(currentPage: Int) {
        if Reachability.isConnectedToNetwork(){
            interactor?.getMovies(from: view as! UIViewController, currentPage: currentPage)
        } else {
            view?.showErrorInternet()
        }
    }
    
    func goToDetail(movie: Results) {
        router?.pushToDetailView(from: view as! UIViewController, movie: movie)
    }
}

extension HomePresenter: HomeOutputInteractorProtocol {
    
    func sendInfo(movies: [Results]) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.setMovieData(movies: movies)
        }
    }
    
    func errorData() {
        view?.showErrorData()
    }
}

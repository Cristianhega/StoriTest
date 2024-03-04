//
//  DetailPresenter.swift
//  StoriTest
//
//  Created by Cristian Hernandez Garcia on 01/03/24.
//

import UIKit

class DetailPresenter: DetailPresenterProtocol {
    
    weak var view: DetailViewProtocol?
    var interactor: DetailInteractorProtocol?
    var presenter: DetailPresenterProtocol?
    var router: DetailRouterProtocol?
    
    func setMovie(movie: Results) {
        view?.showMovieData(movie: movie)
    }
}

extension DetailPresenter: DetailOutputInteractorProtocol {
    
}

//
//  HomeProtocols.swift
//  StoriTest
//
//  Created by Cristian Hernandez Garcia on 01/03/24.
//

import UIKit

protocol HomeViewProtocol: AnyObject {
    // Presenter -> View
    func setMovieData(movies: [Results])
    func showErrorInternet()
    func showErrorData()
}

protocol HomeInputViewProtocol: AnyObject {
    // Presenter -> View
}

protocol HomePresenterProtocol: AnyObject {
    // View -> Presenter
    var interactor: HomeInteractorProtocol? {get set}
    var view: HomeViewProtocol? {get set}
    var router: HomeRouterProtocol? {get set}
    
    func fetchMovies(currentPage: Int)
    func goToDetail(movie: Results)
}

protocol HomeInteractorProtocol: AnyObject {
    var presenter: HomeOutputInteractorProtocol? {get set}
    // Presenter -> Interactor
    func getMovies(from view: UIViewController, currentPage: Int)
}

protocol HomeOutputInteractorProtocol: AnyObject {
    // Interactor -> PresenterOutput
    func sendInfo(movies: [Results])
    func errorData()
}

protocol HomeRouterProtocol: AnyObject {
    //Presenter -> Wireframe
    static func createModule() -> UIViewController
    func pushToDetailView(from view: UIViewController, movie: Results)
}


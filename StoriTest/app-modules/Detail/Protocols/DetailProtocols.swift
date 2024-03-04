//
//  DetailProtocols.swift
//  StoriTest
//
//  Created by Cristian Hernandez Garcia on 01/03/24.
//

import UIKit

protocol DetailViewProtocol: AnyObject {
    // Presenter -> View
    func showMovieData(movie: Results)
}

protocol DetailInputViewProtocol: AnyObject {
    // Presenter -> View
}

protocol DetailPresenterProtocol: AnyObject {
    // View -> Presenter
    var interactor: DetailInteractorProtocol? {get set}
    var view: DetailViewProtocol? {get set}
    var router: DetailRouterProtocol? {get set}
    
    func setMovie(movie: Results)
}

protocol DetailInteractorProtocol: AnyObject {
    var presenter: DetailOutputInteractorProtocol? {get set}
    // Presenter -> Interactor
}

protocol DetailOutputInteractorProtocol: AnyObject {
    // Interactor -> PresenterOutput
}

protocol DetailRouterProtocol: AnyObject {
    //Presenter -> Wireframe
    static func createModule() -> UIViewController
}

//
//  HomeRouter.swift
//  StoriTest
//
//  Created by Cristian Hernandez Garcia on 01/03/24.
//

import UIKit

class HomeRouter: HomeRouterProtocol {
    
    class func createModule() -> UIViewController {
        let view = HomeView()
        let router: HomeRouterProtocol = HomeRouter()
        let presenter: HomePresenterProtocol & HomeOutputInteractorProtocol = HomePresenter()
        let interactor: HomeInteractorProtocol = HomeInteractor()
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        view.presenter = presenter
        return view
    }
    
    func pushToDetailView(from view: UIViewController, movie: Results) {
        let controller = DetailRouter.createModule() as! DetailView
        controller.movie = movie
        view.pushWithCustomTransition(to: controller)
    }
}

//
//  CollectionAssembly.swift
//  Binet
//
//  Created by Al Stark on 29.04.2023.
//
import UIKit

final class CollectionAssembly {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension CollectionAssembly: Assemblying {
    func assembly(viewController: UIViewController) {
        guard let vc = viewController as? CollectionViewController else { return }
        
        let router = CollectionRouter(navigationController: navigationController)
        let interactor = CollectionInteractor()
        
        let presenter = CollectionPresenter(view: vc,
                                       router: router,
                                       interactor: interactor)
        vc.presenter = presenter
        interactor.presenter = presenter
    }
    
    
}

//
//  CollectionRouter.swift
//  Binet
//
//  Created by Al Stark on 29.04.2023.
//

import UIKit


protocol CollectionRoutable {
    func route(to: CollectionRouter.Target)
}

final class CollectionRouter {
    private var navigationController: UINavigationController?
    enum Target {
        case some
        
    }
    
    init(navigationController: UINavigationController) {
           self.navigationController = navigationController
       }
}

// MARK: CollectionRoutable
extension CollectionRouter: CollectionRoutable {
    func route(to: Target) {
        guard let navigationController = navigationController else { return }
        switch to {
        case .some:
            print("route to some")
        }
    }
    
}

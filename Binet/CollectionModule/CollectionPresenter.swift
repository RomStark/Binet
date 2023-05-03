//
//  CollectionPresenter.swift
//  Binet
//
//  Created by Al Stark on 29.04.2023.
//

import Foundation


//Протокол передачи UI эвентов слою презентации
protocol CollectionPresentation {
    func getDrugs(offset: Int, completion: @escaping (Result<Drugs, Error>) -> Void)
}

protocol CollectionPresentationMenagement: AnyObject {
    
}

// Слой presentation для модуля Collection
final class CollectionPresenter {
    
    private var router: CollectionRoutable
    private weak var view: CollectionViewable?
    private var interactor: CollectionBusinessLogic
    
    init(view: CollectionViewable, router: CollectionRoutable, interactor: CollectionBusinessLogic) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

// MARK: CollectionPresentation
extension CollectionPresenter: CollectionPresentation {
    func getDrugs(offset: Int, completion: @escaping (Result<Drugs, Error>) -> Void) {
        print("presenter enter")
        interactor.getDrugs(offset: offset) { result in
            switch result {
            case .success(let drugs):
                completion(.success(drugs))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
   
    
    
}

//  MARK: CollectionPresentationMenagement
extension CollectionPresenter: CollectionPresentationMenagement {
    
}

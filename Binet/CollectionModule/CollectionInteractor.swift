//
//  CollectionInteractor.swift
//  Binet
//
//  Created by Al Stark on 29.04.2023.
//

import Foundation

protocol CollectionBusinessLogic {
    func getDrugs(offset: Int, completion: @escaping (Result<Drugs, Error>) -> Void)
    func getDrugsBySearh(string: String, completion: @escaping (Result<Drugs, Error>) -> Void)
}

final class CollectionInteractor {
    
    weak var presenter: CollectionPresentationMenagement?
    lazy var lanWorker: CollectionLanWorkable = CollectionWorker()

}

// MARK: CollectionBusinessLogic
extension CollectionInteractor : CollectionBusinessLogic {
    func getDrugsBySearh(string: String, completion: @escaping (Result<Drugs, Error>) -> Void) {
        lanWorker.getDrugsBySearh(string: string) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func getDrugs(offset: Int, completion: @escaping (Result<Drugs, Error>) -> Void) {
        
        lanWorker.getDrugs(offset: offset) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    
    
}

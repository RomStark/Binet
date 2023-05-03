//
//  CollectionWorker.swift
//  Binet
//
//  Created by Al Stark on 02.05.2023.
//

import Foundation

protocol CollectionLanWorkable {
    func getDrugs(offset: Int, completion: @escaping (Result<Drugs, Error>) -> Void)
}

final class CollectionWorker {
    let session = URLSession.shared
}


//MARK: CollectionWorkable
extension CollectionWorker: CollectionLanWorkable {
    
    func getDrugs(offset: Int, completion: @escaping (Result<Drugs, Error>) -> Void) {
        print("worker enter")
        guard let url = URL(string: "http://shans.d2.i-partner.ru/api/ppp/index/?offset=\(offset)&limit=10") else {
            completion(.success([]))
            return
        }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = ["Authorization": "Bearer RomaBot"]
        session.dataTask(with: request) { data, response, error in
            print("session enter")
            
            if let response = response {
                print(response)
            }
            if let error = error {
                print(error.localizedDescription)
            }
            
            guard let data = data else {
                completion(.success([]))
                return
            }
            
            guard let json = try? JSONDecoder().decode(Drugs.self, from: data) else {
                completion(.success([]))
                return
            }
//            print(json)
            completion(.success(json))
        }.resume()
    }
}

//
//  CollectionWorker.swift
//  Binet
//
//  Created by Al Stark on 02.05.2023.
//

import Foundation

protocol CollectionLanWorkable {
    func getDrugs(offset: Int, completion: @escaping (Result<Drugs, Error>) -> Void)
    func getDrugsBySearh(string: String, completion: @escaping (Result<Drugs, Error>) -> Void)
}

final class CollectionWorker {
    let session = URLSession.shared
}


//MARK: CollectionWorkable
extension CollectionWorker: CollectionLanWorkable {
    func getDrugsBySearh(string: String, completion: @escaping (Result<Drugs, Error>) -> Void) {
        let urlString = "http://shans.d2.i-partner.ru/api/ppp/index/?search=\(string)"
        guard let urlString = urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed),
              let url = URL(string: urlString) else {
            completion(.success([]))
            return
        }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = ["Authorization": "Bearer RomaBot"]
        session.dataTask(with: request) { data, response, error in
           
            print("fd")
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
            print("fdf")
            print(json)
            completion(.success(json))
        }.resume()
    }
    
    func getDrugs(offset: Int, completion: @escaping (Result<Drugs, Error>) -> Void) {
        
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

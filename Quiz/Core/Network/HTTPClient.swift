//
//  HTTPClient.swift
//  QuizApp
//
//  Created by Augusto Monteiro on 24/03/22.
//

import Foundation

public protocol HTTPClient {
    typealias Result = Swift.Result<(Data,HTTPURLResponse), Error>
    func get(from url: URL, completion: @escaping (Result) -> Void)
}

final class URLSessionClient: HTTPClient {
    
    func get(from url: URL, completion: @escaping (HTTPClient.Result) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let data = data,
                   let response = response as? HTTPURLResponse {
                    completion(.success((data,response)))
                } else if let error = error {
                    completion(.failure(error))
                }
            }
        }.resume()
    }

}

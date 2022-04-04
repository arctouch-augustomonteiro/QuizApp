//
//  ImageLoader.swift
//  Thinking in SwiftUI
//
//  Created by Augusto Monteiro on 21/03/22.
//

import Foundation

protocol QuizLoader {
    typealias Result = Swift.Result<Model, Error>
    func load(completion: @escaping (Result) -> Void)
}

class RemoteQuizLoader: QuizLoader, ObservableObject {
    private let url: URL
    private let client: HTTPClient
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public init(url: URL = URL(string: "https://codechallenge.arctouch.com/quiz/1")!, client: HTTPClient = URLSessionClient()) {
        self.url = url
        self.client = client
    }
    
    public func load(completion: @escaping (QuizLoader.Result) -> Void) {
        client.get(from: url) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case let .success((data, _)):
                completion(ModelMapper.map(data))
                
            case .failure:
                completion(.failure(Error.connectivity))
            }
        }
    }
}

final class ModelMapper {
    
    static func map(_ data: Data) -> QuizLoader.Result {
        if let items = try? JSONDecoder().decode(Model.self, from: data) {
            return .success(items)
        } else {
            return .failure(RemoteQuizLoader.Error.invalidData)
        }
    }
    
}

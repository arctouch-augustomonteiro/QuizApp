//
//  MockQuizLoader.swift
//  QuizAppTests
//
//  Created by Augusto Monteiro on 30/03/22.
//

import Foundation
import XCTest

class MockQuizLoader: QuizLoader {
    
    var result: QuizLoader.Result?
    
    func load(completion: @escaping (QuizLoader.Result) -> Void) {
        guard let result = result else { return XCTFail("Expect result") }
        completion(result)
    }
    
}

//
//  QuizViewModelTests.swift
//  QuizAppTests
//
//  Created by Augusto Monteiro on 30/03/22.
//

import Foundation
import XCTest

class QuizViewModelTests: XCTestCase {
    
    func test_fetch_deliversModelWhenLoaderCompletesWithSuccess() {
        let (sut, loader) = makeSUT()
        
        XCTAssertEqual(sut.state, .loading)
        
        loader.result = .success(.mock)
        sut.fetchWordsList()
        
        XCTAssertEqual(sut.state, .loaded(.mock))
    }
    
    func test_fetch_deliversErrorWhenLoaderCompletesWithAnyFailure() {
        let (sut, loader) = makeSUT()
        
        XCTAssertEqual(sut.state, .loading)
        
        loader.result = .failure(NSError(domain: "Test", code: 0))
        sut.fetchWordsList()
        
        XCTAssertEqual(sut.state, .error)
    }
    
    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (sut: QuizViewModel, loader: MockQuizLoader) {
        let loader = MockQuizLoader()
        let sut = QuizViewModel(quizLoader: loader)
        return (sut, loader)
    }
    
}

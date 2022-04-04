//
//  QuizLoaderTests.swift
//  QuizAppTests
//
//  Created by Augusto Monteiro on 30/03/22.
//

import XCTest

class RemoteQuizLoaderTests: XCTestCase {
    
    func test_load_deliversSuccessWithModelOn200HTTPResponseWithModelJSON() {
        let (sut, client) = makeSUT()

        let item = makeItem(question: "Question", answer: ["Answer"])
        
        expect(sut, toCompleteWith: .success(item.model), when: {
            let emptyListJSON = makeItemsJSON(item.json)
            client.complete(withStatusCode: 200, data: emptyListJSON)
        })
    }
    
    func test_load_deliversSuccessWithNoAnswersOn200HTTPResponseWithModelJSON() {
        let (sut, client) = makeSUT()

        let item = makeItem(question: "Question", answer: [])
        
        expect(sut, toCompleteWith: .success(item.model), when: {
            let emptyListJSON = makeItemsJSON(item.json)
            client.complete(withStatusCode: 200, data: emptyListJSON)
        })
    }
    
    func test_load_doesNotDeliverResultAfterSUTInstanceHasBeenDeallocated() {
        let url = URL(string: "http://any-url.com")!
        let client = HTTPClientSpy()
        var sut: RemoteQuizLoader? = RemoteQuizLoader(url: url, client: client)

        var capturedResults = [RemoteQuizLoader.Result]()
        sut?.load { capturedResults.append($0) }

        sut = nil
        client.complete(withStatusCode: 200, data: makeItemsJSON([:]))

        XCTAssertTrue(capturedResults.isEmpty)
    }
    
    func test_load_deliversConnectivityErrorOnClientError() {
        let (sut, client) = makeSUT()

        expect(sut, toCompleteWith: .failure(.connectivity), when: {
            let clientError = NSError(domain: "Test", code: 0)
            client.complete(with: clientError)
        })
    }
    
    func test_load_deliversInvalidDataErrorOn200HTTPResponseWithInvalidJSON() {
        let (sut, client) = makeSUT()

        expect(sut, toCompleteWith: .failure(.invalidData), when: {
            let invalidJSON = Data("invalid json".utf8)
            client.complete(withStatusCode: 200, data: invalidJSON)
        })
    }
    
    // MARK: - Helpers
    private func makeSUT(url: URL = URL(string: "https://a-url.com")!, file: StaticString = #filePath, line: UInt = #line) -> (sut: RemoteQuizLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteQuizLoader(url: url, client: client)
        return (sut, client)
    }
    
    private func makeItem(question: String, answer: [String]) -> (model: Model, json: [String: Any]) {
        let item = Model(question: question, answer: answer)

        let json: [String: Any] = [
            "question": question,
            "answer": answer
        ]

        return (item, json)
    }
    
}

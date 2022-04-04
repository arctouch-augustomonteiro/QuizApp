//
//  JSONSerialization.swift
//  QuizAppTests
//
//  Created by Augusto Monteiro on 30/03/22.
//

import XCTest

extension XCTestCase {
    func makeItemsJSON(_ item: [String: Any]) -> Data {
        return try! JSONSerialization.data(withJSONObject: item)
    }
}

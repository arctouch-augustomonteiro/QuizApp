//
//  Array+String.swift
//  QuizApp
//
//  Created by Augusto Monteiro on 29/03/22.
//

import Foundation

extension Array where Element == String {
    func caseInsensitiveContains(_ word: String) -> Bool {
        self.contains(where: { $0.caseInsensitiveCompare(word) == .orderedSame })
    }
}

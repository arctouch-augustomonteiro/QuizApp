//
//  Int.swift
//  QuizApp
//
//  Created by Augusto Monteiro on 30/03/22.
//

import Foundation

extension Int {
    func toMinutesSeconds() -> (minutes: Int, seconds: Int) {
        (self / 60, (self % 3600) % 60)
    }
}

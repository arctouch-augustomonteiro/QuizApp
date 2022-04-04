//
//  Model.swift
//  QuizApp
//
//  Created by Augusto Monteiro on 24/03/22.
//

import Foundation

struct Model: Equatable, Decodable {
    let question: String
    let answer: [String]
}

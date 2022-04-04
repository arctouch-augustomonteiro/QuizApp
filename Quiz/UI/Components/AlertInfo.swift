//
//  AlertInfo.swift
//  QuizApp
//
//  Created by Augusto Monteiro on 25/03/22.
//

import Foundation

struct AlertInfo: Identifiable {
    enum AlertType {
        case success
        case failure
    }
    
    let id: AlertType
    let title: String
    let message: String
    let button: String
}

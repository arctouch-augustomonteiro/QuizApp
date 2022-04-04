//
//  QuizApp.swift
//  Quiz
//
//  Created by Augusto Monteiro on 04/04/22.
//

import SwiftUI

@main
struct QuizApp: App {
    var body: some Scene {
        WindowGroup {
            LoginView(viewModel: .init(loginService: FakeLoginService()))
        }
    }
}

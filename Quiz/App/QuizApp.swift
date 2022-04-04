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
            ContentView()
        }
    }
}

struct ContentView: View {
    
    @AppStorage(wrappedValue: "", AppStorageKeys.username.rawValue) var username
    
    var body: some View {
        if username.isEmpty {
            LoginView(viewModel: .init(loginService: FakeLoginService()))
        } else {
            QuizView(viewModel: .init(quizLoader: RemoteQuizLoader()))
        }
    }
    
}

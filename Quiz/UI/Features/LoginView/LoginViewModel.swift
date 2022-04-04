//
//  LoginViewModel.swift
//  QuizApp
//
//  Created by Augusto Monteiro on 31/03/22.
//

import Foundation

final class LoginViewModel: ObservableObject {
    
    @Published var username: String = ""
    @Published var password: String = ""
    
    @Published var isLoading: Bool = false
    
    @Published var authenticated: Bool?
    
    let loginService: LoginService
    
    init(loginService: LoginService) {
        self.loginService = loginService
    }
    
    var isButtonEnabled: Bool {
        !username.isEmpty && !password.isEmpty
    }
    
    func login() {
        if !isLoading {
            isLoading = true
            authenticated = nil
            loginService.login(username: username, password: password) { [weak self] auth in
                self?.authenticated = auth
                self?.isLoading = false
            }
        }
    }
    
}

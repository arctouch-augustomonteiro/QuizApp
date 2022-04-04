//
//  LoginViewModel.swift
//  QuizApp
//
//  Created by Augusto Monteiro on 31/03/22.
//

import Foundation

final class LoginViewModel: ObservableObject {
    
    @Published var viewState = ViewState()
    
    let loginService: LoginService
    
    init(loginService: LoginService) {
        self.loginService = loginService
    }
    
    var isButtonEnabled: Bool {
        !viewState.username.isEmpty && !viewState.password.isEmpty
    }
    
    func login(saveUsernameToAppStore: @escaping () -> Void) {
        if !viewState.isLoading {
            viewState.isLoading = true
            viewState.authenticated = nil
            loginService.login(username: viewState.username, password: viewState.password) { [weak self] auth in
                saveUsernameToAppStore()
                self?.viewState.authenticated = auth
                self?.viewState.isLoading = false
            }
        }
    }
    
}

extension LoginViewModel {
    struct ViewState {
        var username: String = ""
        var password: String = ""
        
        var isLoading: Bool = false
        
        var authenticated: Bool?
    }
}

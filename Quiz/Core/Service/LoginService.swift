//
//  LoginService.swift
//  QuizApp
//
//  Created by Augusto Monteiro on 31/03/22.
//

import Foundation

protocol LoginService {
    func login(username: String, password: String, completion: @escaping (Bool) -> Void)
}

class FakeLoginService: LoginService {
    
    func login(username: String, password: String, completion: @escaping (Bool) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            completion(username.count >= 3)
        }
    }
    
}

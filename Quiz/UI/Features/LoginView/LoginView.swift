//
//  LoginView.swift
//  QuizApp
//
//  Created by Augusto Monteiro on 31/03/22.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel: LoginViewModel
    
    @FocusState private var focusedField: InputField?
    
    private enum InputField {
        case username, password
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 48.0) {
                header
                
                VStack(spacing: 24.0) {
                    fields
                    loginButton
                    noLoginButton
                }
            }
            .padding()
            .navigationBarHidden(true)
            .navigationTitle("")
        }
    }
    
    var header: some View {
        HStack {
            Image(System.logoName)
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 48)
            
            Text(System.appName)
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(.orange)
        }
    }
    
    var fields: some View {
        VStack {
            
            TextField(L10n.LoginView.username, text: $viewModel.username)
                .submitLabel(.next)
                .focused($focusedField, equals: .username)
            
            SecureField(L10n.LoginView.password, text: $viewModel.password)
                .submitLabel(.done)
                .focused($focusedField, equals: .password)
            
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .disableAutocorrection(true)
        .disabled(viewModel.isLoading)
        .onSubmit {
            switch focusedField {
            case .username:
                focusedField = .password
            default:
                focusedField = nil
            }
        }
    }
    
    var loginButton: some View {
        VStack {
            loginDestination
            
            Button(action: {
                viewModel.login()
            }) {
                Group {
                    if viewModel.isLoading {
                        ProgressView()
                            .tint(.white)
                    } else {
                        Text(L10n.LoginView.login)
                            .font(.headline)
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity)
            }
            .tint(.orange)
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .disabled(!viewModel.isButtonEnabled)
            
            if viewModel.authenticated == false {
                loginFailedText
            }
        }
    }
    
    var loginDestination: some View {
        NavigationLink(destination: QuizView(viewModel: .init(quizLoader: RemoteQuizLoader())),
                       tag: true, selection: $viewModel.authenticated) { EmptyView() }
    }
    
    var loginFailedText: some View {
        Text(L10n.LoginView.loginFailed)
            .font(.subheadline)
            .foregroundColor(.red)
    }
    
    var noLoginButton: some View {
        NavigationLink(destination: QuizView(viewModel: .init(quizLoader: RemoteQuizLoader()))) {
            Text(L10n.LoginView.continueWithoutLogin)
                .font(.headline)
                .foregroundColor(.gray)
        }
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: .init(loginService: FakeLoginService()))
    }
}

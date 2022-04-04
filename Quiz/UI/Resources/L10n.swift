//
//  Localization.swift
//  QuizApp
//
//  Created by Augusto Monteiro on 30/03/22.
//

import Foundation

final class L10n {
    static private var fileName: String { "Localizable" }
    
    static private var bundle: Bundle {
        Bundle(for: L10n.self)
    }
}

extension L10n {
    enum LoginView {
        static var username: String {
            NSLocalizedString("login_view_username",
                              tableName: fileName, bundle: bundle,
                              comment: "Username textfield placeholder")
        }
        
        static var password: String {
            NSLocalizedString("login_view_password",
                              tableName: fileName, bundle: bundle,
                              comment: "Password textfield placeholder")
        }
        
        static var login: String {
            NSLocalizedString("login_view_login",
                              tableName: fileName, bundle: bundle,
                              comment: "Login button title")
        }
        
        static var continueWithoutLogin: String {
            NSLocalizedString("login_view_continue_without_login",
                              tableName: fileName, bundle: bundle,
                              comment: "Continue without login button title")
        }
        
        static var loginFailed: String {
            NSLocalizedString("login_view_login_failed",
                              tableName: fileName, bundle: bundle,
                              comment: "Text displayed when the login isn't sucessful")
        }
            
    }
}

extension L10n {
    enum QuizView {
        static var loading: String {
            NSLocalizedString("quiz_view_loading",
                              tableName: fileName, bundle: bundle,
                              comment: "Text displayed when the view is fetching the words list")
        }
        
        static var loadError: String {
            NSLocalizedString("quiz_view_try_again",
                              tableName: fileName, bundle: bundle,
                              comment: "Try again button title")
        }
    }
}

extension L10n {
    enum LoadedQuizView {
        static var textFieldPlaceholder: String {
            NSLocalizedString("loaded_quiz_view_insert_word",
                              tableName: fileName, bundle: bundle,
                              comment: "TextField used to insert the answer placeholder")
        }
    }
}

extension L10n {
    enum ResultView {
        static var reset: String {
            NSLocalizedString("result_view_reset",
                              tableName: fileName, bundle: bundle,
                              comment: "Reset button tittle")
        }
        
        static var start: String {
            NSLocalizedString("result_view_start",
                              tableName: fileName, bundle: bundle,
                              comment: "Start button tittle")
        }
    }
}

extension L10n {
    enum ResultViewSuccessAlert {
        static var title: String {
            NSLocalizedString("result_view_success_alert_title",
                              tableName: fileName, bundle: bundle,
                              comment: "Success alert tittle")
        }
        
        static var message: String {
            NSLocalizedString("result_view_success_alert_message",
                              tableName: fileName, bundle: bundle,
                              comment: "Success alert message")
        }
        
        static var button: String {
            NSLocalizedString("result_view_success_alert_button",
                              tableName: fileName, bundle: bundle,
                              comment: "Success alert button")
        }
    }
}

extension L10n {
    enum ResultViewFailureAlert {
        static var title: String {
            NSLocalizedString("result_view_failure_alert_title",
                              tableName: fileName, bundle: bundle,
                              comment: "Failure alert tittle")
        }
        
        static var message: String {
            NSLocalizedString("result_view_failure_alert_message",
                              tableName: fileName, bundle: bundle,
                              comment: "Failure alert message")
        }
        
        static var button: String {
            NSLocalizedString("result_view_failure_alert_button",
                              tableName: fileName, bundle: bundle,
                              comment: "Failure alert button")
        }
    }
}


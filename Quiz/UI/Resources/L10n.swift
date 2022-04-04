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

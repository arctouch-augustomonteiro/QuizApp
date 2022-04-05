//
//  QuizResultView.swift
//  QuizApp
//
//  Created by Augusto Monteiro on 24/03/22.
//

import SwiftUI

struct ResultView: View {
    
    @ObservedObject var viewModel: ResultViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text(viewModel.answeredCountFormatted).fontWeight(.bold)
                Spacer()
                Text(viewModel.timeRemainingFormatted).fontWeight(.bold)
            }
            .font(.largeTitle)
            
            Button(action: {
                viewModel.triggerTimer()
            }) {
                Text(viewModel.buttonTitle)
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity)
            }
            .tint(QuizColors.tint)
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        }
        .padding()
        .background(QuizColors.lightGray)
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(viewModel: .preview)
            .previewLayout(.sizeThatFits)
    }
}

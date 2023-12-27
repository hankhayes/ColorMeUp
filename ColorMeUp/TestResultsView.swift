//
//  TestResultsView.swift
//  ColorMeUp
//
//  Created by Hank Hayes on 12/24/23.
//

import SwiftUI

struct TestResultsView: View {
    
    @Binding var answers: [String]
    
    var correctAnswers: [String] = ["74", "6", "16", "2", "29", "7", "45", "5", "97", "8", "42", "3"]
    
    var amountCorrect: Int {
        var amountCorrect = 0
        for number in Range(0...11) {
            if answers[number] == correctAnswers[number] {
                amountCorrect += 1
            }
        }
        return amountCorrect
    }
    
    @State var answerText = "correct"
    
    var body: some View {
        VStack {
            Text("Ishihara Test Results")
                .font(.headline)
                .padding()
            Spacer()
            Text("\(amountCorrect)")
            Spacer()
            Text("You scored in the 95th percentile!")
                .font(.largeTitle)
                .padding()
            Spacer()
        }
    }
}

#Preview {
    TestResultsView(answers: Binding.constant(["74", "6", "16", "2", "29", "7", "45", "5", "97", "8", "42", "3"]))
}

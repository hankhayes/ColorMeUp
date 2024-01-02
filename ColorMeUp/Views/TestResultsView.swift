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
    
    var eyesightResult: String {
        if amountCorrect > 9 {
            return "normal"
        } else if amountCorrect > 6 {
            return "deficient"
        } else {
            return "severely deficient"
        }
    }
    
    var percentile: Int {
        return 95
    }
    
    @State var answerText = "correct"
    
    var body: some View {
        VStack {
            HStack {
                Text("You have completed the Ishihara test")
                    .font(.title)
                    .padding()
                Spacer()
            }
            // Spacer()
            HStack {
                VStack(alignment: .leading) {
                    Text("Questions correct: \(amountCorrect) out of 12")
                    Text("Your eyesight is \(eyesightResult)")
                }
                .padding()
                Spacer()
            }
            Button(action: {
                print("share")
            }, label: {
                Text("Share results")
            })
            .padding()
            .buttonStyle(.borderedProminent)
            Spacer()
        }
    }
}

#Preview {
    TestResultsView(answers: Binding.constant(["74", "6", "16", "2", "29", "7", "45", "5", "97", "8", "42", "3"]))
}

//
//  TestView.swift
//  ColorMeUp
//
//  Created by Hank Hayes on 12/24/23.
//

import SwiftUI

struct TestView: View {
    
    @State var testQuestion: Int = 0
    @State var guess: String = ""
    @State var next: SubmitLabel = .next
    @State var testFinished: Bool = false
    @FocusState var guessIsFocused: Bool
    
    @State var answers: [String] = ["", "", "", "", "", "", "", "", "", "", "", ""]
    
    var buttonOpacity: Double {
        if testQuestion == 0 {
            return 1.0
        } else if (testQuestion > 0) && (testQuestion < 13) {
            return 0.0
        } else {
            return 1.0
        }
    }
    
    var restartButtonOpacity: Double {
        if testQuestion < 13 {
            return 0.0
        } else {
            return 1.0
        }
    }
    
    var buttonText: String {
        if testQuestion == 0 {
            return "Begin"
        } else if (testQuestion > 0) && (testQuestion < 13) {
            return "Hide"
        } else {
            return "See results"
        }
    }
    
    var questionText: String {
        if testQuestion == 0 {
            return "Click below to begin!"
        } else if (testQuestion > 0) && (testQuestion < 13) {
            return "Question \(testQuestion) of 12"
        } else {
            return ""
        }
    }
    
    var guessFieldOpacity: Double {
        if testQuestion == 0 {
            return 0.0
        } else if (testQuestion > 0) && (testQuestion < 13) {
            return 1.0
        } else {
            return 0.0
        }
    }
    
    var submitButtonText: String {
        if testQuestion < 12 {
            return "Submit answer!"
        } else {
            return "Finish test"
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text("Ishihara Test")
                .font(.title)
                .padding()
            Text(questionText)
            
            Image("Ishihara_\(testQuestion)")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
            Spacer()
            
            TextField("guess", text: $guess)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Button(submitButtonText) {
                            if testQuestion < 12 {
                                print("submitted")
                                answers[testQuestion - 1] = guess
                                print(answers)
                                guess = ""
                                testQuestion += 1
                            } else {
                                print("submitted")
                                answers[testQuestion - 1] = guess
                                print(answers)
                                guess = ""
                                testQuestion += 1
                                guessIsFocused = false
                                testFinished = true
                            }
                        }
                    }
                }
                .focused($guessIsFocused)
                .frame(width: 100)
                .padding(5)
                .textFieldStyle(.roundedBorder)
                .opacity(guessFieldOpacity)
                .keyboardType(.numberPad)
            VStack(spacing: 20) {
                Button(action: {
                    testQuestion = 0
                    answers = ["", "", "", "", "", "", "", "", "", "", "", ""]
                }, label: {
                    Text("Restart")
                })
                .buttonStyle(.borderless)
                .opacity(restartButtonOpacity)
                Button(action: {
                    if testQuestion >= 12 {
                        testFinished = true
                    }
                    testQuestion += 1
                }, label: {
                    Text(buttonText)
                })
                .buttonStyle(.borderedProminent)
                .opacity(buttonOpacity)
            }
            .padding()
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
        .sheet(isPresented: $testFinished, onDismiss: {
            print("hi")
        }, content: {
            TestResultsView(answers: $answers)
        })
    }
}

#Preview {
    TestView()
}

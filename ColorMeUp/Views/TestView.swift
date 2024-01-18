//
//  TestView.swift
//  ColorMeUp
//
//  Created by Hank Hayes on 12/24/23.
//

import SwiftUI

struct TestView: View {
    // Variables
    @State var testQuestion: Int = 1
    @State var guess: String = ""
    @State var next: SubmitLabel = .next
    @State var testFinished: Bool = false
    @FocusState var guessIsFocused: Bool
    @State var answers: [String] = ["", "", "", "", "", "", "", "", "", "", "", ""]
    
    // Determines whether buttons are visibile or not
    var buttonOpacity: Double {
        if testQuestion < 13 {
            return 0.0
        } else {
            return 1.0
        }
    }
    
    // Determines whether buttons are visibile or not
    var restartButtonOpacity: Double {
        if testQuestion < 13 {
            return 0.0
        } else {
            return 1.0
        }
    }
    
    // Sets the question # text based on the current question
    var questionText: String {
        if testQuestion == 0 {
            return "Click below to begin!"
        } else if (testQuestion > 0) && (testQuestion < 13) {
            return "Question \(testQuestion) of 12"
        } else {
            return "You have completed the test"
        }
    }
    
    // Determines whether or not the guess field is visible
    var guessFieldOpacity: Double {
        if testQuestion == 0 {
            return 1.0
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
        NavigationStack {
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
                TextField("What number do you see?", text: $guess)
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
                            Button("Hide") {
                                guessIsFocused = false
                            }
                        }
                    }
                    .multilineTextAlignment(.center)
                    .focused($guessIsFocused)
                    .frame(width: 300)
                    .padding(5)
                    .textFieldStyle(.roundedBorder)
                    .opacity(guessFieldOpacity)
                    .keyboardType(.numberPad)
                HStack {
                    Button(action: {
                        testQuestion = 1
                        answers = ["", "", "", "", "", "", "", "", "", "", "", ""]
                    }, label: {
                        Text("Restart")
                    })
                    .buttonStyle(.borderedProminent)
                    .opacity(restartButtonOpacity)
                    Button(action: {
                        if testQuestion >= 12 {
                            testFinished = true
                        }
                        testQuestion += 1
                    }, label: {
                        Text("See results")
                    })
                    .buttonStyle(.bordered)
                    .opacity(buttonOpacity)
                }
                Spacer()
            }
            .sheet(isPresented: $testFinished, onDismiss: {
                print("hi")
            }, content: {
                TestResultsView(answers: $answers)
                    .presentationDetents([.height(300)])
            })
            .navigationBarItems(trailing:
                                    Button(action: {
                print("Button tapped!")
            }) {
                NavigationLink(destination: IshiharaInformationView()) {
                    Image(systemName: "info.circle")
                }
            }
            )
        }
    }
}

#Preview {
    TestView()
}

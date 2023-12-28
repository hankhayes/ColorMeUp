//
//  ColorCard.swift
//  ColorMeUp
//
//  Created by Hank Hayes on 12/23/23.
//

import SwiftUI
import JavaScriptCore

struct ColorCard: View {
    
    @State var jsContext: JSContext!
    @State var colorName: String
    
    var color: UserColor
    
    func initializeJS() {
        jsContext = JSContext()
        
        if let jsSourcePath = Bundle.main.path(forResource: "jssource", ofType: "js") {
            do {
                // Load its contents to a String variable.
                let jsSourceContents = try String(contentsOfFile: jsSourcePath)
                
                // Add the Javascript code that currently exists in the jsSourceContents to the Javascript Runtime through the jsContext object.
                self.jsContext.evaluateScript(jsSourceContents)
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func printJS() {
        if let variableHelloWorld = self.jsContext.objectForKeyedSubscript("text") {
            print(variableHelloWorld.toString())
        }
        
        let result = jsContext.evaluateScript("ntc.name('#007AFF')")
        print(result)
        
        if let name = result!.toArray()?[1] as? String {
            print("Color Name: \(colorName)")
            colorName = name
        }
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(color.getColor())
                .cornerRadius(15)
            VStack(alignment: .leading) {
                HStack {
                    Text("#\(color.hex)")
                        .font(.subheadline)
                    Spacer()
                    Text(color.note)
                        .font(.subheadline)
                }
                .padding()
                Spacer()
                Text(colorName)
                    .font(.title)
                    .padding()
                Spacer()
                HStack {
                    Text("September 10")
                        .font(.subheadline)
                    Spacer()
                }
                .padding()
            }
            .foregroundStyle(.white)
        }
        .onAppear {
            initializeJS()
            printJS()
            print("hi")
        }
    }
}

#Preview {
    ColorCard(colorName: "Azure Radiance", color: UserColor(hex: "007AFF", date: Date(), note: "Bedroom wall", category: "Red"))
}

//
//  ContentView.swift
//  MoneyCounter
//
//  Created by Fabio Codiglioni on 11/11/21.
//

import SwiftUI
import Combine

struct ContentView: View {
    @ObservedObject private var appState = AppState.shared
    @State private var show = true
        
    var body: some View {
        Form {
            Section {
                ForEach(AppState.doubleValues, id: \.self) { value in
                    MoneyValue(value: value)
                }
            }
            Section {
                HStack {
                    Text("Total")
                    Spacer()
                    Text(currencyFormatter.string(for: self.appState.total)!)

                }
                .font(.title2)
                .padding(.top, 20)
            }
            Section {
                HStack {
                    Spacer()
                    Button("Reset") {
                        self.reset()
                    }
                }
                .padding(.top, 20)
            }
        }
        .padding()
    }
    
    private func reset() {
        self.show = false
        self.appState.reset()
        self.show = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

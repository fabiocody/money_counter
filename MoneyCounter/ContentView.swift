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
            Text("MoneyCounter")
                .font(.title)
                .padding()
            Section {
                ForEach(AppState.doubleValues, id: \.self) { value in
                    MoneyValue(value: value)
                }
            }
            Divider()
                .padding(.vertical, 10)
            Section {
                HStack {
                    Spacer()
                    Text(currencyFormatter.string(for: self.appState.total)!)
                        .font(.title2)
                }
                .padding(.top, 0)
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
        .frame(maxWidth: 300, maxHeight: 440)
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

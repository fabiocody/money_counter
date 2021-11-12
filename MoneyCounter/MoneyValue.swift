//
//  MoneyValue.swift
//  MoneyCounter
//
//  Created by Fabio Codiglioni on 12/11/21.
//

import SwiftUI
import Combine

struct MoneyValue: View, Identifiable {
    let value: Double
    @State private var text = ""
    @ObservedObject private var appState = AppState.shared
    
    var id: String {
        "\(self.value)"
    }
    
    var label: String {
        if self.value == 1 {
            return "Coins"
        } else {
            return labelFormatter.string(for: self.value)!
        }
    }
    
    var body: some View {
        TextField(self.label, text: self.$text.onUpdate {
            let count = Double(self.text) ?? 0.0
            self.appState.computeTotal(value: self.value, count: count)
        })
        .onReceive(self.appState.$needToReset) { needToReset in
            self.text = ""
        }
    }
}

struct MoneyValue_Previews: PreviewProvider {
    static var previews: some View {
        MoneyValue(value: 42)
    }
}

//
//  Binding+onUpdate.swift
//  MoneyCounter
//
//  Created by Fabio Codiglioni on 12/11/21.
//

import SwiftUI

extension Binding {
    /// When the `Binding`'s `wrappedValue` changes, the provided handler is executed.
    /// - Parameter handler: Chunk of code to execute whenever the value changes.
    /// - Returns: New `Binding`.
    func onUpdate(_ handler: @escaping () -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler()
            }
        )
    }
}

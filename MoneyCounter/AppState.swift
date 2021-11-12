//
//  AppState.swift
//  MoneyCounter
//
//  Created by Fabio Codiglioni on 12/11/21.
//

import Foundation
import Combine


class AppState: ObservableObject {
    static let shared = AppState()
    static let doubleValues: [Double] = [500, 200, 100, 50, 20, 10, 5, 1]
    
    private init() {}
    
    @Published var total: Double = 0
    @Published var needToReset: Bool = false
    
    /// Dictionary <value: count>
    private var values = [Double: Double]()
    
    func computeTotal(value: Double, count: Double) {
        self.total += value * (count - (self.values[value] ?? 0))
        self.values[value] = count
    }
    
    func reset() {
        self.total = 0
        self.values.removeAll()
        self.needToReset.toggle()
    }
}

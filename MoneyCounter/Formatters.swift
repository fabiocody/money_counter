//
//  Formatters.swift
//  MoneyCounter
//
//  Created by Fabio Codiglioni on 12/11/21.
//

import Foundation

let labelFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.positiveFormat = "¤ #,##0"
    formatter.negativeFormat = "¤ -#,##0"
    return formatter
}()

let currencyFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.positiveFormat = "¤ #,##0.00"
    formatter.negativeFormat = "¤ -#,##0.00"
    return formatter
}()

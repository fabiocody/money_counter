//
//  MainViewController.swift
//  MoneyCounter
//
//  Created by Fabio Codiglioni on 09/12/17.
//  Copyright © 2017 Fabio Codiglioni. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {
	
	// MARK: - Outlets
	@IBOutlet weak var label500: NSTextField!
	@IBOutlet weak var label200: NSTextField!
	@IBOutlet weak var label100: NSTextField!
	@IBOutlet weak var label50: NSTextField!
	@IBOutlet weak var label20: NSTextField!
	@IBOutlet weak var label10: NSTextField!
	@IBOutlet weak var label5: NSTextField!
	@IBOutlet weak var labelCoins: NSTextField!
	@IBOutlet weak var totalLabel: NSTextField!
	@IBOutlet weak var textField500: NSTextField!
	@IBOutlet weak var textField200: NSTextField!
	@IBOutlet weak var textField100: NSTextField!
	@IBOutlet weak var textField50: NSTextField!
	@IBOutlet weak var textField20: NSTextField!
	@IBOutlet weak var textField10: NSTextField!
	@IBOutlet weak var textField5: NSTextField!
	@IBOutlet weak var textFieldCoins: NSTextField!
	
	// MARK: Constants
	fileprivate let values: [NSNumber] = [500, 200, 100, 50, 20, 10, 5, 1]
	fileprivate var labels: [NSTextField]!
	fileprivate var textFields: [NSTextField]!
	
	// MARK: Formatters
	let currencyFormatter: NumberFormatter = {
		let formatter = NumberFormatter()
		formatter.numberStyle = .currency
		formatter.positiveFormat = "¤ #,##0.00"
		formatter.negativeFormat = "¤ -#,##0.00"
		return formatter
	}()
    
	let labelFormatter: NumberFormatter = {
		let formatter = NumberFormatter()
		formatter.numberStyle = .currency
		formatter.positiveFormat = "¤ #,##0"
		formatter.negativeFormat = "¤ -#,##0"
		return formatter
	}()
    
	let textFieldFormatter: NumberFormatter = {
		let formatter = NumberFormatter()
		formatter.numberStyle = .decimal
		return formatter
	}()
	
	// MARK: - View's methods
	override func viewDidLoad() {
		super.viewDidLoad()
		labels = [label500, label200, label100, label50, label20, label10, label5, labelCoins]
		textFields = [textField500, textField200, textField100, textField50, textField20, textField10, textField5, textFieldCoins]
		for i in 0..<labels.count-1 {
			labels[i].stringValue = labelFormatter.string(from: values[i])!
		}
		for tf in textFields {
			tf.formatter = textFieldFormatter
		}
		//totalLabel.stringValue = ">>>  " + currencyFormatter.string(for: 0)!
		textField500.becomeFirstResponder()
		setTotalLabel(0)
	}
	
	// MARK: - Actions
	@IBAction func textFieldEdited(_ sender: NSTextField) {
		setTotalLabel(calculateTotal())
	}
	
	@IBAction func resetButtonPressed(_ sender: NSButton) {
		for textField in textFields {
			textField.stringValue = ""
		}
		setTotalLabel(0)
		textField500.becomeFirstResponder()
	}
	
	@IBAction func countButtonPressed(_ sender: NSButton) {
		setTotalLabel(calculateTotal())
	}
	
	// MARK: - Misc
	func calculateTotal() -> Double {
		var total = 0.0
		for i in 0..<textFields.count {
			total += textFields[i].doubleValue * values[i].doubleValue
		}
		return total
	}
	
	func setTotalLabel(_ total: Double) {
		totalLabel.stringValue = currencyFormatter.string(for: total)!
		if let windowController = view.window?.windowController as? WindowController {
			windowController.totalLabel.stringValue = currencyFormatter.string(for: total)!
		}
	}

}

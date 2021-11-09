//
//  WindowController.swift
//  MoneyCounter
//
//  Created by Fabio Codiglioni on 10/12/17.
//  Copyright © 2017 Fabio Codiglioni. All rights reserved.
//

import Cocoa


fileprivate extension NSTouchBarItem.Identifier {
	static let reset = NSTouchBarItem.Identifier("com.moneycounter.touchbar.reset")
	static let count = NSTouchBarItem.Identifier("com.moneycounter.touchbar.count")
	static let total = NSTouchBarItem.Identifier("com.moneycounter.touchbar.total")
}


class WindowController: NSWindowController, NSTouchBarDelegate {
	
	var viewController: MainViewController!
	var totalLabel: NSTextField!
	
	override func windowDidLoad() {
		super.windowDidLoad()
        viewController = (contentViewController as! MainViewController)
		totalLabel = NSTextField(labelWithString: viewController.currencyFormatter.string(for: 0)!)
	}
	
	override func makeTouchBar() -> NSTouchBar? {
		let touchBar = NSTouchBar()
		touchBar.delegate = self
		touchBar.customizationIdentifier = "com.moneycounter.touchbar"
		touchBar.defaultItemIdentifiers = [.reset, .count, .flexibleSpace, .total, .flexibleSpace, .otherItemsProxy]
		return touchBar
	}
	
	func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItem.Identifier) -> NSTouchBarItem? {
		switch identifier {
		case .reset:
			let item = NSCustomTouchBarItem(identifier: identifier)
			item.view = NSButton(title: "Reset", target: viewController, action: #selector(viewController.resetButtonPressed(_:)))
			return item
		case .count:
			let item = NSCustomTouchBarItem(identifier: identifier)
			item.view = NSButton(title: "Count", target: viewController, action: #selector(viewController.countButtonPressed(_:)))
			return item
		case .total:
			let item = NSCustomTouchBarItem(identifier: identifier)
			item.view = totalLabel
			return item
		default:
			return nil
		}
	}
	
}

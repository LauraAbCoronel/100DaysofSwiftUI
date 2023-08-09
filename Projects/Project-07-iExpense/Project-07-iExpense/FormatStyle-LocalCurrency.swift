//
//  FormatStyle-LocalCurrency.swift
//  Project-07-iExpense
//
//  Created by Laura Coronel on 8/8/23.
//

import Foundation

extension FormatStyle where Self == FloatingPointFormatStyle<Double>.Currency {
	static var localCurrency: Self {
		.currency(code: Locale.current.currency?.identifier ?? "USD")
	}
}

//
//  DoubleExtensions.swift
//  base-type-extensions
//
//  Created by Andrey Barsukov on 31.05.2025.
//

import Foundation

// MARK: - Double

extension Double {
    
    // MARK: - Number Formatting
    
    /// Formats the number with exactly one decimal place using a dot separator.
    ///
    /// - Returns: A formatted string (e.g., "1234.5" for 1234.56)
    public func formatWithDotSeparatorText() -> String {
        let number = NumberFormatter()
        number.numberStyle = .decimal
        number.minimumFractionDigits = 1
        number.maximumFractionDigits = 1
        number.decimalSeparator = "."
        return number.string(for: self) ?? "0.0"
    }
    
    /// Formats the number with specified maximum decimal places using a dot separator.
    ///
    /// - Parameter maxFractionDigits: Maximum number of decimal places (default: 2)
    /// - Returns: A formatted string (e.g., "1234.56" for 1234.567 with default parameters)
    public func formatWithDotSeparatorText(maxFractionDigits: Int = 2) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = maxFractionDigits
        formatter.decimalSeparator = "."
        return formatter.string(for: self) ?? "0.0"
    }
    
    /// Formats the number with locale-appropriate grouping and specified decimal places.
    ///
    /// - Parameter maximumFractionDigits: Maximum number of decimal places (default: 2)
    /// - Returns: A formatted string using locale settings (e.g., "1,234.56" in US locale)
    public func formatText(maximumFractionDigits: Int = 2) -> String {
        let number = NumberFormatter()
        number.numberStyle = .decimal
        number.minimumFractionDigits = 1
        number.maximumFractionDigits = maximumFractionDigits
        return number.string(for: self) ?? "0,0"
    }
    
    /// Formats the number with space grouping separator and dot decimal separator.
    ///
    /// - Parameter maxFractionDigits: Maximum number of decimal places (default: 0)
    /// - Returns: A formatted string with space separators (e.g., "1 234" for 1234.56 with default parameters)
    public func formatWithSpaceSeparatorText(maxFractionDigits: Int = 0) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = maxFractionDigits
        formatter.decimalSeparator = "."
        formatter.groupingSeparator = " "
        return formatter.string(for: self) ?? "0.0"
    }
    
    /// Rounds the price to one decimal place and returns as a simplified string.
    ///
    /// - Returns: A string without decimals when whole number (e.g., "10"),
    ///            or with comma decimal separator (e.g., "10,5")
    public func roundedPriceString() -> String {
        let roundedPrice = Double(Int(self * 10)) / 10
        if roundedPrice == Double(Int(roundedPrice)) {
            return String(Int(roundedPrice))
        }
        return String(roundedPrice).replacingOccurrences(of: ".", with: ",")
    }
}

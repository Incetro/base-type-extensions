//
//  StringExtensions.swift
//  major-extension-package
//
//  Created by Andrey Barsukov on 31.05.2025.
//

import Foundation

// MARK: - String

extension String {
    
    /// Converts the string into a valid `URL` object.
    ///
    /// This property attempts to create a `URL` instance from the
    /// string representation. It returns `nil` if the string
    /// cannot be converted into a valid `URL`.
    var asURL: URL? {
        URL(string: self)
    }
    
    /// Converts the string to a Double value.
    ///
    /// This private property attempts to convert the string to a Double.
    /// If the conversion fails, it returns 0 as a default value.
    var toDouble: Double {
        Double(self) ?? 0
    }
    
    /// Splits the string into chunks of a specified size.
    ///
    /// This method takes an integer size as a parameter and returns an
    /// array of strings, where each string is a chunk of the original
    /// string with the specified size. If the original string's length
    /// is not a multiple of the chunk size, the last chunk will contain
    /// the remaining characters.
    ///
    /// - Parameter size: The size of each chunk.
    /// - Returns: An array of strings, each containing a chunk of
    ///            the original string.
    func chunked(into size: Int) -> [String] {
        stride(from: 0, to: count, by: size).map {
            let start = index(startIndex, offsetBy: $0)
            let end = index(start, offsetBy: size, limitedBy: endIndex) ?? endIndex
            return String(self[start..<end])
        }
    }
    
    /// Returns a new string with the first letter uppercased while keeping the
    /// rest of the string unchanged.
    ///
    /// Example:
    /// ```
    /// "hello".uppercasedFirstLetter() // Returns "Hello"
    /// ```
    public func uppercasedFirstLetter() -> String {
        prefix(1).uppercased().appending(dropFirst())
    }
    
    // MARK: - Digit Validation
    
    /// Returns a string containing only the numeric digits from the original string.
    ///
    /// Example:
    /// ```
    /// "A1B2C3".digits // Returns "123"
    /// ```
    var digits: String {
        components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
    
    /// Boolean indicating whether the string contains only numeric digits.
    ///
    /// Example:
    /// ```
    /// "123".isOnlyDigits // Returns true
    /// "123a".isOnlyDigits // Returns false
    /// ```
    var isOnlyDigits: Bool {
        digits == self
    }
    
    // MARK: - URL Validation
    
    /// Boolean indicating whether the string is a valid remote URL (http/https).
    ///
    /// Example:
    /// ```
    /// "https://example.com".isRemoteURL // Returns true
    /// "example.com".isRemoteURL // Returns false
    /// ```
    var isRemoteURL: Bool {
        URL(string: self) != nil && hasPrefix("http")
    }
    
    // MARK: - String Manipulation
    
    /// Returns the specified replacement text if the string is empty, otherwise
    /// returns the original string.
    ///
    /// - Parameter text: The replacement text to use when the string is empty
    /// - Returns: Either the original string or the replacement text
    ///
    /// Example:
    /// ```
    /// "".changeEmpty(on: "default") // Returns "default"
    /// "text".changeEmpty(on: "default") // Returns "text"
    /// ```
    func changeEmpty(on text: String) -> String {
        isEmpty ? text : self
    }
    
    /// Conditionally appends another string to the current string.
    ///
    /// - Parameters:
    ///   - string: The string to append
    ///   - condition: Boolean determining whether to append
    /// - Returns: The original string or the concatenated result
    ///
    /// Example:
    /// ```
    /// "Hello".appending(" World", if: true) // Returns "Hello World"
    /// "Hello".appending(" World", if: false) // Returns "Hello"
    /// ```
    func appending(_ string: String, if condition: Bool) -> String {
        condition ? self + string : self
    }
}


// MARK: - String + Date

extension String {
    
    /// Creating the correct date type format from string type
    /// - Returns: Correct date format
    public func asDate() -> Date? {
        dateFromISO8601Format() ?? dateFromMediumFormat()
    }
    
    public func dateFromISO8601Format() -> Date? {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        let fractionDate = dateFormatter.date(from: self)
        dateFormatter.formatOptions = [.withInternetDateTime]
        let nonFractionDate = dateFormatter.date(from: self)
        return fractionDate ?? nonFractionDate
    }
    
    public func dateFromMediumFormat() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.date(from: self)
    }
}

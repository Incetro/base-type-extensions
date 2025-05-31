//
//  ErrorExtensions.swift
//  base-type-extensions
//
//  Created by Andrey Barsukov on 31.05.2025.
//

import Foundation

// MARK: - Error

extension Error {
    
    // MARK: - Error Creation
    
    /// Creates a new `NSError` with the specified parameters and debugging information.
    ///
    /// - Parameters:
    ///   - message: The localized description of the error
    ///   - domain: The error domain (typically reverse-DNS style)
    ///   - code: The error code (default: -1)
    ///   - file: The source file where the error was created (defaults to caller location)
    ///   - function: The function where the error was created (defaults to caller location)
    ///   - line: The line number where the error was created (defaults to caller location)
    /// - Returns: A new `NSError` instance with the specified parameters
    ///
    /// Example:
    /// ```
    /// throw Error.new(
    ///     message: "File not found",
    ///     domain: "com.yourapp.filesystem",
    ///     code: 404
    /// )
    /// ```
    static func new(
        message: String,
        domain: String,
        code: Int = -1,
        file: StaticString = #file,
        function: StaticString = #function,
        line: UInt = #line
    ) -> NSError {
        let error = NSError(
            domain: domain,
            code: code,
            userInfo: [
                NSLocalizedDescriptionKey: message,
                "File": "\(file)",
                "Function": "\(function)",
                "Line": line
            ]
        )
        return error
    }
}

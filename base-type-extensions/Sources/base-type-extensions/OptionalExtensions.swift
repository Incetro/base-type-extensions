//
//  OptionalExtensions.swift
//  base-type-extensions
//
//  Created by Andrey Barsukov on 31.05.2025.
//

import Foundation

// MARK: - Optional

extension Optional {
    
    // MARK: - Type-Safe Unwrapping
    
    /// Safely unwraps and converts the optional value to the specified type,
    /// or triggers a precondition failure with debugging information.
    ///
    /// - Parameters:
    ///   - type: The target type to convert to
    ///   - hint: Optional debugging hint message (autoclosure)
    ///   - file: Source file name for error reporting (defaults to caller location)
    ///   - line: Line number for error reporting (defaults to caller location)
    /// - Returns: The unwrapped and converted value of type T
    /// - Precondition: Fails if the value is nil or not convertible to type T
    ///
    /// Example:
    /// ```
    /// let optionalValue: Any? = 42
    /// let intValue = optionalValue.unwrap(as: Int.self)
    /// ```
    func unwrap<T>(
        as type: T.Type,
        _ hint: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> T {
        guard let unwrapped = self as? T else {
            var message = "Cannot convert value to type '\(T.self)'"
            if let hint = hint() {
                message.append(". Debugging hint: \(hint)")
            }
            preconditionFailure(message, file: file, line: line)
        }
        return unwrapped
    }
    
    /// Safely unwraps and converts the optional value to the specified type,
    /// or triggers a precondition failure with the provided error.
    ///
    /// - Parameters:
    ///   - type: The target type to convert to
    ///   - error: Error to use in failure message (autoclosure)
    ///   - file: Source file name for error reporting (defaults to caller location)
    ///   - line: Line number for error reporting (defaults to caller location)
    /// - Returns: The unwrapped and converted value of type T
    /// - Precondition: Fails if the value is nil or not convertible to type T
    ///
    /// Example:
    /// ```
    /// let optionalValue: Any? = "text"
    /// let intValue = optionalValue.unwrap(
    ///     as: Int.self,
    ///     MyError.invalidType
    /// )
    /// ```
    func unwrap<T>(
        as type: T.Type,
        _ error: @autoclosure () -> Error,
        file: StaticString = #file,
        line: UInt = #line
    ) -> T {
        guard let unwrapped = self as? T else {
            var message = "Cannot convert value to type '\(T.self)'"
            message.append(". Debugging hint: \(error().localizedDescription)")
            preconditionFailure(message, file: file, line: line)
        }
        return unwrapped
    }
}

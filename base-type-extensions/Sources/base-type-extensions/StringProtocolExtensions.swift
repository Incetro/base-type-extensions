//
//  StringProtocol + Extensions.swift
//  base-type-extensions
//
//  Created by Andrey Barsukov on 31.05.2025.
//

import Foundation

// MARK: - StringProtocol + Extensions

extension StringProtocol {
    
    // MARK: - Subscript Access
    
    /// Accesses the character at the specified position.
    ///
    /// - Parameter offset: The position of the character to access.
    /// - Returns: The character at the specified position.
    ///
    /// Example:
    /// ```
    /// let str = "Hello"
    /// let char = str[1] // Returns "e"
    /// ```
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
    
    /// Accesses a contiguous subrange of the collection's elements.
    ///
    /// - Parameter range: A range of integers representing the bounds of the subrange.
    /// - Returns: A subsequence containing the elements in the specified range.
    ///
    /// Example:
    /// ```
    /// let str = "Hello, World!"
    /// let substring = str[7..<12] // Returns "World"
    /// ```
    subscript(range: Range<Int>) -> SubSequence {
        let startIndex = index(self.startIndex, offsetBy: range.lowerBound)
        return self[startIndex..<index(startIndex, offsetBy: range.count)]
    }
    
    /// Accesses a contiguous subrange of the collection's elements, including the upper bound.
    ///
    /// - Parameter range: A closed range of integers representing the bounds of the subrange.
    /// - Returns: A subsequence containing the elements in the specified range.
    ///
    /// Example:
    /// ```
    /// let str = "Hello, World!"
    /// let substring = str[7...11] // Returns "World"
    /// ```
    subscript(range: ClosedRange<Int>) -> SubSequence {
        let startIndex = index(self.startIndex, offsetBy: range.lowerBound)
        return self[startIndex..<index(startIndex, offsetBy: range.count)]
    }
    
    /// Accesses a contiguous subrange from the specified lower bound to the end of the collection.
    ///
    /// - Parameter range: A partial range from the starting index.
    /// - Returns: A subsequence from the starting index to the end.
    ///
    /// Example:
    /// ```
    /// let str = "Hello, World!"
    /// let substring = str[7...] // Returns "World!"
    /// ```
    subscript(range: PartialRangeFrom<Int>) -> SubSequence {
        self[index(startIndex, offsetBy: range.lowerBound)...]
    }
    
    /// Accesses a contiguous subrange from the start of the collection through the specified position.
    ///
    /// - Parameter range: A partial range through the ending index.
    /// - Returns: A subsequence from the start through the specified position.
    ///
    /// Example:
    /// ```
    /// let str = "Hello, World!"
    /// let substring = str[...4] // Returns "Hello"
    /// ```
    subscript(range: PartialRangeThrough<Int>) -> SubSequence {
        self[...index(startIndex, offsetBy: range.upperBound)]
    }
    
    /// Accesses a contiguous subrange from the start of the collection up to, but not including, the specified position.
    ///
    /// - Parameter range: A partial range up to the ending index.
    /// - Returns: A subsequence from the start up to the specified position.
    ///
    /// Example:
    /// ```
    /// let str = "Hello, World!"
    /// let substring = str[..<5] // Returns "Hello"
    /// ```
    subscript(range: PartialRangeUpTo<Int>) -> SubSequence {
        self[..<index(startIndex, offsetBy: range.upperBound)]
    }
}

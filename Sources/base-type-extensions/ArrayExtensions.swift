//
//  Array + Extensions.swift
//  base-type-extensions
//
//  Created by Andrey Barsukov on 31.05.2025.
//

import Foundation

// MARK: - Array + Extensions

extension Array {
    
    /// Returns a new array with the first elements up to specified distance
    /// being shifted to the end of the collection.
    ///
    /// If the distance is negative, returns a new array with the last elements
    /// up to the specified absolute distance being shifted to the beginning of the collection.
    ///
    /// If the absolute distance exceeds the number of elements in the array,
    /// the elements are not shifted.
    ///
    /// - Parameter distance: shifting distance
    /// - Returns: new shifted array
    func shifted(withDistance distance: Int = 1) -> Array<Element> {
        let offsetIndex = distance >= 0
            ? self.index(startIndex, offsetBy: distance, limitedBy: endIndex)
            : self.index(endIndex, offsetBy: distance, limitedBy: startIndex)
        guard let index = offsetIndex else { return self }
        return Array(self[index ..< endIndex] + self[startIndex ..< index])
    }
    
    /// Returns a new array containing all elements where the specified key path evaluates to `false`.
    ///
    /// - Parameter not: A key path to a boolean property of the element type.
    /// - Returns: An array containing elements where the key path evaluates to `false`.
    ///
    /// Example:
    /// ```
    /// struct Person {
    ///     let isActive: Bool
    ///     let name: String
    /// }
    ///
    /// let people = [
    ///     Person(isActive: true, name: "Alice"),
    ///     Person(isActive: false, name: "Bob")
    /// ]
    ///
    /// let inactivePeople = people.filter(not: \.isActive)
    /// // Returns array containing only Bob
    /// ```
    func filter(not: KeyPath<Element, Bool>) -> Array<Element> {
        filter { !$0[keyPath: not] }
    }
}

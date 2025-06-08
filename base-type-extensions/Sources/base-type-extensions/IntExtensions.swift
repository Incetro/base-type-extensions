//
//  Int + Extensions.swift
//  base-type-extensions
//
//  Created by Andrey Barsukov on 31.05.2025.
//

import Foundation

// MARK: - Int + Extensions

extension Int {

    // MARK: - Time Formatting
    
    /// Converts the integer (representing seconds) to a time string in "mm:ss" format.
    /// Omits minutes if the duration is less than 60 seconds.
    ///
    /// - Returns: A formatted time string (e.g., "1:30" for 90 seconds)
    func timeString() -> String {
        var components: [Int] = []
        if self / 60 > 0 {
            components.append(self / 60)
        }
        if self % 60 > 0 {
            components.append(self % 60)
        }
        return components.map(String.init).joined(separator: ":")
    }
    
    /// Converts the integer (representing seconds) to hours, minutes, and seconds components.
    ///
    /// - Returns: A tuple containing (hours, minutes, seconds)
    func toHoursMinutesSeconds() -> (Int, Int, Int) {
        (self / 3_600, (self % 3_600) / 60, (self % 3_600) % 60)
    }

    // MARK: - Date Conversion
    
    /// Attempts to convert the integer (representing Unix timestamp) to a Date object.
    /// Tries ISO8601 format first, falls back to medium format.
    ///
    /// - Returns: A Date object if conversion succeeds, nil otherwise
    public func asDate() -> Date? {
        dateFromISO8601Format() ?? dateFromMediumFormat()
    }
    
    /// Converts the integer (representing Unix timestamp) to a Date object using ISO8601 format.
    ///
    /// - Returns: A Date object if conversion succeeds, nil otherwise
    public func dateFromISO8601Format() -> Date? {
        let timeInterval = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        let fractionDate = dateFormatter.date(from: timeInterval.description)
        dateFormatter.formatOptions = [.withInternetDateTime]
        let nonFractionDate = dateFormatter.date(from: timeInterval.description)
        return fractionDate ?? nonFractionDate
    }
    
    /// Converts the integer (representing Unix timestamp) to a Date object using medium format ("MMM d, yyyy").
    ///
    /// - Returns: A Date object if conversion succeeds, nil otherwise
    public func dateFromMediumFormat() -> Date? {
        let timeInterval = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.date(from: timeInterval.description)
    }

    // MARK: - Distance Formatting
    
    /// Converts the integer (representing meters) to a localized distance string.
    ///
    /// - Returns: A formatted distance string (e.g., "500 m", "1.5 km", "2 km")
    public var distanceTextKey: String {
        let distance = self
        if distance < 1_000 {
            return "\(distance) m"
        } else if distance < 1_000_000 {
            let double = Double(round(Double(distance) / 1_000 * 10) / 10)
            return "\(Int(double)) km"
        } else {
            return "\(distance / 1000) km"
        }
    }
}

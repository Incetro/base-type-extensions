//
//  TimeInterval + Extensions.swift
//  base-type-extensions
//
//  Created by Andrey Barsukov on 31.05.2025.
//

import Foundation

// MARK: - TimeInterval + Extensions

extension TimeInterval {

    /// Converts seconds into correct time format
    /// - Returns: time format
    func convertToTimeFormat() -> String {
        let hours = Int(self / 3600)
        let minutes = (Int(self) - hours * 3600) / 60
        let hoursString = "\(hours)"
        let minutesString = minutes < 10 ? "0\(minutes)" : "\(minutes)"
        return hoursString + ":" + minutesString
    }
}

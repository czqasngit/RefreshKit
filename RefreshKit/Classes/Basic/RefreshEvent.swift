//
//  RefreshEvent.swift
//  Pods-RefreshKit_Example
//
//  Created by legendry on 2018/10/24.
//

import Foundation

public enum DraggingEvent {
    case none
    case perpare
    case pulling(percent: Float)
    case complete
}
extension DraggingEvent: Equatable {
    public static func == (lhs: DraggingEvent, rhs: DraggingEvent) -> Bool {
        switch (lhs, rhs) {
        case (.none, .none):
            return true
        case (.perpare, .perpare):
            return true
        case (.complete, .complete):
            return true
        case (.pulling(_), .pulling(_)):
            return true
        default:
            return false
        }
    }
}

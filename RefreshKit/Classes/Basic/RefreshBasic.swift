//
//  RefreshBasic.swift
//  Pods-RefreshKit_Example
//
//  Created by legendry on 2018/10/24.
//

import Foundation

open class RefreshBasic: RefreshComponent {
    
    override var event: DraggingEvent {
        willSet {
            print("新状态: \(newValue)")
        }
    }
}

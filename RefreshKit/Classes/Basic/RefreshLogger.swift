//
//  RefreshLogger.swift
//  BerryPlant
//
//  Created by legendry on 2019/1/31.
//

import Foundation

#if DEBUG
public func _log(_ message: String) {
    print("😱RefreshKit: \(message)")
}
#else
public func _log(_ message: String){}
#endif

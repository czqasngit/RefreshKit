//
//  RefreshNormalHeader.swift
//  Pods-RefreshKit_Example
//
//  Created by legendry on 2018/10/25.
//

import UIKit

public class RefreshNormalHeader: RefreshBasic {

    override public func eventChanged(_ newEvent: DraggingEvent) {
        switch newEvent {
        case .complete:
            print("松开就刷新...")
        case .perpare:
            print("松开就反弹...")
        case .pulling(_):
            print("即将刷新...")
        default:
            break
        }
    }
    

}

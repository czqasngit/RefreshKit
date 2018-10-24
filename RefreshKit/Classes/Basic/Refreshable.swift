//
//  Refreshable.swift
//  RefreshKit
//
//  Created by legendry on 2018/10/24.
//

import Foundation

public protocol Refreshable {}
public class Refresh<Base> {
    var base: Base
    init(_ base: Base) {
        self.base = base
    }
}
extension Refreshable {
    public var refresh: Refresh<Self> {
        return Refresh(self)
    }
}
extension Refresh where Base: UIScrollView {
    public var header: RefreshBasic? {
        set {
            if let _header = newValue {
                self.base.addHeader(_header)
            }
        }
        get {
            return self.base.subviews.first as? RefreshBasic
        }
    }
}
extension UIScrollView: Refreshable {
    public func addHeader(_ header: RefreshBasic) {
        self.insertSubview(header, at: 0)
        self.clipsToBounds = true
        header.addObserve()
    }
}

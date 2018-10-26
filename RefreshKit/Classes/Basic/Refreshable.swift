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
    public var header: RefreshView? {
        set {
            if let _header = newValue {
                self.base.addHeader(_header)
            }
        }
        get {
            return self.base.subviews.first as? RefreshView
        }
    }
    public func stopRefresh() {
        self.header?.stopRefresh()
    }
}
extension UIScrollView: Refreshable {
    public func addHeader(_ header: RefreshView) {
        self.insertSubview(header, at: 0)
        header.translatesAutoresizingMaskIntoConstraints = false
        header.addConstraint(.init(item: header, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: header.refreshHeight))
        self.addConstraint(.init(item: header, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0))
        self.addConstraint(.init(item: header, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1.0, constant: 0))
        self.addConstraint(.init(item: header, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: -header.refreshHeight))
        self.clipsToBounds = true
        header.addObserve()
    }
    
}

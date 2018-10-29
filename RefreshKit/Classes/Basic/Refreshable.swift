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
let kHeader = UnsafeMutablePointer<UInt8>.allocate(capacity: 0)
let kFooter = UnsafeMutablePointer<UInt8>.allocate(capacity: 1)
extension Refresh where Base: UIScrollView {
    public var header: RefreshHeaderControl? {
        set {
            if let _header = newValue {
                self.base.addHeader(_header)
            }
            objc_setAssociatedObject(self.base, kHeader, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self.base, kHeader) as? RefreshHeaderControl
        }
    }
    public var footer: RefreshFooterControl? {
        set {
            if let _footer = newValue {
                self.base.addFooter(_footer)
            }
            objc_setAssociatedObject(self.base, kFooter, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self.base, kFooter) as? RefreshFooterControl
        }
    }
    public func stopRefresh() {
        self.header?.stopRefresh()
    }
}
extension UIScrollView: Refreshable {
    public func addHeader(_ header: RefreshHeaderControl) {
        self.insertSubview(header, at: 0)
        header.translatesAutoresizingMaskIntoConstraints = false
        header.addConstraint(.init(item: header, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: header.refreshHeight))
        self.addConstraint(.init(item: header, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0))
        self.addConstraint(.init(item: header, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1.0, constant: 0))
        self.addConstraint(.init(item: header, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: -header.refreshHeight))
        self.clipsToBounds = true
        header.addObserve()
    }
    
    public func addFooter(_ footer: RefreshFooterControl) {
        self.addSubview(footer)
        footer.translatesAutoresizingMaskIntoConstraints = false
        footer.addConstraint(.init(item: footer, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: footer.refreshHeight))
        self.addConstraint(.init(item: footer, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0))
        self.addConstraint(.init(item: footer, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1.0, constant: 0))
        self.addConstraint(.init(item: footer, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0))
        self.clipsToBounds = true
        footer.addObserve()
    }
    
}

//
//  RefreshControl.swift
//  Pods-RefreshKit_Example
//
//  Created by legendry on 2018/10/24.
//

import Foundation


public class RefreshControl: UIView {
    
    deinit {
        print("RefreshControl deinit")
    }
    public func addObserve() {
        
        self.parent.observe(forKeyPath: "contentOffset") { (object, keyPath, change, context) in
            guard let value = change?[NSKeyValueChangeKey.newKey],
                  let point = value as? CGPoint else { return }
            self.dragging(point)
        }
    }
    internal var parent: UIScrollView {
        guard let scrollView = self.superview as? UIScrollView else {
            fatalError("Superview is not UIScrollView")
        }
        return scrollView
    }
    internal func dragging(_ point: CGPoint) {
        fatalError("Implement in subclass.")
    }
    
}

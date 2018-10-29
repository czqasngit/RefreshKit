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
        self.parent.observe(forKeyPath: ["contentOffset", "contentSize"]) {[weak self] (keyPath, object, change, context) in
            guard let self = self,
                  let value = change?[NSKeyValueChangeKey.newKey] else { return }
            if keyPath == "contentOffset" {
                guard let point = value as? CGPoint else { return }
                self.dragging(point)
            } else if keyPath == "contentSize" {
                guard let size = value as? CGSize else { return }
                self.contentSizeChanged(size)
            }
        }
    }
    internal var parent: UIScrollView {
        guard let scrollView = self.superview as? UIScrollView else {
            fatalError("Superview is not UIScrollView")
        }
        return scrollView
    }
    internal func contentSizeChanged(_ contentSize: CGSize) {
        
    }
    internal func dragging(_ point: CGPoint) {
        fatalError("Implement in subclass.")
    }
    
}

//
//  RefreshComponent.swift
//  Pods-RefreshKit_Example
//
//  Created by legendry on 2018/10/24.
//

import Foundation


public class RefreshComponent: UIView {
    
    
    
    
    deinit {
        print("RefreshComponent deinit")
    }
    public func addObserve() {
        guard let scrollView = self.superview as? UIScrollView else {
            fatalError("Superview is not UIScrollView")
        }
        scrollView.observe(forKeyPath: "contentOffset") { (object, keyPath, change, context) in
            guard let value = change?[NSKeyValueChangeKey.newKey],
                  let point = value as? CGPoint else { return }
            self.dragging(point)
            print("\(point)")
        }
    }
    
    public func dragging(_ point: CGPoint) {
        fatalError("Implement in subclass.")
    }
    
    
    
}

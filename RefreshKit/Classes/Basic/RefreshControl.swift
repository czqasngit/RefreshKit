//
//  RefreshControl.swift
//  Pods-RefreshKit_Example
//
//  Created by legendry on 2018/10/24.
//

import Foundation


public class RefreshControl: UIView {
    
    ///防止内容不多时,上拉下拉同时触发
    var isResponse = false
    ///UIScrollView初始Offset.y
    var basicOffsetY: CGFloat = 0
//    var isDragged = false
    var _contentInset = UIEdgeInsets.zero
    deinit {
        print("RefreshControl deinit")
    }
    public func addObserve() {
        print(self.parent.bounds)
        self.parent.observe(forKeyPath: ["contentOffset", "contentSize"]) {[weak self] (keyPath, object, change, context) in
            guard let self = self, let value = change?[NSKeyValueChangeKey.newKey] else { return }
            if keyPath == "contentOffset" {
                guard let point = value as? CGPoint else { return }
                self.basicOffsetY = -self.parent.contentInset.top
                self.dragging(point)
            } else if keyPath == "contentSize" {
                guard let size = value as? CGSize else { return }
                self.contentSizeUpdated(size)
            }
        }
    }

    internal var parent: UIScrollView {
        guard let scrollView = self.superview as? UIScrollView else {
            fatalError("Superview is not UIScrollView")
        }
        return scrollView
    }
    internal func contentSizeUpdated(_ contentSize: CGSize) {
        
    }
    internal func dragging(_ point: CGPoint) {
        fatalError("Implement in subclass.")
    }
    
}

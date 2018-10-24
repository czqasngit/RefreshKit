//
//  RefreshComponent.swift
//  Pods-RefreshKit_Example
//
//  Created by legendry on 2018/10/24.
//

import Foundation

/*!
 
 */
open class RefreshComponent: UIView {
    deinit {
        print("RefreshComponent deinit")
    }
    public func addObserve() {
        guard let scrollView = self.superview as? UIScrollView else {
            fatalError("Superview is not UIScrollView")
        }
        scrollView.observe(forKeyPath: "contentOffset") {[weak scrollView] (object, keyPath, change, content) in
            let h = self.frame.size.height
            guard let scrollView = scrollView else { return }
            guard let value = change?[NSKeyValueChangeKey.newKey],
                  let point = value as? CGPoint else { return }
            let offsetY = point.y
            var event: DraggingEvent = .none
            if scrollView.isDragging {
                if offsetY < h / 2 {
                    event = .perpare
                } else if (h / 2)..<(h) ~= offsetY {
                    event = .move(percent: Float((offsetY - h / 2) / (h / 2)))
                } else {
                    event = .complete
                }
            }
            print("状态: \(event)")
            
        }
    }
    open override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}

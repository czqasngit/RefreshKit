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
    
    
    var event: DraggingEvent = .none
    var basicOffsetY: CGFloat = 0
    
    deinit {
        print("RefreshComponent deinit")
    }
    public func addObserve() {
        guard let scrollView = self.superview as? UIScrollView else {
            fatalError("Superview is not UIScrollView")
        }
        print("\(scrollView.contentOffset)-\(scrollView.contentSize)-\(scrollView.bounds)")
        scrollView.observe(forKeyPath: "contentOffset") {[weak scrollView] (object, keyPath, change, context) in
            
            let h = self.frame.size.height
            guard let scrollView = scrollView else { return }
            guard let value = change?[NSKeyValueChangeKey.newKey],
                  let point = value as? CGPoint else { return }
            self.initializeBasicOffsetYIfNeed(point, scrollView)
            if scrollView.isDragging {
                let offsetY = abs(point.y) - self.basicOffsetY
                if offsetY < h / 2 {
                    self.event = .perpare
                } else if (h / 2)..<(h) ~= offsetY {
                    self.event = .move(percent: Float((offsetY - h / 2) / (h / 2)))
                } else {
                    self.event = .complete
                }
            } else {
                switch self.event {
                case .complete:
                    print("执行刷新...")
                    self.event = .none
                default:
                    break
                }
            }
            print("\(self.event)")
        }
    }
    
    private func initializeBasicOffsetYIfNeed(_ point: CGPoint, _ scrollView: UIScrollView) {
        if self.basicOffsetY == 0 && !scrollView.isDragging {
            self.basicOffsetY = abs(point.y)
        }
    }
    
}

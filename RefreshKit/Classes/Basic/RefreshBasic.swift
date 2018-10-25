//
//  RefreshBasic.swift
//  Pods-RefreshKit_Example
//
//  Created by legendry on 2018/10/24.
//

import Foundation

public class RefreshBasic: RefreshComponent {
    
    fileprivate var event: DraggingEvent = .none
    var basicOffsetY: CGFloat = 0
    
    private func initializeBasicOffsetYIfNeed(_ point: CGPoint, _ scrollView: UIScrollView) {
        if self.basicOffsetY == 0 && !scrollView.isDragging {
            self.basicOffsetY = abs(point.y)
        }
    }
    private func handleDragging(_ point: CGPoint, _ scrollView: UIScrollView) {
        if scrollView.isDragging {
            let h = self.frame.size.height
            let offsetY = abs(point.y) - self.basicOffsetY
            if offsetY < h / 2 {
                self.updateEvent(.perpare)
            } else if (h / 2)..<(h) ~= offsetY {
                self.updateEvent(.pulling(percent: Float((offsetY - h / 2) / (h / 2))))
            } else {
                self.updateEvent(.complete)
            }
        } else {
            switch self.event {
            case .complete:
                print("执行刷新...")
                self.updateEvent(.none)
            default:
                break
            }
        }
    }
    public func eventChanged(_ newEvent: DraggingEvent) {
        
    }
    private func updateEvent(_ newEvent: DraggingEvent) {
        guard self.event != newEvent else { return }
        self.event = newEvent
        self.eventChanged(newEvent)
    }
    
    public override func dragging(_ point: CGPoint) {
        guard let scrollView = self.superview as? UIScrollView else {
            fatalError("Superview is not UIScrollView")
        }
        self.initializeBasicOffsetYIfNeed(point, scrollView)
        self.handleDragging(point, scrollView)
    }

}

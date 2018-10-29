//
//  RefreshEventControl.swift
//  Pods-RefreshKit_Example
//
//  Created by legendry on 2018/10/24.
//

import Foundation


public enum DraggingEvent {
    case none
    case perpare
    case pulling(percent: Float)
    case complete
}
extension DraggingEvent: Equatable {
    public static func == (lhs: DraggingEvent, rhs: DraggingEvent) -> Bool {
        switch (lhs, rhs) {
        case (.none, .none):
            return true
        case (.perpare, .perpare):
            return true
        case (.complete, .complete):
            return true
        case (.pulling(_), .pulling(_)):
            return true
        default:
            return false
        }
    }
}

public typealias RefreshingBlock = () -> ()
public class RefreshEventControl: RefreshControl {
    
    public var event: DraggingEvent = .none
    var basicOffsetY: CGFloat = 0
    var refreshingBlock: RefreshingBlock
    var isRefreshing: Bool = false
    
    
    public init(with refreshingBlock: @escaping RefreshingBlock) {
        self.refreshingBlock = refreshingBlock
        super.init(frame: .zero)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initializeBasicOffsetYIfNeed(_ point: CGPoint, _ scrollView: UIScrollView) {
        if self.basicOffsetY == 0 && !scrollView.isDragging {
            self.basicOffsetY = point.y
        }
    }
    public func handleDragging(_ point: CGPoint, _ scrollView: UIScrollView) {
        fatalError("Implement in subclass, don't call super.handleDragging")
    }
    public func startRefresh() {
        self.isRefreshing = true
        self.parent.isScrollEnabled = false
    }
    public func stopRefresh() {
        self.isRefreshing = false
        self.parent.isScrollEnabled = true
    }
    public func refreshing() {
        self.refreshingBlock()
    }
    public func refreshCompleted() {
        
    }
    public func eventChanged(_ newEvent: DraggingEvent) {
        
    }
    internal func updateEvent(_ newEvent: DraggingEvent) {
        guard self.event != newEvent else { return }
        self.event = newEvent
        print("更新: \(self.event)")
        self.eventChanged(newEvent)
    }
    internal override func dragging(_ point: CGPoint) {
        let scrollView = self.parent
        self.initializeBasicOffsetYIfNeed(point, scrollView)
        self.handleDragging(point, scrollView)
    }

}

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
extension DraggingEvent {
    static var refreshingText: String {
        return "正在刷新..."
    }
}

public typealias RefreshingBlock = () -> ()
public class RefreshEventControl: RefreshControl {
    
    ///拖动状态
    public var event: DraggingEvent = .none
    
    ///刷新回调
    var refreshingBlock: RefreshingBlock
    ///是否正在刷新
    var isRefreshing: Bool = false
    
    public init(with refreshingBlock: @escaping RefreshingBlock) {
        self.refreshingBlock = refreshingBlock
        super.init(frame: .zero)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    ///处理正在拖动
    public func handleDragging(_ point: CGPoint, _ scrollView: UIScrollView) {
        if point.y == self.basicOffsetY {
            //回到初始位置
            self.scrollViewDidRestorePosotion()
        }
    }
    ///恢复到初始位置
    public func scrollViewDidRestorePosotion() {
        self.isResponse = false
    }
   
    
     ///开始刷新
    public func startRefresh() {
        self.isRefreshing = true
        self.parent.isUserInteractionEnabled = false
    }
    ///停止刷新
    public func stopRefresh() {
        guard self.isRefreshing else { return }
        self.isRefreshing = false
        
    }
    ///正在刷新
    public func refreshing() {
        self.refreshingBlock()
    }
    ///刷新完成
    public func refreshCompleted() {
        self.parent.isUserInteractionEnabled = true
    }
    ///状态发生改变
    public func eventChanged(_ newEvent: DraggingEvent) {
        
    }
    ///更新状态
    final internal func updateEvent(_ newEvent: DraggingEvent) {
        guard self.event != newEvent else { return }
        self.isResponse = newEvent != .none
        self.event = newEvent
//        print("更新: \(self.event) -- \(self.isResponse)")
        self.eventChanged(newEvent)
    }
    ///正在拖动
     final internal override func dragging(_ point: CGPoint) {
        let scrollView = self.parent
        self.handleDragging(point, scrollView)
    }

}

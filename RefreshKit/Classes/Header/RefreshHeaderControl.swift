//
//  RefreshHeaderControl.swift
//  Pods-RefreshKit_Example
//
//  Created by legendry on 2018/10/26.
//

import UIKit

public class RefreshHeaderControl: RefreshEventControl {
    var refreshHeight: CGFloat = 60
    /// top inset fix value
    public override init(with refreshingBlock: @escaping RefreshingBlock) {
        super.init(with: refreshingBlock)
    }
    override public func handleDragging(_ point: CGPoint, _ scrollView: UIScrollView) {
        super.handleDragging(point, scrollView)
        guard self.isRefreshing == false else { return }
        if let footer = scrollView.refresh.footer, footer.isResponse == true  { return }
        if scrollView.isDragging {
            let h = self.frame.size.height
            let offsetY = point.y - self.basicOffsetY //- self.topInsetFix
            if (-h / 2)..<0 ~= offsetY {
                self.updateEvent(.perpare)
            } else if (-h)..<(-h / 2) ~= offsetY {
                let percent = Float((abs(offsetY) - abs(h / 2)) / abs(h / 2))
                self.updateEvent(.pulling(percent: percent))
                self.pulling(percent: percent)
                
            } else if -h >= offsetY {
                self.pulling(percent: 1.0)
                self.updateEvent(.complete)
            }
        } else {
            switch self.event {
            case .complete:
                if !self.isRefreshing {
                    self.updateEvent(.none)
                    self.startRefresh()
                    self.refreshing()
                }
            default:
                break
            }
        }
    }
    public func pulling(percent: Float) {
        
    }
    public func toggle() {
        guard !self.isRefreshing else { return }
        self.startRefresh()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            self.refreshing()
        }
    }
    public override func startRefresh() {
        super.startRefresh()
        self.parent.refresh.footer?.isHidden = true
        self.parent.setContentOffset(.init(x: 0, y: self.basicOffsetY - self.frame.size.height), animated: true)
    }
    public override func refreshing() {
        super.refreshing()
    }
    public override func stopRefresh() {
        guard self.isRefreshing else { return }
        super.stopRefresh()
        self.stopRefresh(true)
    }
    ///restorePosition 为true,刷新完恢复到刷新前的位置,false刷新完位置不变
    public func stopRefresh( _ restorePosition: Bool = true) {
        if restorePosition {
            //防止调用reloadData后,contentOffset自动恢复到初始状态
            self.parent.setContentOffset(.init(x: 0, y: self.basicOffsetY - self.frame.size.height), animated: false)
            UIView.animate(withDuration: 0.25) {
                self.parent.setContentOffset(.init(x: 0, y: self.basicOffsetY), animated: false)
                self.refreshCompleted()
            }
        } else {
            self.refreshCompleted()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}

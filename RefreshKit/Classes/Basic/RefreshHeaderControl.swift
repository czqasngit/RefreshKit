//
//  RefreshHeaderControl.swift
//  Pods-RefreshKit_Example
//
//  Created by legendry on 2018/10/26.
//

import UIKit

public class RefreshHeaderControl: RefreshEventControl {
    var refreshHeight: CGFloat = 60
    public override init(with refreshingBlock: @escaping RefreshingBlock) {
        super.init(with: refreshingBlock)
    }
    override public func handleDragging(_ point: CGPoint, _ scrollView: UIScrollView) {
        if scrollView.isDragging {
            let h = self.frame.size.height
            let offsetY = point.y - self.basicOffsetY
            if (-h / 2)..<0 ~= offsetY {
                self.updateEvent(.perpare)
            } else if (-h)..<(-h / 2) ~= offsetY {
                self.updateEvent(.pulling(percent: Float((offsetY - h / 2) / (h / 2))))
            } else if -h >= offsetY {
                self.updateEvent(.complete)
            }
        } else {
            switch self.event {
            case .complete:
                self.startRefresh()
                self.refreshing()
                self.updateEvent(.none)
            default:
                break
            }
        }
    }
    public func toggle() {
        guard !self.isRefreshing else { return }
        self.startRefresh()
        self.refreshing()
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
        super.stopRefresh()
        //防止调用reloadData后,contentOffset自动恢复到初始状态
        self.parent.setContentOffset(.init(x: 0, y: self.basicOffsetY - self.frame.size.height), animated: false)
        UIView.animate(withDuration: 0.25) {
            self.parent.setContentOffset(.init(x: 0, y: self.basicOffsetY), animated: false)
            self.refreshCompleted()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

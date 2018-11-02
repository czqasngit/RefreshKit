//
//  RefreshHeaderControl.swift
//  Pods-RefreshKit_Example
//
//  Created by legendry on 2018/10/26.
//

import UIKit

public class RefreshFooterControl: RefreshEventControl {
    var refreshHeight: CGFloat = 60
    var hasMore: Bool = true
    var contentInset: UIEdgeInsets!
   
    public override init(with refreshingBlock: @escaping RefreshingBlock) {
        super.init(with: refreshingBlock)
        self.isHidden = true
    }
    public override func layoutSubviews() {
        super.layoutSubviews()
        if self.contentInset == nil {
            self.contentInset = self.parent.contentInset
        }
    }
    override public func handleDragging(_ point: CGPoint, _ scrollView: UIScrollView) {
        super.handleDragging(point, scrollView)
        guard self.hasMore else { return }
        guard let header = scrollView.refresh.header, header.isResponse == false else { return }
        if scrollView.isDragging {
            let h = self.frame.size.height
            let offsetY = point.y - self.basicOffsetY
            var maxOffsetHeight = (scrollView.contentSize.height - scrollView.frame.size.height) - self.basicOffsetY
            if maxOffsetHeight < 0 {
                maxOffsetHeight = 0
            }
            if maxOffsetHeight..<(maxOffsetHeight + h / 2) ~= offsetY {
                self.updateEvent(.perpare)
            } else if (maxOffsetHeight + h / 2)..<(maxOffsetHeight + h) ~= offsetY {
                self.updateEvent(.pulling(percent: Float((offsetY - h / 2) / (h / 2))))
            } else if offsetY >= maxOffsetHeight + h + 15 {
                self.updateEvent(.complete)
            }
        } else {
            switch self.event {
            case .complete:
                self.startRefresh()
                self.refreshing()
                self.updateEvent(.none)
            case .perpare:
                if self.parent.contentSize.height + self.frame.size.height < self.parent.frame.size.height {
                    self.isHidden = true
                }
            case .pulling(_):
                if self.parent.contentSize.height + self.frame.size.height < self.parent.frame.size.height {
                    self.isHidden = true
                }
            default:
                break
            }
        }
    }

    override public func eventChanged(_ newEvent: DraggingEvent) {
        switch newEvent {
        case .complete:
            self.isHidden = false
        case .perpare:
            self.isHidden = false
        case .pulling(_):
            self.isHidden = false
        default:
            break
        }
    }
    override func contentSizeUpdated(_ contentSize: CGSize) {
        if let const = (self.parent.constraints.filter { $0.firstAttribute == .top && $0.secondAttribute == .top && $0.constant >= 0 }.first) {
            const.constant = contentSize.height
        }
    }
    public override func startRefresh() {
        let footerRefreshingOffsetY = (self.parent.contentSize.height - self.parent.frame.size.height) + self.frame.size.height
        guard footerRefreshingOffsetY > 0 else { return }
        self.parent.setContentOffset(.init(x: 0, y: footerRefreshingOffsetY ), animated: true)
    }
    public override func refreshing() {
        self.parent.contentInset = self.contentInset
        super.refreshing()
    }
    public override func stopRefresh() {
        self.refreshCompleted()
    }
    public func resetNoMoreData() {
        self.hasMore = true
    }
    public func noMoreData() {
        self.hasMore = false
        var inset = self.contentInset!
        inset.bottom += self.frame.size.height
        self.parent.contentInset = inset
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//
//  RefreshHeaderControl.swift
//  Pods-RefreshKit_Example
//
//  Created by legendry on 2018/10/26.
//

import UIKit

extension UIEdgeInsets {
    static func + (lhs: UIEdgeInsets, rhs: UIEdgeInsets) -> UIEdgeInsets {
        var newInsets = UIEdgeInsets.zero
        newInsets.top = lhs.top + rhs.top
        newInsets.bottom = lhs.bottom + rhs.bottom
        newInsets.right = lhs.right + rhs.right
        newInsets.left = lhs.left + rhs.left
        return newInsets
    }
}
public class RefreshFooterControl: RefreshEventControl {
    var refreshHeight: CGFloat = 60
    var hasMore: Bool = true
    var contentInset: UIEdgeInsets = .zero
   
    public override init(with refreshingBlock: @escaping RefreshingBlock) {
        super.init(with: refreshingBlock)
        self.isHidden = true
    }
    public override func layoutSubviews() {
        super.layoutSubviews()
        if self.contentInset == .zero {
            self.parent.contentInset = self.parent.contentInset + self.contentInsetOffset()
            self.contentInset = self.parent.contentInset
        }
    }
    func contentInsetOffset() -> UIEdgeInsets {
        return .zero
    }
    override public func handleDragging(_ point: CGPoint, _ scrollView: UIScrollView) {
        super.handleDragging(point, scrollView)
        guard self.isRefreshing == false else { return }
        guard self.hasMore else { return }
        guard scrollView.contentSize.height >= 1 else { return }
        if let header = scrollView.refresh.header, header.isResponse == true { return }
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
                self.updateEvent(.pulling(percent: 1.0))
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
    var reqiureFixOffsetOnLoading: Bool {
        return true
    }
  
    public override func startRefresh() {
        super.startRefresh()
        if reqiureFixOffsetOnLoading {
            let footerRefreshingOffsetY = (self.parent.contentSize.height - self.parent.frame.size.height) + self.frame.size.height
            guard footerRefreshingOffsetY > 0 else { return }
            self.parent.setContentOffset(.init(x: 0, y: footerRefreshingOffsetY ), animated: true)
        }
    }
    public override func refreshing() {
        self.parent.contentInset = self.contentInset
        super.refreshing()
    }
    public override func stopRefresh() {
        guard self.isRefreshing else { return }
        super.stopRefresh()
        self.refreshCompleted()
    }
    public func resetNoMoreData() {
        self.hasMore = true
    }
    public func noMoreData() {
        super.stopRefresh()
        self.hasMore = false
        var inset = self.contentInset
        inset.bottom += self.frame.size.height
        self.parent.contentInset = inset
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

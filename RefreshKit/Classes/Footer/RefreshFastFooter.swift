//
//  RefreshFastFooter.swift
//  BerryPlant
//
//  Created by legendry on 2018/11/2.
//

import UIKit


public class RefreshFastFooter: RefreshDefaultFooter {
    
    override init(with refreshingBlock: @escaping RefreshingBlock) {
        super.init(with: refreshingBlock)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func contentInsetOffset() -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: self.refreshHeight, right: 0)
    }
    override public func handleDragging(_ point: CGPoint, _ scrollView: UIScrollView) {
        guard self.hasMore else { return }
        guard let header = scrollView.refresh.header, header.isResponse == false else { return }
        if scrollView.isDragging {
            let h = self.frame.size.height
            let offsetY = point.y - self.basicOffsetY
            var maxOffsetHeight = (scrollView.contentSize.height - scrollView.frame.size.height) - self.basicOffsetY
            if maxOffsetHeight < 0 {
                maxOffsetHeight = 0
            }
            let offsetHeightToLoading: CGFloat = 30
            if (maxOffsetHeight - offsetHeightToLoading)..<maxOffsetHeight ~= offsetY {
                self.updateEvent(.perpare)
                print("Fast footer  perpare")
            } else if maxOffsetHeight..<(maxOffsetHeight + 10) ~= offsetY {
                self.updateEvent(.pulling(percent: Float((offsetY - h / 2) / (h / 2))))
            } else if offsetY >= maxOffsetHeight + 10 {
                if !self.isRefreshing {
                    self.updateEvent(.complete)
                    self.startRefresh()
                    self.refreshing()
                    self.updateEvent(.none)
                }
            }
        }
    }
    override var reqiureFixOffsetOnLoading: Bool { return false }
}
extension RefreshFastFooter {
    static public func makeFastFooter(_ refreshingBlock: @escaping RefreshingBlock) -> RefreshFastFooter {
        let footer = RefreshFastFooter(with: refreshingBlock)
        return footer
    }
}

//
//  RefreshHeaderControl.swift
//  Pods-RefreshKit_Example
//
//  Created by legendry on 2018/10/26.
//

import UIKit

public typealias RefreshingBlock = () -> ()

public class RefreshHeaderControl: RefreshEventControl {

    var refreshHeight: CGFloat = 60
   
    public override init(with refreshingBlock: @escaping RefreshingBlock) {
        super.init(with: refreshingBlock)
    }
    override public func handleDragging(_ point: CGPoint, _ scrollView: UIScrollView) {
        if scrollView.isDragging {
            let h = self.frame.size.height
            let offsetY = abs(point.y) - abs(self.basicOffsetY)
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
                scrollView.setContentOffset(.init(x: 0, y: self.basicOffsetY - self.frame.size.height), animated: true)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    self.refreshing()
                }
                self.updateEvent(.none)
            default:
                break
            }
        }
    }
    public override func stopRefresh() {
        self.parent.setContentOffset(.init(x: 0, y: self.basicOffsetY), animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            self.refreshCompleted()
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//
//  RefreshDefaultHeader.swift
//  Pods-RefreshKit_Example
//
//  Created by legendry on 2018/10/25.
//

import UIKit

extension Date {
    static fileprivate func currentUpdateTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return  "当前时间: \(formatter.string(from: Date()))"
    }
}
public class RefreshDefaultHeader: RefreshView {
    
    var labelTime = UILabel()
    var labtlStatus = UILabel()
    
    fileprivate override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(labelTime)
        self.labelTime.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(NSLayoutConstraint.init(item: labelTime, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: labelTime, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0))
        labelTime.setContentHuggingPriority(UILayoutPriority.defaultLow, for: UILayoutConstraintAxis.horizontal)
        labelTime.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: UILayoutConstraintAxis.horizontal)
        labelTime.text = Date.currentUpdateTime()
        labelTime.font = UIFont.systemFont(ofSize: 15)
        labelTime.textColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func eventChanged(_ newEvent: DraggingEvent) {
        switch newEvent {
        case .complete:
            print("松开就刷新...")
        case .perpare:
            print("松开就反弹...")
        case .pulling(_):
            print("即将刷新...")
        default:
            break
        }
    }
    public override func execUpdate() {
        super.execUpdate()
        self.labelTime.text = Date.currentUpdateTime()
    }
}

extension RefreshDefaultHeader {
    static public func make() -> RefreshDefaultHeader {
        let header = RefreshDefaultHeader(frame: .init(x: 0, y: -60, width: 100, height: 60))
        return header
    }
}

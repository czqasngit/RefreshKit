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
        return  "上次刷新: \(formatter.string(from: Date()))"
    }
}
public class RefreshDefaultHeader: RefreshHeaderControl {
    
    var labelTime = UILabel()
    var labtlStatus = UILabel()
    var imageArrow = UIImageView(image: UIImage(named: "arrow_down"))
    
    private override init(with refreshingBlock: @escaping RefreshingBlock) {
        super.init(with: refreshingBlock)
        self.setup()
    }
    func setup() {
        
        self.addSubview(self.imageArrow)
        self.imageArrow.translatesAutoresizingMaskIntoConstraints = false
        self.imageArrow.addConstraint(.init(item: self.imageArrow, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: self.imageArrow.image?.size.width ?? 0))
        self.imageArrow.addConstraint(.init(item: self.imageArrow, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: self.imageArrow.image?.size.height ?? 0))
        self.addConstraint(.init(item: self.imageArrow, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 25))
        self.addConstraint(.init(item: self.imageArrow, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0))
        
        self.addSubview(labelTime)
        self.labelTime.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(NSLayoutConstraint.init(item: labelTime, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self.imageArrow, attribute: NSLayoutAttribute.trailing, multiplier: 1.0, constant: 5))
        self.addConstraint(NSLayoutConstraint.init(item: labelTime, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: -5))
        labelTime.setContentHuggingPriority(UILayoutPriority.defaultLow, for: UILayoutConstraintAxis.horizontal)
        labelTime.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: UILayoutConstraintAxis.horizontal)
        labelTime.text = Date.currentUpdateTime()
        labelTime.font = UIFont.systemFont(ofSize: 15)
        labelTime.textColor = UIColor.white
        
        self.addSubview(self.labtlStatus)
        self.labtlStatus.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(NSLayoutConstraint.init(item: labtlStatus, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self.labelTime, attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: labtlStatus, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 5))
        labtlStatus.setContentHuggingPriority(UILayoutPriority.defaultLow, for: UILayoutConstraintAxis.horizontal)
        labtlStatus.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: UILayoutConstraintAxis.horizontal)
        labtlStatus.text = "等待..."
        labtlStatus.font = UIFont.systemFont(ofSize: 15)
        labtlStatus.textColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func eventChanged(_ newEvent: DraggingEvent) {
        switch newEvent {
        case .complete:
            self.labtlStatus.text = "松开就刷新..."
            self.imageArrow.image = UIImage(named: "arrow_up")
        case .perpare:
            self.labtlStatus.text = "松开就反弹..."
            self.imageArrow.image = UIImage(named: "arrow_down")
        case .pulling(_):
            self.labtlStatus.text = "即将刷新..."
            self.imageArrow.image = UIImage(named: "arrow_down")
        default:
            break
        }
    }
    public override func refreshing() {
        super.refreshing()
        self.labtlStatus.text = "正在刷新..."
    }
    public override func refreshCompleted() {
        super.refreshCompleted()
        self.labelTime.text = Date.currentUpdateTime()
    }
}

extension RefreshDefaultHeader {
    static public func make(_ refreshingBlock: @escaping RefreshingBlock) -> RefreshDefaultHeader {
        let header = RefreshDefaultHeader(with: refreshingBlock)
        return header
    }
}

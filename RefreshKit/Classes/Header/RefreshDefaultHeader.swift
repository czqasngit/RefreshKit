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
        formatter.dateFormat = "MM-dd HH:mm"
        return  "最后更新: \(formatter.string(from: Date()))"
    }
}
public class RefreshDefaultHeader: RefreshHeaderControl {
    
    let labelTime = UILabel()
    let labtlStatus = UILabel()
    var imageArrow: UIImageView
    let activity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    
    private override init(with refreshingBlock: @escaping RefreshingBlock) {
        let refreshBundle = Bundle(for: RefreshDefaultHeader.self).path(forResource: "RefreshKit", ofType: "bundle")!
        self.imageArrow = UIImageView(image: UIImage(contentsOfFile: "\(refreshBundle)/arrow.png"))
        super.init(with: refreshingBlock)
        self.setup()
    }
    func setup() {
        self.backgroundColor = UIColor.white
        self.labelTime.textColor = UIColor(red: 0x99 / 255.0, green: 0x99 / 255.0, blue: 0x99 / 255.0, alpha: 1.0)
        self.labtlStatus.textColor = self.labelTime.textColor
        
        self.addSubview(self.imageArrow)
        self.imageArrow.translatesAutoresizingMaskIntoConstraints = false
        self.imageArrow.addConstraint(.init(item: self.imageArrow, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: self.imageArrow.image?.size.width ?? 0))
        self.imageArrow.addConstraint(.init(item: self.imageArrow, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: self.imageArrow.image?.size.height ?? 0))
        self.addConstraint(.init(item: self.imageArrow, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 0.5, constant: 0))
        self.addConstraint(.init(item: self.imageArrow, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0))
        
        activity.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activity)
        activity.addConstraint(.init(item: self.activity, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: activity.frame.size.width))
        activity.addConstraint(.init(item: self.activity, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: activity.frame.size.height))
        self.addConstraint(.init(item: self.activity, attribute: .centerX, relatedBy: .equal, toItem: self.imageArrow, attribute: .centerX, multiplier: 1.0, constant: 0))
        self.addConstraint(.init(item: self.activity, attribute: .centerY, relatedBy: .equal, toItem: self.imageArrow, attribute: .centerY, multiplier: 1.0, constant: 0))
        
        self.addSubview(self.labtlStatus)
        self.labtlStatus.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(NSLayoutConstraint.init(item: labtlStatus, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self.labelTime, attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: labtlStatus, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: -5))
        self.addConstraint(.init(item: self.labtlStatus, attribute: .width, relatedBy: .greaterThanOrEqual, toItem: self.labelTime, attribute: .width, multiplier: 1.0, constant: 0))
        labtlStatus.setContentHuggingPriority(UILayoutPriority.defaultLow, for: UILayoutConstraintAxis.horizontal)
        labtlStatus.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: UILayoutConstraintAxis.horizontal)
        labtlStatus.text = ""
        labtlStatus.font = UIFont.systemFont(ofSize: 15)
        labtlStatus.textAlignment = .center
        
        self.addSubview(labelTime)
        self.labelTime.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(NSLayoutConstraint.init(item: labelTime, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self.imageArrow, attribute: NSLayoutAttribute.trailing, multiplier: 1.0, constant: 10))
        self.addConstraint(NSLayoutConstraint.init(item: labelTime, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 5))
        labelTime.setContentHuggingPriority(UILayoutPriority.defaultLow, for: UILayoutConstraintAxis.horizontal)
        labelTime.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: UILayoutConstraintAxis.horizontal)
        labelTime.text = Date.currentUpdateTime()
        labelTime.font = UIFont.systemFont(ofSize: 15)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func eventChanged(_ newEvent: DraggingEvent) {
        super.eventChanged(newEvent)
        switch newEvent {
        case .complete:
            self.labtlStatus.text = "松开立即刷新"
            UIView.animate(withDuration: 0.15) {
                self.imageArrow.transform = CGAffineTransform.init(rotationAngle: -CGFloat.pi)
            }
            self.activity.isHidden = true
            self.imageArrow.isHidden = false
        case .perpare:
            self.labtlStatus.text = "下拉即可刷新"
            self.imageArrow.transform = CGAffineTransform.init(rotationAngle: 0)
            self.activity.isHidden = true
            self.imageArrow.isHidden = false
        case .pulling(_):
            self.labtlStatus.text = "下拉即可刷新"
            UIView.animate(withDuration: 0.15) {
                self.imageArrow.transform = CGAffineTransform.init(rotationAngle: 0)
            }
            self.activity.isHidden = true
            self.imageArrow.isHidden = false
        default:
            break
        }
    }
    public override func refreshing() {
        super.refreshing()
        self.labtlStatus.text = "正在刷新..."
        self.activity.isHidden = false
        self.activity.startAnimating()
        self.imageArrow.isHidden = true
    }
    public override func refreshCompleted() {
        super.refreshCompleted()
        self.labelTime.text = Date.currentUpdateTime()
        self.activity.stopAnimating()
    }
}

extension RefreshDefaultHeader {
    static public func make(_ refreshingBlock: @escaping RefreshingBlock) -> RefreshDefaultHeader {
        let header = RefreshDefaultHeader(with: refreshingBlock)
        return header
    }
}

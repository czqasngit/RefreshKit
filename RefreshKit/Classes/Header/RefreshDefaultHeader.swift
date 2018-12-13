//
//  RefreshDefaultHeader.swift
//  Pods-RefreshKit_Example
//
//  Created by legendry on 2018/10/25.
//

import UIKit
import BerryPlant

extension Date {
    static fileprivate func currentUpdateTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd HH:mm"
        return  "最后更新: \(formatter.string(from: Date()))"
    }
}
extension DraggingEvent {
    var headerText: String {
        switch self {
        case .complete:
            return "松开立即刷新"
        case .pulling(_),
             .perpare:
            return "下拉即可刷新"
        default:
            return ""
        }
    }
}
public class RefreshDefaultHeader: RefreshHeaderControl {
    
    let labelTime = UILabel()
    let labtlStatus = UILabel()
    var icon: UIImageView
    let activity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    var imageProvider: BerryImageProvider? = nil
    public init(with path: String, refreshingBlock: @escaping RefreshingBlock) {
        if let data = try? Data.init(contentsOf: URL(fileURLWithPath: path)) {
            self.imageProvider = FindImageDecoder(with: data)
            self.icon = BerryAnimateImageView(with: imageProvider!, frame: .zero)
        } else {
            self.icon = UIImageView(frame: .zero)
        }
        super.init(with: refreshingBlock)
        self.setup()
    }
    func setup() {
        self.backgroundColor = UIColor.white
        self.labelTime.textColor = UIColor(red: 0x99 / 255.0, green: 0x99 / 255.0, blue: 0x99 / 255.0, alpha: 1.0)
        self.labtlStatus.textColor = self.labelTime.textColor
        
        self.addSubview(self.icon)
        self.icon.translatesAutoresizingMaskIntoConstraints = false
        self.icon.contentMode = .scaleAspectFit
        self.icon.addConstraint(.init(item: self.icon, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: self.iconSize().width))
        self.icon.addConstraint(.init(item: self.icon, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: self.iconSize().height))
        self.addConstraint(.init(item: self.icon, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 0.5, constant: 0))
        self.addConstraint(.init(item: self.icon, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0))
        
        activity.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activity)
        activity.addConstraint(.init(item: self.activity, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: activity.frame.size.width))
        activity.addConstraint(.init(item: self.activity, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: activity.frame.size.height))
        self.addConstraint(.init(item: self.activity, attribute: .centerX, relatedBy: .equal, toItem: self.icon, attribute: .centerX, multiplier: 1.0, constant: 0))
        self.addConstraint(.init(item: self.activity, attribute: .centerY, relatedBy: .equal, toItem: self.icon, attribute: .centerY, multiplier: 1.0, constant: 0))
        
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
        self.addConstraint(NSLayoutConstraint.init(item: labelTime, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self.icon, attribute: NSLayoutAttribute.trailing, multiplier: 1.0, constant: 10))
        self.addConstraint(NSLayoutConstraint.init(item: labelTime, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 5))
        labelTime.setContentHuggingPriority(UILayoutPriority.defaultLow, for: UILayoutConstraintAxis.horizontal)
        labelTime.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: UILayoutConstraintAxis.horizontal)
        labelTime.text = Date.currentUpdateTime()
        labelTime.font = UIFont.systemFont(ofSize: 15)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func canRotateicon() -> Bool {
        return true
    }
    func iconSize() -> CGSize {
        return .init(width: 15, height: 40)
    }
    
    override public func eventChanged(_ newEvent: DraggingEvent) {
        super.eventChanged(newEvent)
        
        switch newEvent {
        case .complete:
            self.labtlStatus.text = newEvent.headerText
            if canRotateicon() {
                UIView.animate(withDuration: 0.15) {
                    self.icon.transform = CGAffineTransform.init(rotationAngle: -CGFloat.pi)
                }
            }
            self.activity.isHidden = true
            self.icon.isHidden = false
        case .perpare:
            self.labtlStatus.text = newEvent.headerText
            self.icon.transform = CGAffineTransform.init(rotationAngle: 0)
            self.activity.isHidden = true
            self.icon.isHidden = false
        case .pulling(_):
            self.labtlStatus.text = newEvent.headerText
            if canRotateicon() {
                UIView.animate(withDuration: 0.15) {
                    self.icon.transform = CGAffineTransform.init(rotationAngle: 0)
                }
            }
            self.activity.isHidden = true
            self.icon.isHidden = false
        default:
            break
        }
    }
    public override func refreshing() {
        super.refreshing()
        self.labtlStatus.text = DraggingEvent.refreshingText
        self.activity.isHidden = false
        self.activity.startAnimating()
        self.icon.isHidden = true
    }
    public override func refreshCompleted() {
        super.refreshCompleted()
        self.labelTime.text = Date.currentUpdateTime()
        self.activity.stopAnimating()
    }
}

extension RefreshDefaultHeader {
    static public func make(_ refreshingBlock: @escaping RefreshingBlock) -> RefreshDefaultHeader {
        let refreshBundle = Bundle(for: RefreshDefaultHeader.self).path(forResource: "RefreshKit", ofType: "bundle")!
        let header = RefreshDefaultHeader(with: "\(refreshBundle)/arrow@2x.png", refreshingBlock: refreshingBlock)
        return header
    }
}

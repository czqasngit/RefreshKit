//
//  RefreshDefaultHeader.swift
//  Pods-RefreshKit_Example
//
//  Created by legendry on 2018/10/25.
//

import UIKit

extension DraggingEvent {
    var footerText: String {
        switch self {
        case .complete:
            return "松开立即刷新"
        case .pulling(_),
             .perpare:
            return "上拉即可刷新"
        default:
            return ""
        }
    }
    static var refreshCompleted: String {
        return "刷新完成..."
    }
    static var noMoreData: String {
        return "没有更多数据了..."
    }
}
public class RefreshDefaultFooter: RefreshFooterControl {
    
    let labtlStatus = UILabel()
    var imageArrow: UIImageView
    let activity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    
    public override init(with refreshingBlock: @escaping RefreshingBlock) {
        let refreshBundle = Bundle(for: RefreshDefaultHeader.self).path(forResource: "RefreshKit", ofType: "bundle")!
        self.imageArrow = UIImageView(image: UIImage(contentsOfFile: "\(refreshBundle)/arrow.png"))
        super.init(with: refreshingBlock)
        self.setup()
    }
    func setup() {
        self.backgroundColor = UIColor.white
        self.labtlStatus.textColor = UIColor(red: 0x99 / 255.0, green: 0x99 / 255.0, blue: 0x99 / 255.0, alpha: 1.0)
        self.addSubview(self.imageArrow)
        self.imageArrow.contentMode = .scaleAspectFit
        self.imageArrow.translatesAutoresizingMaskIntoConstraints = false
        self.imageArrow.addConstraint(.init(item: self.imageArrow, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: self.imageArrow.image?.size.width ?? 0))
        self.imageArrow.addConstraint(.init(item: self.imageArrow, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: self.imageArrow.image?.size.height ?? 0))
        self.addConstraint(.init(item: self.imageArrow, attribute: .trailing, relatedBy: .equal, toItem: self.labtlStatus, attribute: .leading, multiplier: 1, constant: 0))
        self.addConstraint(.init(item: self.imageArrow, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0))
        activity.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activity)
        activity.addConstraint(.init(item: self.activity, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: activity.frame.size.width))
        activity.addConstraint(.init(item: self.activity, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: activity.frame.size.height))
        self.addConstraint(.init(item: self.activity, attribute: .leading, relatedBy: .equal, toItem: self.imageArrow, attribute: .centerX, multiplier: 1.0, constant: -12.5))
        self.addConstraint(.init(item: self.activity, attribute: .centerY, relatedBy: .equal, toItem: self.imageArrow, attribute: .centerY, multiplier: 1.0, constant: 0))
        self.addSubview(self.labtlStatus)
        self.labtlStatus.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(NSLayoutConstraint.init(item: labtlStatus, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: self.imageArrow.frame.size.width / 2))
        self.labtlStatus.addConstraint(.init(item: self.labtlStatus, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 120))
        self.addConstraint(.init(item: labtlStatus, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0))
        labtlStatus.setContentHuggingPriority(UILayoutPriority.defaultLow, for: UILayoutConstraintAxis.vertical)
        labtlStatus.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: UILayoutConstraintAxis.vertical)
        labtlStatus.text = " "
        labtlStatus.font = UIFont.systemFont(ofSize: 15)
        labtlStatus.textAlignment = .center
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func eventChanged(_ newEvent: DraggingEvent) {
        super.eventChanged(newEvent)
        let refreshBundle = Bundle(for: RefreshDefaultHeader.self).path(forResource: "RefreshKit", ofType: "bundle")!
        switch newEvent {
        case .complete:
            self.imageArrow.image = UIImage(contentsOfFile: "\(refreshBundle)/arrow.png")
            self.labtlStatus.text = newEvent.footerText
            UIView.animate(withDuration: 0.15) {
                self.imageArrow.transform = CGAffineTransform.init(rotationAngle: 0)
            }
            self.activity.isHidden = true
            self.imageArrow.isHidden = false
        case .perpare:
            self.imageArrow.image = UIImage(contentsOfFile: "\(refreshBundle)/arrow.png")
            self.labtlStatus.text = newEvent.footerText
            self.imageArrow.transform = CGAffineTransform.init(rotationAngle: -CGFloat.pi)
            self.activity.isHidden = true
            self.imageArrow.isHidden = false
        case .pulling(_):
            self.imageArrow.image = UIImage(contentsOfFile: "\(refreshBundle)/arrow.png")
            self.labtlStatus.text = newEvent.footerText
//            UIView.animate(withDuration: 0.15) {
//                self.imageArrow.transform = CGAffineTransform.init(rotationAngle: -CGFloat.pi)
//            }
            self.activity.isHidden = true
            self.imageArrow.isHidden = false
        default:
            break
        }
    }
    public override func refreshing() {
        super.refreshing()
        self.labtlStatus.text = DraggingEvent.refreshingText
        self.activity.isHidden = false
        self.activity.startAnimating()
        self.imageArrow.isHidden = true
        _log("正在刷新...")
    }
    public override func stopRefresh() {
        guard self.isRefreshing else { return }
        super.stopRefresh()
        self.labtlStatus.text = DraggingEvent.refreshCompleted
        self.activity.isHidden = true
        self.imageArrow.isHidden = false
        let refreshBundle = Bundle(for: RefreshDefaultHeader.self).path(forResource: "RefreshKit", ofType: "bundle")!
        self.imageArrow.image = UIImage(contentsOfFile: "\(refreshBundle)/animate.png")
        _log("停止刷新...")
    }
    public override func startRefresh() {
        super.startRefresh()
    }
    public override func noMoreData() {
        super.noMoreData()
        self.activity.stopAnimating()
        self.activity.isHidden = true
        self.labtlStatus.text = DraggingEvent.noMoreData
    }
    public override func refreshCompleted() {
        super.refreshCompleted()
        self.activity.stopAnimating()
        _log("刷新完成...")
    }
}

extension RefreshDefaultFooter {
    static public func make(_ refreshingBlock: @escaping RefreshingBlock) -> RefreshDefaultFooter {
        let footer = RefreshDefaultFooter(with: refreshingBlock)
        return footer
    }
}

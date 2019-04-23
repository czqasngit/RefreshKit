//
//  RefreshCustomFooter.swift
//  SwiftRefreshKit
//
//  Created by legendry on 2019/4/18.
//

import Foundation
import UIKit

public class RefreshCustomFooter: RefreshFooterControl {
    
    private let refreshImageView: UIImageView
    private let noMoreLabel: UILabel
    
    fileprivate init(block: @escaping RefreshingBlock , size: CGSize, frames: [UIImage]) {
        self.refreshImageView = UIImageView(frame: .zero)
        self.noMoreLabel = UILabel(frame: .zero)
        super.init(with: block);
        self.refreshImageView.translatesAutoresizingMaskIntoConstraints = false
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.refreshImageView)
        self.refreshImageView.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        self.refreshImageView.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        self.refreshImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.refreshImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.refreshImageView.animationImages = frames
        
        self.addSubview(self.noMoreLabel)
        self.noMoreLabel.translatesAutoresizingMaskIntoConstraints = false
        self.noMoreLabel.text = "- END -"
        self.noMoreLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.noMoreLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func eventChanged(_ newEvent: DraggingEvent) {
        super.eventChanged(newEvent)
        switch newEvent {
        case .complete:
            self.refreshImageView.startAnimating()
        case .perpare:
            self.refreshImageView.alpha = 0.5
            self.noMoreLabel.isHidden = true
            self.refreshImageView.isHidden = false
        case .pulling(let percent):
            self.refreshImageView.alpha = CGFloat(percent + 0.5)
        default:
            break
        }
    }
    public override func stopRefresh() {
        super.stopRefresh()
        self.refreshImageView.stopAnimating()
    }
    public override func noMoreData() {
        super.noMoreData()
        self.noMoreLabel.isHidden = false
        self.refreshImageView.isHidden = true
    }
    
    public func configure(frames: [UIImage]? = nil, font: UIFont? = nil, textColor: UIColor? = nil) {
        if let frames = frames {
            self.refreshImageView.animationImages = frames
        }
        if let font = font {
            self.noMoreLabel.font = font
        }
        if let textColor = textColor {
            self.noMoreLabel.textColor = textColor
            self.refreshImageView.tintColor = textColor
        }
    }
    
}
extension RefreshCustomFooter {
    static public func make(size: CGSize, frames: [UIImage], block: @escaping RefreshingBlock) -> RefreshCustomFooter {
        return RefreshCustomFooter.init(block: block, size: size, frames: frames)
    }
}

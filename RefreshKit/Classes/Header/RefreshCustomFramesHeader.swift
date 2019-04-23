//
//  RefreshFramesHeader.swift
//  BerryPlant
//
//  Created by legendry on 2018/12/13.
//

import Foundation
//
//  RefreshGifHeader.swift
//  RefreshKit
//
//  Created by legendry on 2018/10/30.
//

import UIKit
import BerryPlant



public class RefreshCustomFramesHeader: RefreshFramesHeader {
    override func setup() {
        super.setup()
        self.activity.removeFromSuperview()
        self.labelTime.removeFromSuperview()
        self.labtlStatus.removeFromSuperview()
        self.icon.alpha = 0
    }
    override public func setupIcon() {
        self.icon.addConstraint(.init(item: self.icon, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: self.iconSize().width))
        self.icon.addConstraint(.init(item: self.icon, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: self.iconSize().height))
        self.addConstraint(.init(item: self.icon, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
        self.addConstraint(.init(item: self.icon, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0))
    }
    public override func pulling(percent: Float) {
        super.pulling(percent: percent)
        self.icon.alpha = CGFloat(percent)
        print("percent: \(percent)")
    }
    public override func toggle() {
        super.toggle()
        self.icon.alpha = 1.0
    }
    public func updateIconTintColor(_ color: UIColor) {
        self.icon.tintColor = color
    }
}

extension RefreshCustomFramesHeader {
    static public func makeCustom(_ frames: [UIImage], _ pullingMaxFrameCount: Int, refreshingBlock: @escaping RefreshingBlock) -> RefreshCustomFramesHeader {
        let header = RefreshCustomFramesHeader.init(with: frames, pullingMaxFrameCount: pullingMaxFrameCount, refreshingBlock: refreshingBlock)
        return header
    }
}

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
    
    let highlightedAnimationImages: [UIImage]
    init(with frames: [UIImage],
                  highlightedAnimationImages: [UIImage],
                  pullingMaxFrameCount: Int,
                  refreshingBlock: @escaping RefreshingBlock) {
        self.highlightedAnimationImages = highlightedAnimationImages
        super.init(with: frames, pullingMaxFrameCount: pullingMaxFrameCount, refreshingBlock: refreshingBlock)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setup() {
        super.setup()
        self.activity.removeFromSuperview()
        self.labelTime.removeFromSuperview()
        self.labtlStatus.removeFromSuperview()
        self.icon.alpha = 0
        self.icon.highlightedAnimationImages = self.highlightedAnimationImages
        self.icon.highlightedImage = self.highlightedAnimationImages.first
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
    public func update(_ isHighlighted: Bool) {
        self.icon.isHighlighted = isHighlighted
    }
}

extension RefreshCustomFramesHeader {
    static public func makeCustom(_ frames: [UIImage],
                                  _ highlightedAnimationImages: [UIImage],
                                  _ pullingMaxFrameCount: Int,
                                  refreshingBlock: @escaping RefreshingBlock) -> RefreshCustomFramesHeader {
        let header = RefreshCustomFramesHeader.init(with: frames,
                                                    highlightedAnimationImages: highlightedAnimationImages,
                                                    pullingMaxFrameCount: pullingMaxFrameCount,
                                                    refreshingBlock: refreshingBlock)
        return header
    }
}

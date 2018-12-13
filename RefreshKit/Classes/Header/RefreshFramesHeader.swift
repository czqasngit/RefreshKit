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



public class RefreshFramesHeader: RefreshDefaultHeader {
    var frames: [String]
    var images: [UIImage]
    var pullingMaxFrameCount: Int
    init(with frames: [String], pullingMaxFrameCount: Int, refreshingBlock: @escaping RefreshingBlock) {
        self.frames = frames
        self.images = frames.map {
            return UIImage(named: $0)!
        }
        self.pullingMaxFrameCount = pullingMaxFrameCount
        super.init(with: "", refreshingBlock: refreshingBlock)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setup() {
        super.setup()
        self.activity.removeFromSuperview()
        self.icon.animationImages = self.images
    }
    public override func eventChanged(_ newEvent: DraggingEvent) {
        super.eventChanged(newEvent)
        self.icon.image = self.images.last
    }
    public override func pulling(percent: Float) {
        super.pulling(percent: percent)
        let index = Int(Float(pullingMaxFrameCount) * percent)
        print("index: \(index)")
        self.icon.image = self.images[index]
    }
    override func canRotateicon() -> Bool {
        return false
    }
    override func iconSize() -> CGSize {
        return .init(width: 50, height: 50)
    }
    public override func refreshing() {
        super.refreshing()
        self.icon.startAnimating()
        self.icon.isHidden = false
    }
    public override func refreshCompleted() {
        super.refreshCompleted()
        self.icon.stopAnimating()
    }
}

extension RefreshFramesHeader {
    static public func make(_ frames: [String], _ pullingMaxFrameCount: Int, refreshingBlock: @escaping RefreshingBlock) -> RefreshFramesHeader {
        let header = RefreshFramesHeader.init(with: frames, pullingMaxFrameCount: pullingMaxFrameCount, refreshingBlock: refreshingBlock)
        return header
    }
}

//
//  RefreshGifHeader.swift
//  RefreshKit
//
//  Created by legendry on 2018/10/30.
//

import UIKit
import BerryPlant


public class RefreshAnimateHeader: RefreshDefaultHeader {



    override func setup() {
        super.setup()
        self.activity.removeFromSuperview()
    }
    public override func pulling(percent: Float) {
        super.pulling(percent: percent)
        if let image = self.imageProvider.readImage(at: Int(Float(self.imageProvider.numberOfFrames()) * percent)) {
            self.icon.image = UIImage(cgImage: image.image)
        }
        
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

extension RefreshAnimateHeader {
    static public func make(_ animateFilePath: String, refreshingBlock: @escaping RefreshingBlock) -> RefreshAnimateHeader {
        let header = RefreshAnimateHeader.init(with: animateFilePath, refreshingBlock: refreshingBlock)
        return header
    }
}

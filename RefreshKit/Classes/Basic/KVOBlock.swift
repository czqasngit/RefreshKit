//
//  KVOBlock.swift
//  RefreshKit
//
//  Created by legendry on 2018/10/24.
//

import Foundation


public typealias KVOBlock = (_ keyPath: String?, _ object: Any?, _ change: [NSKeyValueChangeKey: Any]?, _ context: UnsafeMutableRawPointer?) -> Void
class KVOObject: NSObject {
    var block: KVOBlock
    fileprivate var key = "\n"
    deinit {
        print("KVOObject deinit")
    }
    init(target: AnyObject, keyPath: String, block: @escaping KVOBlock) {
        self.block = block
        super.init()
        target.addObserver(self, forKeyPath: keyPath, options: .new, context: nil)
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.block(keyPath, object, change, context)
    }
}

extension NSObject {
    public func observe(forKeyPath keyPath: String, _ block: @escaping KVOBlock) {
        let kvoObject = KVOObject(target: self, keyPath: keyPath, block: block)
        objc_setAssociatedObject(self, &kvoObject.key, kvoObject, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}

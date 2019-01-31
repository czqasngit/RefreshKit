//
//  KVOBlock.swift
//  RefreshKit
//
//  Created by legendry on 2018/10/24.
//

import Foundation


public typealias KVOBlock = (_ keyPath: String?, _ object: Any?, _ change: [NSKeyValueChangeKey: Any]?, _ context: UnsafeMutableRawPointer?) -> Void
class KVOObject: NSObject {
    var blocks: [KVOBlock]
    weak var target: AnyObject?
    var keyPaths: [String]
    deinit {
        _log("KVOObject deinit")
        self.keyPaths.forEach {
            self.target?.removeObserver(self, forKeyPath: $0)
            _log("移除\(self.target)的\($0)监听")
        }
        
    }
    init(target: AnyObject, keyPaths: [String], block: @escaping KVOBlock) {
        self.blocks = [KVOBlock]()
        self.blocks.append(block)
        self.target = target
        self.keyPaths = keyPaths
        super.init()
        keyPaths.forEach {
            target.addObserver(self, forKeyPath: $0, options: .new, context: nil)
        }
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.blocks.forEach {
            $0(keyPath, object, change, context)
        }
    }
}
let kKVOKey = UnsafeMutablePointer<UInt8>.allocate(capacity: 0)
extension NSObject {
    public func observe(forKeyPath keyPaths: [String], _ block: @escaping KVOBlock) {
        if let _ = objc_getAssociatedObject(self, kKVOKey) as? KVOObject {
            self.appendObserve(block)
        } else {
            let kvoObject = KVOObject(target: self, keyPaths: keyPaths, block: block)
            objc_setAssociatedObject(self, kKVOKey, kvoObject, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
        
    }
    private func appendObserve(_ block: @escaping KVOBlock) {
        if let kvoObject = objc_getAssociatedObject(self, kKVOKey) as? KVOObject {
            kvoObject.blocks.append(block)
        }
    }
}

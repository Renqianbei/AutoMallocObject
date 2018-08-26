//
//  ExchangPro.swift
//  ExchangePro
//
//  Created by mrxier on 2018/8/26.
//  Copyright © 2018年 Predor. All rights reserved.
//

import Foundation

@objcMembers
class Person: NSObject,Codable {
    
    var name:String = ""
    var age:Int = 10
    var first:Optional<Pent>
    var second:Pent = Pent()
    var pentsOp:[Pent]?
    var pents:[Pent] = [Pent]()

    @objcMembers
    class Pent: NSObject,Codable {
        var name:String = ""
        var age:Int = 0
        
    }

}




func updateWithdict(model:NSObject,value:[String:Any]) {
    
    Mirror(reflecting: model).children.forEach { (child) in
        
        guard  let label = child.label else {
            return
        }
        
        let _TYPE = type(of: child.value)
        print(label)
        print(_TYPE)
        
        if let _nstype = _TYPE as? _AutoMallocObjectProtocol.Type {
            let instance = _nstype._creatInstance()
            
            if var models = instance as? Array<Any> {
               
                guard let elementInstance = (_TYPE as? _MallcoContentInstanceProtocol.Type)?._creatElement() else{return}
                
                let array = value[label] as? [[String:Any]] ?? [[String:Any]]()
                for dict in array {
                    if let m = elementInstance as? NSObject {
                        updateWithdict(model: m, value: dict)
                        models.append(m)
                    }
                }
                 model.setValue(models, forKey: label)
                
                
            } else
                if let nsmodel = instance as? NSObject {
                    updateWithdict(model:nsmodel , value: value[label] as! [String:Any])
                    model.setValue(instance, forKey: label)
            }
            
           
            
        } else {
            model.setValue(value[label], forKey: label)
            
        }
        
        
        
        
    }
    
}

//createInstance
protocol _AutoMallocObjectProtocol {
    static func _creatInstance() -> Self
}

//create嵌套类型中的Instance
protocol _MallcoContentInstanceProtocol  {
    static func _creatElement() -> Any?
}

extension NSObject:_AutoMallocObjectProtocol  {
    static func _creatInstance() -> Self {
        return  self.init()
    }
    
}

extension Optional:_AutoMallocObjectProtocol,_MallcoContentInstanceProtocol {
    
    static func _creatInstance() -> Optional<Wrapped> {
        var instance:Wrapped
        if let _type = Wrapped.self as? _AutoMallocObjectProtocol.Type {
            instance = _type._creatInstance() as! Wrapped
            return Optional.init(instance)
        }
        return nil
    }
    
    static func _creatElement() -> Any? {
        if let _type = Wrapped.self as? _MallcoContentInstanceProtocol.Type {
            return  _type._creatElement()
        }
        return nil
    }
    
}


extension Array:_AutoMallocObjectProtocol,_MallcoContentInstanceProtocol {
    
    static func _creatInstance() -> Array<Element> {
        return _collectionCreatInstance()
    }
    
    
    static func _creatElement() -> Any? {
        if let _type = Element.self as? _AutoMallocObjectProtocol.Type {
            return  _type._creatInstance() as? Element
        }
        return nil
    }

}

extension Set:_AutoMallocObjectProtocol {
    static func _creatInstance() -> Set<Element> {
        let arr = _collectionCreatInstance()
        return Set(arr)
    }
}

extension Collection {
    static func _collectionCreatInstance() -> [Iterator.Element] {
        let instance = [Iterator.Element]()
        return instance
    }
}









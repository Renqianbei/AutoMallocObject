//
//  ViewController.swift
//  ExchangePro
//
//  Created by mrxier on 2018/8/26.
//  Copyright © 2018年 Predor. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
        let dog1 = Person.Pent.init()
        dog1.name = "hello"
        dog1.age = 20
        let dog2 = Person.Pent.init()
        dog2.name = "word"
        dog2.age = 10
        
        let person = Person.init()
        person.age = 100
        person.name = "大哥"
        person.first = dog1
        person.second = dog2
        person.pentsOp = [dog2,dog1]
        person.pents = [dog1,dog2]
        let data = try! JSONEncoder.init().encode(person)
        
        let dict = try!  JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:Any]
        
        let model = Person()
        updateWithdict(model:model , value: dict )
        
        print(model.name)
        print(model.age)
        print(model.first?.name)
        
        print(model.second.name)
        
        print("数组",model.pents.first?.name)
        print("可选数组",model.pentsOp?.first?.name)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  Pokemon.swift
//  PokeFinder
//
//  Created by Alexander Kaplan on 7/28/16.
//  Copyright © 2016 develop. All rights reserved.
//

import Foundation
import UIKit

class Pokemon{
    private var _name: String!
    private var _id: Int!
    
    var name: String{
        get{
            if _name != nil{
                return _name
            }
            return ""
        }
    }
    
    var id: Int{
        if _id != nil{
            return _id
        }
        return 0
    }
    
    init(name: String, id: Int){
        _name = name
        _id = id
    }
}

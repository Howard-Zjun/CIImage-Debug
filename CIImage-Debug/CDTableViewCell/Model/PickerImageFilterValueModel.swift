//
//  PickerImageFilterValueModel.swift
//  CIImage-Debug
//
//  Created by ios on 2024/10/30.
//

import UIKit

class PickerImageFilterValueModel: NSObject, FilterValueModel {

    let name: String
    
    @objc dynamic var img: UIImage?
    
    init(name: String) {
        self.name = name
    }
}

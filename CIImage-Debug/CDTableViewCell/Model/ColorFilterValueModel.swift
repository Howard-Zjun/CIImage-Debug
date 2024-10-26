//
//  ColorFilterValueModel.swift
//  CIImage-Debug
//
//  Created by Howard-Zjun on 2024/10/23.
//

import UIKit
import MyControlView

class ColorFilterValueModel: FilterValueModel {

    let name: String
    
    let model: MYHSBColorPickerViewModel
    
    init(name: String, hue: CGFloat, sat: CGFloat) {
        self.name = name
        self.model = .init(hue: hue, sat: sat)
    }
}

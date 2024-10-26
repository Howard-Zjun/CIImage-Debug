//
//  SliderFilterValueModel.swift
//  CIImage-Debug
//
//  Created by Howard-Zjun on 2024/9/25.
//

import UIKit
import MyControlView

class SliderFilterValueModel: FilterValueModel {
    
    let name: String
    
    let model: STSliderViewModel
    
    init(model: STSliderViewModel) {
        self.name = model.name
        self.model = model
    }
}

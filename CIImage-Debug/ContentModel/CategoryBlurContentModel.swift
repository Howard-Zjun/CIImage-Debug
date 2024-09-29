//
//  CategoryBlurContentModel.swift
//  CIImage-Debug
//
//  Created by ios on 2024/9/25.
//

import UIKit

class CategoryBlurContentModel: FilterContentModel {
    
    var name: String
    
    var filterModel: [FilterValueModel]
    
    init(categoryBlur: CIFilterProtocol.Type) {
        let mirror = Mirror(reflecting: categoryBlur)
        var filterModel: [FilterValueModel] = []
        for child in mirror.children {
            if let lab = child.label {
                let valueType = type(of: child.value)
                if valueType == Float.self {
                    if let model = STSliderViewModel(name: lab, minValue: 0, maxValue: 10, thumbValue: 5) {
                        filterModel.append(SliderFilterValueModel(model: model))
                    }
                }
            }
        }
        self.name = mirror.description
        self.filterModel = filterModel
    }
}

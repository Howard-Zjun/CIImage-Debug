//
//  FilterContentModel.swift
//  CIImage-Debug
//
//  Created by Howard-Zjun on 2024/9/25.
//

import UIKit

protocol FilterContentModelDelegate: NSObjectProtocol {
    
    func outputImgChange(model: FilterContentModel)
}

protocol FilterContentModel {

    var filter: CIFilter { get }
    
    var name: String { get }
    
    var filterModels: [FilterValueModel] { get }
    
    var delegate: FilterContentModelDelegate? { get set }
}

extension FilterContentModel {
    
    func handleSingleSlider(keyName: String, value: CGFloat) {
        filter.setValue(value, forKey: keyName)
    }
}


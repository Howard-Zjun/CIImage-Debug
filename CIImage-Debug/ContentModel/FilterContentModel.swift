//
//  FilterContentModel.swift
//  CIImage-Debug
//
//  Created by Howard-Zjun on 2024/9/25.
//

import UIKit

protocol FilterContentModel {

    var name: String { get }
    
    var filterModel: [FilterModel] {get set }
}

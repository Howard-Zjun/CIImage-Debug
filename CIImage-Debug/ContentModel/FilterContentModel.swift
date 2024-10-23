//
//  CategoryBlurContentModel.swift
//  CIImage-Debug
//
//  Created by ios on 2024/9/25.
//

import UIKit

protocol FilterContentModelDelegate: NSObjectProtocol {
    
    func outputImgChange(model: FilterContentModel)
}

class FilterContentModel: NSObject {
    
    let filter: CIFilter
    
    let name: String
    
    let filterModels: [FilterValueModel]
    
    var observations: [NSKeyValueObservation] = []
    
    weak var delegate: (any FilterContentModelDelegate)?
    
    private var timer: Timer?
    
    private var keepFlag: Bool = false
    
    init(categoryBlur: CIFilter) {
        self.filter = categoryBlur
        
        var filterModels: [FilterValueModel] = []
        
        var count: UInt32 = 0
        let ivars = class_copyIvarList(categoryBlur.classForCoder, &count)
        for i in 0..<count {
            let ivar = ivars![Int(i)]
            let ivarName = ivar_getName(ivar)
            if let ivarName {
                let name = String(cString: ivarName)
                let value = categoryBlur.value(forKey: name)
                if let cgFloatValue = value as? CGFloat {
                    if let model = STSliderViewModel(name: name, minValue: 0, maxValue: cgFloatValue + 10, thumbValue: cgFloatValue) {
                        filterModels.append(SliderFilterValueModel(model: model))
                    }
                } else if let ciColor = value as? CIColor {
                    
                } else if let point = value as? CGPoint {
                    
                }
                // colorSpace
            }
        }
        self.name = NSStringFromClass(categoryBlur.classForCoder)
        self.filterModels = filterModels
        
        super.init()
        
        var observations: [NSKeyValueObservation] = []

        for model in filterModels {
            if let sliderValueModel = model as? SliderFilterValueModel {
                let observation = sliderValueModel.model.observe(\.thumbValue, options: .new) { [weak self] tmp, change in
                    self?.handleSingleSlider(keyName: tmp.name, value: tmp.thumbValue)
                    
                    self?.notiOutputImgChange()
                }
                observations.append(observation)
            }
        }
        self.observations = observations
    }
    
    deinit {
        for observation in observations {
            observation.invalidate()
        }
        timer?.invalidate()
        timer = nil
    }
    
    func notiOutputImgChange() {
        if timer == nil {
            let timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] tmpTimer in
                guard let self = self else {
                    tmpTimer.invalidate()
                    self?.timer = nil
                    return
                }
                if keepFlag {
                    delegate?.outputImgChange(model: self)
                    keepFlag = false
                } else {
                    tmpTimer.invalidate()
                    self.timer = nil
                }
            }
            RunLoop.current.add(timer, forMode: .common)
            self.timer = timer
            delegate?.outputImgChange(model: self)
        } else {
            keepFlag = true
        }
    }
}

extension FilterContentModel {
    
    func handleSingleSlider(keyName: String, value: CGFloat) {
        filter.setValue(value, forKey: keyName)
    }
}


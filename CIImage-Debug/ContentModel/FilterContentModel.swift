//
//  CategoryBlurContentModel.swift
//  CIImage-Debug
//
//  Created by Howard-Zjun on 2024/9/25.
//

import UIKit

protocol FilterContentModelDelegate: NSObjectProtocol {
    
    func outputImgChange(model: FilterContentModel)
}

protocol SelectProtocol {

    var isSelected: Bool { get set }
}

class FilterContentModel: NSObject, SelectProtocol {
    
    var isSelected: Bool = false
    
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
                var isMatch = true
                if value != nil { // 有值能通过类型识别
                    if let cgFloatValue = value as? CGFloat {
                        if let model = STSliderViewModel(name: name, minValue: 0, maxValue: cgFloatValue + 10, thumbValue: cgFloatValue) {
                            filterModels.append(SliderFilterValueModel(model: model))
                        }
                    } else if let ciColor = value as? CIColor {
                        let model = ColorFilterValueModel(name: name, hue: 0, sat: 0)
                        filterModels.append(model)
                    } else if let point = value as? CGPoint {
                        
                    } else {
                        isMatch = false
                    }
                }
                
                if !isMatch { // 没值通过名称识别
                    if name == "inputMask" {
                        let model = ColorFilterValueModel(name: name, hue: 0, sat: 0)
                        filterModels.append(model)
                    } else if name == "inputCenter" {
                        
                    } else {
                        
                    }
                }
            }
        }
        self.name = NSStringFromClass(categoryBlur.classForCoder)
        self.filterModels = filterModels
        
        super.init()
        
        var observations: [NSKeyValueObservation] = []

        for model in filterModels {
            let keyName = model.name
            if let sliderModel = model as? SliderFilterValueModel {
                let observation = sliderModel.model.observe(\.thumbValue, options: .new) { [weak self] tmp, change in
                    
                    self?.filter.setValue(tmp.thumbValue, forKey: keyName)
                    
                    self?.notiOutputImgChange()
                }
                observations.append(observation)
            } else if let colorModel = model as? ColorFilterValueModel {
                let observation1 = colorModel.model.observe(\.hue, options: .new) { [weak self] tmp, change in
                    
                    let ciColor = UIColor(hue: tmp.hue, saturation: tmp.sat, brightness: 1, alpha: 1).ciColor
                    self?.filter.setValue(ciColor, forKey: keyName)
                    
                    self?.notiOutputImgChange()
                }
                let observation2 = colorModel.model.observe(\.sat, options: .new) { [weak self] tmp, change in
                    
                    let ciColor = UIColor(hue: tmp.hue, saturation: tmp.sat, brightness: 1, alpha: 1).ciColor
                    self?.filter.setValue(ciColor, forKey: keyName)
                    
                    self?.notiOutputImgChange()
                }
                observations.append(observation1)
                observations.append(observation2)
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

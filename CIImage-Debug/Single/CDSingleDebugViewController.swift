//
//  CDSingleDebugViewController.swift
//  CIImage-Debug
//
//  Created by Howard-Zjun on 2024/9/21.
//

import UIKit
import MyBaseExtension
import CoreImage

let TOP_HEIGHT: CGFloat = UIDevice.current.isiPhoneXMore() ? 44 : 32
let BOTTOM_HEIGHT: CGFloat = UIDevice.current.isiPhoneXMore() ? (49.5+17) : 49

//刘海判断1678233326
extension UIDevice {
    public func isiPhoneXMore() -> Bool {
        var isMore:Bool = false
        if #available(iOS 11.0, *) {
            isMore = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0 > 0.0
        }
        return isMore
    }
}

class CDSingleDebugViewController: UIViewController {

    var curModel: FilterContentModel?
    
    var types: [[CIFilter]] = [
        // CICategoryBlur
        [CIFilter.bokehBlur(), CIFilter.boxBlur(), CIFilter.discBlur(), CIFilter.gaussianBlur(), CIFilter.maskedVariableBlur(), CIFilter.median(), CIFilter.morphologyGradient(), CIFilter.morphologyMaximum(), CIFilter.morphologyMinimum(), CIFilter.morphologyRectangleMaximum(), CIFilter.morphologyRectangleMinimum(), CIFilter.motionBlur(), CIFilter.noiseReduction(), CIFilter.zoomBlur()],
        // CICategoryGradient
//        [CIFilter.gaussianGradient(), CIFilter.hueSaturationValueGradient(), CIFilter.linearGradient(), CIFilter.radialGradient(), CIFilter.smoothLinearGradient()],
//        // CICategorySharpen
//        [CIFilter.sharpenLuminance(), CIFilter.unsharpMask()],
    ]
    
    var dict: [String : FilterContentModel] = [:]
    
    var selectImg: UIImage = .init(named: "default1")! {
        didSet {
            for model in dict.values {
                if let cgImage = selectImg.cgImage  {
                    model.filter.setValue(CIImage(cgImage: cgImage), forKey: "inputImage")
                }
            }
        }
    }
    
    let context: CIContext = .init(options: nil)
    
    lazy var imgV: UIImageView = {
        let imgV = UIImageView(frame: .init(x: 0, y: TOP_HEIGHT, width: view.kwidth, height: 300))
        imgV.image = selectImg
        return imgV
    }()
    
    lazy var debugTableView: UITableView = {
        let debugTableView = UITableView(frame: .init(x: 0, y: imgV.kmaxY, width: view.kwidth, height: styleCollectionView.kminY - imgV.kmaxY), style: .grouped)
        debugTableView.delegate = self
        debugTableView.dataSource = self
        debugTableView.register(SliderCell.self)
        debugTableView.register(ColorPickerCell.self)
        debugTableView.separatorStyle = .none
        if #available(iOS 15.0, *) {
            debugTableView.sectionHeaderTopPadding = 0
        } else {
            if #available(iOS 11.0, *) {
                debugTableView.contentInsetAdjustmentBehavior = .never
            } else {
                self.automaticallyAdjustsScrollViewInsets = false;
            }
        }
        return debugTableView
    }()
    
    lazy var styleCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 100, height: 50)
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .horizontal
        let styleCollectionView = UICollectionView(frame: .init(x: 0, y: view.kheight - 49 - 30 - 50, width: view.kwidth, height: 50), collectionViewLayout: layout)
        styleCollectionView.delegate = self
        styleCollectionView.dataSource = self
        styleCollectionView.register(CDStyleCell.self)
        return styleCollectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(imgV)
        view.addSubview(debugTableView)
        view.addSubview(styleCollectionView)
    }
    
    func resolver(filter: CIFilter) -> FilterContentModel {
        let str = NSStringFromClass(filter.classForCoder)
        var ret = dict[str]
        if let ret {
            return ret
        }
        ret = FilterContentModel(categoryBlur: filter)
        if let cgImage = selectImg.cgImage {
            filter.setValue(CIImage(cgImage: cgImage), forKey: "inputImage")
        }
        ret?.delegate = self
        dict[str] = ret
        return ret!
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension CDSingleDebugViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        curModel?.filterModels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let curModel else {
            return .init()
        }
        let valueModel = curModel.filterModels[indexPath.section]
        if let sliderModel = valueModel as? SliderFilterValueModel {
            let cell = tableView.dequeueReusableCell(SliderCell.self, indexPath: indexPath)
            cell.filterModel = sliderModel
            cell.selectionStyle = .none
            return cell
        } else if let colorModel = valueModel as? ColorFilterValueModel {
            let cell = tableView.dequeueReusableCell(ColorPickerCell.self, indexPath: indexPath)
            cell.filterModel = colorModel
            cell.selectionStyle = .none
            return cell
        }
        return .init()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        10
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension CDSingleDebugViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        types.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        types[section].count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(CDStyleCell.self, indexPath: indexPath)
        let type = types[indexPath.section][indexPath.item]
        let model = resolver(filter: type)
        cell.config(text: model.name, isSelected: model.isSelected)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let type = types[indexPath.section][indexPath.item]
        curModel?.isSelected = false
        let model = resolver(filter: type)
        curModel = model
        curModel?.isSelected = true
        debugTableView.reloadData()
        styleCollectionView.reloadData()
        
        outputImgChange(model: model)
    }
}

// MARK: - FilterContentModelDelegate
extension CDSingleDebugViewController: FilterContentModelDelegate {
    
    func outputImgChange(model: FilterContentModel) {
        guard curModel?.name == model.name else {
            return
        }
        print("\(NSStringFromClass(Self.self)) \(#function) 响应滤镜: \(model.name)")
        if let outputImage = model.filter.outputImage {
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                imgV.image = UIImage(cgImage: cgImage)
            }
        }
    }
}

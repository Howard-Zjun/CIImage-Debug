//
//  CDSingleDebugViewController.swift
//  CIImage-Debug
//
//  Created by Howard-Zjun on 2024/9/21.
//

import UIKit
import MyBaseExtension

class CDSingleDebugViewController: UIViewController {

    var curModel: FilterContentModel?
    
    var types: [[Any.Type]] = [
        [CIBokehBlur.self, CIBoxBlur.self, CIDiscBlur.self, CIGaussianBlur.self, CIMaskedVariableBlur.self, CIMedian.self, CIMorphologyGradient.self, CIMorphologyMaximum.self, CIMorphologyMinimum.self, CIMorphologyRectangleMaximum.self, CIMorphologyRectangleMinimum.self, CIMotionBlur.self, CINoiseReduction.self, CIZoomBlur.self]
    ]
    
    var dict: [String : FilterContentModel] = [:]
    
    lazy var imgV: UIImageView = {
        let imgV = UIImageView(frame: .init(x: 0, y: view.safeAreaInsets.top, width: view.kwidth, height: 300))
        return imgV
    }()
    
    lazy var debugTableView: UITableView = {
        let debugTableView = UITableView(frame: .init(x: 0, y: imgV.kmaxY, width: view.kwidth, height: styleCollectionView.kminY - view.safeAreaInsets.top))
        debugTableView.delegate = self
        debugTableView.dataSource = self
        debugTableView.register(SliderCell.self)
        debugTableView.separatorStyle = .none
        return debugTableView
    }()
    
    lazy var styleCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 100, height: 150)
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .horizontal
        let styleCollectionView = UICollectionView(frame: .init(x: 0, y: view.kheight - view.safeAreaInsets.bottom - 150, width: view.kwidth, height: 150), collectionViewLayout: layout)
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
    
    func resolver(filter: CIFilterProtocol.Type) -> FilterContentModel {
        let str = String(describing: filter)
        var ret = dict[str]
        if let ret {
            return ret
        }
        ret = CategoryBlurContentModel(categoryBlur: filter)
        dict[str] = ret
        return ret!
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension CDSingleDebugViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        curModel?.filterModel.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let curModel else {
            return .init()
        }
        let valueModel = curModel.filterModel[indexPath.row]
        if let sliderValueModel = valueModel as? SliderFilterValueModel {
            let cell = tableView.dequeueReusableCell(SliderCell.self, indexPath: indexPath)
            cell.filterModel = sliderValueModel
            return cell
        }
        return .init()
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
        let model = resolver(filter: type as! any CIFilterProtocol.Type)
        if let categoryBlurModel = model as? CategoryBlurContentModel {
            cell.config(img: nil, text: model.name)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let type = types[indexPath.section][indexPath.item]
        let model = resolver(filter: type as! any CIFilterProtocol.Type)
        curModel = model
        debugTableView.reloadData()
    }
}

//
//  ColorPickerCell.swift
//  CIImage-Debug
//
//  Created by Howard-Zjun on 2024/10/26.
//

import UIKit
import MyControlView

class ColorPickerCell: UITableViewCell {

    var filterModel: ColorFilterValueModel! {
        didSet {
            pickerColorView.model = filterModel.model
        }
    }
    
    lazy var pickerColorView: MYHSBColorPickerView = {
        let colorPickerView = MYHSBColorPickerView(x: 0, y: 0, width: kwidth * 0.7)
        return colorPickerView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.addSubview(pickerColorView)
        pickerColorView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.center.equalToSuperview()
            make.size.equalTo(kwidth * 0.7)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

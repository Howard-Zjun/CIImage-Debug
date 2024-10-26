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
        let colorPickerView = MYHSBColorPickerView(x: 0, y: 0, width: kheight)
        return colorPickerView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(pickerColorView)
        pickerColorView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(kheight)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

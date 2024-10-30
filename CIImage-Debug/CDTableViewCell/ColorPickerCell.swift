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
            nameLab.text = filterModel.name
            pickerColorView.model = filterModel.model
        }
    }
    
    lazy var nameLab: UILabel = {
        let nameLab = UILabel(frame: .init(x: 0, y: 0, width: contentView.kwidth, height: 15))
        nameLab.font = .systemFont(ofSize: 15)
        nameLab.textColor = .black
        nameLab.textAlignment = .left
        return nameLab
    }()
    
    lazy var pickerColorView: MYHSBColorPickerView = {
        let colorPickerView = MYHSBColorPickerView(x: 0, y: 0, width: kwidth * 0.7)
        return colorPickerView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.addSubview(nameLab)
        contentView.addSubview(pickerColorView)
        nameLab.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(15)
        }
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

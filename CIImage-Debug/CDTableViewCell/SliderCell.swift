//
//  SliderCell.swift
//  CIImage-Debug
//
//  Created by Howard-Zjun on 2024/9/25.
//

import UIKit
import MyControlView
import SnapKit

class SliderCell: UITableViewCell {

    var filterModel: SliderFilterValueModel! {
        didSet {
            sliderView.model = filterModel.model
        }
    }
    
    lazy var nameLab: UILabel = {
        let nameLab = UILabel(frame: .init(x: 0, y: 0, width: contentView.kwidth, height: 15))
        nameLab.font = .systemFont(ofSize: 15)
        nameLab.textColor = .black
        nameLab.textAlignment = .left
        return nameLab
    }()
    
    lazy var sliderView: STSliderView = {
        let sliderView = STSliderView(frame: .init(x: 10, y: 0, width: kwidth - 20, height: 60))
        return sliderView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.addSubview(nameLab)
        contentView.addSubview(sliderView)
        nameLab.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(15)
        }
        sliderView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(10)
            make.top.bottom.equalToSuperview()
            make.height.equalTo(60)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

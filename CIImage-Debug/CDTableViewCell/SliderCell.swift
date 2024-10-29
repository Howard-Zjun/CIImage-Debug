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
    
    lazy var sliderView: STSliderView = {
        let sliderView = STSliderView(frame: .init(x: 10, y: 0, width: kwidth - 20, height: 60))
        return sliderView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.addSubview(sliderView)
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

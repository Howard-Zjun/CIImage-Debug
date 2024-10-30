//
//  PickerImageCell.swift
//  CIImage-Debug
//
//  Created by ios on 2024/10/30.
//

import UIKit
import MyBaseExtension
import Photos

class PickerImageCell: UITableViewCell {

    var manager: DFPickerPhotoManager?
    
    // MARK: - view
    var filterModel: PickerImageFilterValueModel! {
        didSet {
            nameLab.text = filterModel.name
            img.image = filterModel.img
        }
    }
    
    lazy var nameLab: UILabel = {
        let nameLab = UILabel(frame: .init(x: 0, y: 0, width: contentView.kwidth, height: 15))
        nameLab.font = .systemFont(ofSize: 15)
        nameLab.textColor = .black
        nameLab.textAlignment = .left
        return nameLab
    }()
    
    lazy var img: UIImageView = {
        let img = UIImageView(frame: .init(x: (contentView.kwidth - 100) * 0.5, y: (contentView.kheight - 100) * 0.5, width: 100, height: 100))
        return img
    }()
    
    lazy var pickerBtn: UIButton = {
        let pickerBtn = UIButton(frame: .init(x: (contentView.kwidth - 100) * 0.5, y: img.kmaxY + 10, width: 100, height: 45))
        pickerBtn.setTitle("选择图片", for: .normal)
        pickerBtn.setTitleColor(.black, for: .normal)
        pickerBtn.addTarget(self, action: #selector(touchPickerBtn), for: .touchUpInside)
        return pickerBtn
    }()
    
    // MARK: - life time
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.addSubview(nameLab)
        contentView.addSubview(img)
        contentView.addSubview(pickerBtn)
        nameLab.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(15)
        }
        img.snp.makeConstraints { make in
            make.centerX.top.equalToSuperview()
            make.size.equalTo(100)
        }
        pickerBtn.snp.makeConstraints { make in
            make.centerX.bottom.equalToSuperview()
            make.size.equalTo(CGSize(width: 100, height: 45))
            make.top.equalTo(img.snp.bottom).offset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - target
    @objc func touchPickerBtn() {
        manager = DFPickerPhotoManager { [weak self] any in
            guard let self = self else { return }
            if let item = any as? UIImage {
                img.image = item
                filterModel.img = item
            }
        }
        manager?.isPickerImage = true
        manager?.selectPhotoAfterRequestPremission()
    }
}

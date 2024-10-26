//
//  CDStyleCell.swift
//  CIImage-Debug
//
//  Created by Howard-Zjun on 2024/9/21.
//

import UIKit
import MyBaseExtension

class CDStyleCell: UICollectionViewCell {
    
    // MARK: - view
    lazy var lab: UILabel = {
        let lab = UILabel(frame: .init(x: 0, y: 0, width: kwidth, height: kheight))
        lab.font = .systemFont(ofSize: 14)
        lab.textColor = .black
        lab.textAlignment = .center
        lab.numberOfLines = 0
        return lab
    }()
    
    // MARK: - life time
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(lab)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(text: String, isSelected: Bool) {
        lab.text = text
        lab.textColor = .init(hex: isSelected ? 0x329AFF : 0x000000)
    }
}

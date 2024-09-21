//
//  CDStyleCell.swift
//  CIImage-Debug
//
//  Created by ios on 2024/9/21.
//

import UIKit

class CDStyleCell: UICollectionViewCell {
    
    // MARK: - view
    lazy var imgV: UIImageView = {
        let imgV = UIImageView(frame: .init(x: 0, y: 0, width: kwidth, height: 100))
        return imgV
    }()
    
    lazy var lab: UILabel = {
        let lab = UILabel(frame: .init(x: 0, y: imgV.kmaxY + (kheight - imgV.kmaxY - 20) * 0.5, width: kwidth, height: 20))
        lab.font = .systemFont(ofSize: 14)
        lab.textColor = .black
        lab.textAlignment = .center
        lab.numberOfLines = 0
        return lab
    }()
    
    // MARK: - life time
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(img: UIImage, text: String) {
        imgV.image = img
        lab.text = text
    }
}

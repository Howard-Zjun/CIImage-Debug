//
//  CDSingleDebugViewController.swift
//  CIImage-Debug
//
//  Created by ios on 2024/9/21.
//

import UIKit

class CDSingleDebugViewController: UIViewController {

    lazy var debugTableView: UITableView = {
        let debugTableView = UITableView(frame: .init(x: 0, y: view.safeAreaInsets.top, width: view.kwidth, height: styleCollectionView.kminY - view.safeAreaInsets.top))
        debugTableView.delegate = self
        debugTableView.dataSource = self
        debugTableView.register(<#T##cellType: T.Type##T.Type#>)
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
        view.addSubview(debugTableView)
        view.addSubview(styleCollectionView)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension CDSingleDebugViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension CDSingleDebugViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(CDStyleCell.self, indexPath: indexPath)
        cell.config(img: <#T##UIImage#>, text: <#T##String#>)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        <#code#>
    }
}

//
//  BaseCollectionViewCell.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 17.12.2021.
//

import UIKit

open class BaseCollectionViewCell<Data>: UICollectionViewCell {

    open func setData(_ data: Data) {}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupComponents()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupComponents() {}
}

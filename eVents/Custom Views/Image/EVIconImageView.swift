//
//  EVIconImageView.swift
//  eVents
//
//  Created by Kartikeya Saxena Jain on 6/25/20.
//  Copyright © 2020 com.devKrey. All rights reserved.
//

import UIKit

class EVIconImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure()  {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius          = 5
    }
}

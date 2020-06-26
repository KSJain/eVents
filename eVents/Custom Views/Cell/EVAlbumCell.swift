//
//  EVAlbumCell.swift
//  eVents
//
//  Created by Kartikeya Saxena Jain on 6/25/20.
//  Copyright © 2020 com.devKrey. All rights reserved.
//

import UIKit

class EVAlbumCell: UITableViewCell {
    
    static let reuseID  = "eventCell"
    var timeIcon        = EVIconImageView(frame: .zero)
    var eventTitle      = EVTitleLabel(textAlignment: .left, fontSize: 18)
    var startTime      = EVSecondaryTitleLabel(fontSize: 15)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCell(with viewModel: EventViewModel) {
        let iconName        = viewModel.conflict ? "exclamationmark.triangle.fill" : "\(viewModel.iconName).circle"
        timeIcon.image      = UIImage(systemName: iconName)
        eventTitle.text     = viewModel.title
        let timeText        = "Start: \(viewModel.startHour)   End: \(viewModel.endHour)"
        startTime.text      = timeText
    }
    
    private func configure() {
        let padding: CGFloat        = 8
        let imageSize: CGFloat      = 100
        eventTitle.numberOfLines    = 2
        
        [timeIcon, eventTitle, startTime].forEach { addSubview($0) }
        
        NSLayoutConstraint.activate([
            timeIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            timeIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            timeIcon.heightAnchor.constraint(equalToConstant: imageSize),
            timeIcon.widthAnchor.constraint(equalToConstant: imageSize),

            eventTitle.topAnchor.constraint(equalTo: self.topAnchor),
            eventTitle.leadingAnchor.constraint(equalTo: timeIcon.trailingAnchor, constant: padding),
            eventTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -18),
            eventTitle.heightAnchor.constraint(equalToConstant: 80),

            startTime.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30),
            startTime.leadingAnchor.constraint(equalTo: timeIcon.trailingAnchor, constant: padding),
            startTime.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            startTime.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}

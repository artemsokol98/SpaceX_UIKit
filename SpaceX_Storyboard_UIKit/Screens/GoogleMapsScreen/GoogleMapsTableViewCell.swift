//
//  GoogleMapsTableViewCell.swift
//  SpaceX_Storyboard_UIKit
//
//  Created by Артем Соколовский on 11.10.2022.
//

import UIKit

class GoogleMapsTableViewCell: UITableViewCell {
    
    static let identifier = "GoogleMapsTableViewCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.googleMapFontHelvetica, size: 15)
        label.numberOfLines = 3
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addConstraint(
            NSLayoutConstraint(item: label,
                               attribute: .leading,
                               relatedBy: .equal,
                               toItem: contentView,
                               attribute: .leading,
                               multiplier: 1.0,
                               constant: contentView.frame.width / 20)
        )
        
        contentView.addConstraint(
            NSLayoutConstraint(item: label,
                               attribute: .trailing,
                               relatedBy: .greaterThanOrEqual,
                               toItem: contentView,
                               attribute: .trailing,
                               multiplier: 1.0,
                               constant: 0)
        )
        
        contentView.addConstraint(
            NSLayoutConstraint(item: label,
                               attribute: .centerY,
                               relatedBy: .equal,
                               toItem: contentView,
                               attribute: .centerY,
                               multiplier: 1.0,
                               constant: 0)
        )

    }
    
    func configure(text: String) {
        self.label.text = text
    }

}

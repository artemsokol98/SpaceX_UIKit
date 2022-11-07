//
//  LaunchesTableViewCell.swift
//  SpaceX_Storyboard_UIKit
//
//  Created by Артем Соколовский on 23.09.2022.
//

import UIKit

class LaunchesTableViewCell: UITableViewCell {
    
    static let identifier = "LaunchesTableViewCell"

    private let stackView = UIStackView()
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let secondaryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    
    private let rightImage = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(stackView)
        contentView.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        contentView.addConstraint(
            NSLayoutConstraint(item: stackView,
                               attribute: .leading,
                               relatedBy: .equal,
                               toItem: contentView,
                               attribute: .leading,
                               multiplier: 1.0,
                               constant: contentView.bounds.width * 0.1)
        )
        
        contentView.addConstraint(
            NSLayoutConstraint(item: stackView,
                               attribute: .centerY,
                               relatedBy: .equal,
                               toItem: contentView,
                               attribute: .centerY,
                               multiplier: 1.0,
                               constant: 0)
        )
        
        contentView.addConstraint(
            NSLayoutConstraint(item: stackView,
                               attribute: .height,
                               relatedBy: .equal,
                               toItem: contentView,
                               attribute: .height,
                               multiplier: 0.5,
                               constant: 0)
        )
        
        contentView.addConstraint(
            NSLayoutConstraint(item: stackView,
                               attribute: .trailing,
                               relatedBy: .lessThanOrEqual,
                               toItem: contentView,
                               attribute: .trailing,
                               multiplier: 1.0,
                               constant: contentView.bounds.width * 0.4)
        )
        
        stackView.addArrangedSubview(mainLabel)
        stackView.addArrangedSubview(secondaryLabel)
        
    }
    
    func configure(with info: LaunchesViewModel) {
        mainLabel.text = info.name
        secondaryLabel.text = info.date
    }
}

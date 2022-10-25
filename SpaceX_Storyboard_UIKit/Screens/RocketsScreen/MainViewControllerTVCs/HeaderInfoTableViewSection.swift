//
//  HeaderInfoTableViewSection.swift
//  SpaceX_Storyboard_UIKit
//
//  Created by Артем Соколовский on 09.09.2022.
//

import UIKit

class HeaderInfoTableViewSection: UITableViewHeaderFooterView {
    static let identifier = "HeaderInfoTableViewSection"
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .black
        contentView.addSubview(label)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addConstraint(NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1.0, constant: contentView.bounds.width * 0.1))
        contentView.addConstraint(NSLayoutConstraint(item: label, attribute: .trailing, relatedBy: .lessThanOrEqual, toItem: contentView, attribute: .trailing, multiplier: 1.0, constant: contentView.bounds.width * 0.1))
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func configure(with string: String) {
        label.text = string
    }

}

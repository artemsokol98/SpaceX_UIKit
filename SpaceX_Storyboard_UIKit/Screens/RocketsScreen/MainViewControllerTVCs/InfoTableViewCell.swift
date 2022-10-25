//
//  InfoTableViewCell.swift
//  SpaceX_Storyboard_UIKit
//
//  Created by Артем Соколовский on 07.09.2022.
//

import UIKit

class InfoTableViewCell: UITableViewCell {
    static let identifier = "InfoTableViewCell"
    private let leftLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    private let rightLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .black
        contentView.addSubview(leftLabel)
        contentView.addSubview(rightLabel)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        leftLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addConstraint(
            NSLayoutConstraint(item: leftLabel,
                               attribute: .leading,
                               relatedBy: .equal,
                               toItem: contentView,
                               attribute: .leading,
                               multiplier: 1,
                               constant: contentView.bounds.width * 0.1))
        leftLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        leftLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        rightLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addConstraint(
            NSLayoutConstraint(item: rightLabel,
                               attribute: .trailing,
                               relatedBy: .equal,
                               toItem: contentView,
                               attribute: .trailing,
                               multiplier: 1,
                               constant: -contentView.bounds.width * 0.1))
        rightLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        rightLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    func configure(viewModel: MainInfoTVCModel) {
        leftLabel.text = viewModel.description
        rightLabel.text = viewModel.value
    }

}

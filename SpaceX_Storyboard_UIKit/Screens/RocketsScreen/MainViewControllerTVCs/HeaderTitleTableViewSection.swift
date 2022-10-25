//
//  HeaderTitleTableViewSection.swift
//  SpaceX_Storyboard_UIKit
//
//  Created by Артем Соколовский on 09.09.2022.
//

import UIKit

protocol HeaderTitleCellDelegate {
    func settingsButtonDidPressed()
}

class HeaderTitleTableViewSection: UITableViewHeaderFooterView {

    static let identifier = "HeaderTitleTableViewSection"
    var headerTitleButtonCellDelegate: HeaderTitleCellDelegate?
    private lazy var leftLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    private lazy var rightButton: UIButton = {
        let button = UIButton()
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .medium)
        let SFSymbol = UIImage(systemName: "gearshape", withConfiguration: symbolConfiguration)
        button.setImage(SFSymbol, for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(settingsButtonPressed), for: .touchUpInside)
        return button
    }()
    
    @objc func settingsButtonPressed() {
        headerTitleButtonCellDelegate?.settingsButtonDidPressed()
        print("button pressed")
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .black
        contentView.addSubview(leftLabel)
        contentView.addSubview(rightButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        leftLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addConstraint(NSLayoutConstraint(item: leftLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: contentView.bounds.width * 0.1))
        leftLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        leftLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addConstraint(NSLayoutConstraint(item: rightButton, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -contentView.bounds.width * 0.1))
        rightButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        rightButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    func configure(with title: String) {
        leftLabel.text = title
    }
}

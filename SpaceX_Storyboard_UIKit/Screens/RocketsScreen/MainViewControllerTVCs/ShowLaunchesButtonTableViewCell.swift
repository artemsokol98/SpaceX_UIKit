//
//  ShowLaunchesButtonTableViewCell.swift
//  SpaceX_Storyboard_UIKit
//
//  Created by Артем Соколовский on 09.09.2022.
//

import UIKit

protocol ShowLaunchesButtonCellDelegate {
    func didPressButton()
}

class ShowLaunchesButtonTableViewCell: UITableViewCell {
    static let identifier = "ShowLaunchesButtonTableViewCell"
    
    var showLaunchesButtonCellDelegate: ShowLaunchesButtonCellDelegate?
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .orange
        button.layer.cornerRadius = 10
        button.setTitle("Go to launches", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    @objc func buttonPressed() {
        showLaunchesButtonCellDelegate?.didPressButton()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .black
        contentView.addSubview(button)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        button.translatesAutoresizingMaskIntoConstraints = false
        contentView.addConstraint(
            NSLayoutConstraint(item: button,
                               attribute: .centerX,
                               relatedBy: .equal,
                               toItem: contentView,
                               attribute: .centerX,
                               multiplier: 1.0,
                               constant: 0)
        )
        contentView.addConstraint(
            NSLayoutConstraint(item: button,
                               attribute: .centerY,
                               relatedBy: .equal,
                               toItem: contentView,
                               attribute: .centerY,
                               multiplier: 1.0,
                               constant: 0)
        )
        contentView.addConstraint(
            NSLayoutConstraint(item: button,
                               attribute: .width,
                               relatedBy: .equal,
                               toItem: contentView,
                               attribute: .width,
                               multiplier: 0.5,
                               constant: 0)
        )
        contentView.addConstraint(
            NSLayoutConstraint(item: button,
                               attribute: .height,
                               relatedBy: .equal,
                               toItem: contentView,
                               attribute: .height,
                               multiplier: 0.8,
                               constant: 0)
        )
    }
}

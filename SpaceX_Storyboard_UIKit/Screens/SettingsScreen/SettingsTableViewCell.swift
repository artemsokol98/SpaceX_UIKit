//
//  SettingsTableViewCell.swift
//  SpaceX_Storyboard_UIKit
//
//  Created by Артем Соколовский on 24.09.2022.
//

import UIKit

protocol SegmentedControlDelegate {
    func segmentedControlValueChanged(SCIndex: Int, label: String)
}

class SettingsTableViewCell: UITableViewCell {
    
    static let identifier = "SettingsTableViewCell"

    var segmentedControlValueChangedDelegate: SegmentedControlDelegate?
    
    private lazy var leftLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    
    private lazy var rightSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.backgroundColor = .gray
        segmentedControl.selectedSegmentTintColor = .white
        segmentedControl.addTarget(self, action: #selector(segmetedControlValueChanged(_:)), for: .valueChanged)
        return segmentedControl
    }()
    
    @objc func segmetedControlValueChanged(_ sender: UISegmentedControl) {
        guard let keyForUD = self.leftLabel.text else { return }
        segmentedControlValueChangedDelegate?.segmentedControlValueChanged(SCIndex: sender.selectedSegmentIndex, label: keyForUD)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(leftLabel)
        contentView.addSubview(rightSegmentedControl)
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
                               multiplier: 1.0,
                               constant: contentView.frame.width * 0.1)
        )
        contentView.addConstraint(
            NSLayoutConstraint(item: leftLabel,
                               attribute: .centerY,
                               relatedBy: .equal,
                               toItem: contentView,
                               attribute: .centerY,
                               multiplier: 1.0,
                               constant: 0)
        )
        contentView.addConstraint(
            NSLayoutConstraint(item: leftLabel,
                               attribute: .width,
                               relatedBy: .greaterThanOrEqual,
                               toItem: contentView,
                               attribute: .width,
                               multiplier: 0.5,
                               constant: 0)
        )
        rightSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        contentView.addConstraint(
            NSLayoutConstraint(item: rightSegmentedControl,
                               attribute: .trailing,
                               relatedBy: .equal,
                               toItem: contentView,
                               attribute: .trailing,
                               multiplier: 1.0,
                               constant: -contentView.frame.width * 0.1)
        )
        contentView.addConstraint(
            NSLayoutConstraint(item: rightSegmentedControl,
                               attribute: .centerY,
                               relatedBy: .equal,
                               toItem: contentView,
                               attribute: .centerY,
                               multiplier: 1.0,
                               constant: 0)
        )
        contentView.addConstraint(
            NSLayoutConstraint(item: rightSegmentedControl,
                               attribute: .width,
                               relatedBy: .equal,
                               toItem: contentView,
                               attribute: .width,
                               multiplier: 0.3,
                               constant: 0)
        )
    }

    func configure(infoForSegmentedControl: ReturnedCurrentSetting) {
        self.leftLabel.text = infoForSegmentedControl.label
        for (index, item) in infoForSegmentedControl.descriptions.enumerated() {
            self.rightSegmentedControl.insertSegment(
                withTitle: item,
                at: index,
                animated: true
            )
        }
        self.rightSegmentedControl.selectedSegmentIndex = infoForSegmentedControl.currentSetting
    }
    
}

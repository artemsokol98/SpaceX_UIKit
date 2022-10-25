//
//  TileCollectionViewCell.swift
//  SpaceX_Storyboard_UIKit
//
//  Created by Артем Соколовский on 09.09.2022.
//

import UIKit

class TileCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TileCollectionViewCell"
    
    private let stackView = UIStackView()
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let secondaryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 17, weight: .light)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(stackView)
        contentView.layer.cornerRadius = contentView.bounds.width * 0.3
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = contentView.bounds
        stackView.axis = .vertical

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: stackView.bounds.height * 0.3).isActive = true
                stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -stackView.bounds.height * 0.3).isActive = true
                stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true

        stackView.addArrangedSubview(mainLabel)
        stackView.addArrangedSubview(secondaryLabel)
    }
    
    func configure(with viewModel: TileCollectionViewCellViewModel, unit: ReturnedCurrentSetting) {
        contentView.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        mainLabel.text = viewModel.secondaryLabel
        secondaryLabel.text = viewModel.label + ", " + unit.descriptions[unit.currentSetting]
        secondaryLabel.numberOfLines = 0
        
    }
}

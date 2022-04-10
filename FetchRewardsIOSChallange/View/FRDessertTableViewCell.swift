//
//  FRDessertTableViewCell.swift
//  FetchRewardsIOSChallange
//
//  Created by Emre Yasa on 4/8/22.
//

import UIKit

class FRDessertTableViewCell: UITableViewCell {

    static let reusId = "FRDessertTableViewCell"
    
    private let dessertTitle:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 22, weight: .regular)
        return label
    }()
    
    private let dessertImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .secondarySystemBackground
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(dessertTitle)
        contentView.addSubview(dessertImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpConstraintsDessertImageView()
        setUpConstraintsDessertTitle()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dessertTitle.text = nil
        dessertImageView.image = nil
    }
    
    func setUpConstraintsDessertImageView() {
        dessertImageView.translatesAutoresizingMaskIntoConstraints = false
        dessertImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        dessertImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        dessertImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        dessertImageView.widthAnchor.constraint(equalTo: dessertImageView.heightAnchor, multiplier:  1).isActive = true
    }
    
    func setUpConstraintsDessertTitle() {
        dessertTitle.translatesAutoresizingMaskIntoConstraints = false
        dessertTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        dessertTitle.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        dessertTitle.trailingAnchor.constraint(equalTo: dessertImageView.leadingAnchor, constant: 20).isActive = true
        dessertTitle.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
 
    }
    
    func configure(with viewModel:FRDessertTVCellViewModel) {
        dessertTitle.text = viewModel.title
        
        if let data = viewModel.imageData {
            dessertImageView.image = UIImage(data: data)
        } else if let url = viewModel.imageURL {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.dessertImageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
}

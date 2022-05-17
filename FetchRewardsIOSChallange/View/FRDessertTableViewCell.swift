//
//  FRDessertTableViewCell.swift
//  FetchRewardsIOSChallange
//
//  Created by Emre Yasa on 4/8/22.
//

import UIKit

class FRDessertTableViewCell: UITableViewCell {
    static let reusId = "FRDessertTableViewCell"
    
    private lazy var dessertTitle:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 22, weight: .regular)
        return label
    }()
    
    private lazy var dessertImageView:UIImageView = {
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
        setUpConstraintsDessertImageView()
        setUpConstraintsDessertTitle()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUpConstraintsDessertImageView() {
        dessertImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dessertImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            dessertImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            dessertImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            dessertImageView.widthAnchor.constraint(equalTo: dessertImageView.heightAnchor, multiplier:  1)
        ])
    }
    
    private func setUpConstraintsDessertTitle() {
        dessertTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dessertTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            dessertTitle.centerYAnchor.constraint(equalTo: centerYAnchor),
            dessertTitle.centerYAnchor.constraint(equalTo: centerYAnchor),
            dessertTitle.trailingAnchor.constraint(equalTo: dessertImageView.leadingAnchor, constant: 20),
            dessertTitle.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
    }
    
    //Set the fetched desserts to the view with viewModel design pattern
    //why I make network request here is we do not handle the errors in the fetching operation
    //Although it is not super applicable to SOLID principle, here in this function we do not strictly need parsing error and handling all the errors in this function.
    //However, if my supervisor or team think that it violates organisation of code, I am happy to make networking operation
    //in the network manager. I would be happy to be part of the team consensus.
    func configure(with viewModel:FRDessertCellViewModel) {
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

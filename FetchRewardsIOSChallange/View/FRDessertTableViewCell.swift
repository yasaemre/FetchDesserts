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
        label.font = .systemFont(ofSize: 22, weight: .medium)
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
        dessertTitle.frame = CGRect(x: 10, y: 0, width: contentView.frame.size.width - 120, height: contentView.frame.size.height / 2)
        
        dessertImageView.frame = CGRect(x: contentView.frame.size.width-160, y: 5, width: 190, height: contentView.frame.size.height - 10)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dessertTitle.text = nil
        dessertImageView.image = nil
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

//
//  FRDetailView.swift
//  FetchRewardsIOSChallange
//
//  Created by Emre Yasa on 4/8/22.
//

import UIKit

class FRDetailView: UIView {
    var mealID:Int = 0
    
    private lazy var dessertImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private lazy var ingredientsLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private lazy var instructionsLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.9
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemBackground
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .systemBackground
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = true
        configureSubviews()
        setupConstraints()
        setUpConstraintsDessertImageView()
        setUpConstraintsIngredientsLabel()
        setUpConstraintsInstructionsLabel()
    }
    
    private func configureSubviews() {
        self.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(dessertImageView)
        stackView.addArrangedSubview(ingredientsLabel)
        stackView.addArrangedSubview(instructionsLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.rightAnchor.constraint(equalTo: self.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: self.leftAnchor)
        ])
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor)
        ])
    }
    
    func setUpConstraintsDessertImageView() {
        NSLayoutConstraint.activate([
            dessertImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dessertImageView.heightAnchor.constraint(equalToConstant: self.frame.height / 3),
            dessertImageView.widthAnchor.constraint(equalToConstant: self.frame.height / 3)
        ])
        
    }
    
    func setUpConstraintsIngredientsLabel() {
        NSLayoutConstraint.activate([
            ingredientsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            ingredientsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    func setUpConstraintsInstructionsLabel() {
        NSLayoutConstraint.activate([
            instructionsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            instructionsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    func configure(with viewModel:[FRDetailByIdViewModel]) {
        instructionsLabel.text = viewModel.first?.instructions
        ingredientsLabel.text = viewModel.first?.ingredients
        
        if let data = viewModel.first?.imageData {
            dessertImageView.image = UIImage(data: data)
        } else if let url = viewModel.first?.imageURL {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                viewModel.first?.imageData = data
                DispatchQueue.main.async {
                    self?.dessertImageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
}

//
//  FRDetailView.swift
//  FetchRewardsIOSChallange
//
//  Created by Emre Yasa on 4/8/22.
//

import UIKit

class FRDetailView: UIView {
    var mealID:Int = 0
    
    
    lazy var dessertImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    lazy var instructionsLabel:UILabel = {
        let label = UILabel()
        label.text = "No instructions"
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.9
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private lazy var instructionsTitleLabel:UILabel = {
        let label = UILabel()
        label.text = "Instructions:"
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.9
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private lazy var ingredientsTitleLabel:UILabel = {
        let label = UILabel()
        label.text = "Ingredients: "
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    lazy var ingredientsLabel:UILabel = {
        let label = UILabel()
        label.text = "Dummy text"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .regular)
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
        stackView.spacing = 5
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
        stackView.addArrangedSubview(ingredientsTitleLabel)
        stackView.addArrangedSubview(ingredientsLabel)
        stackView.addArrangedSubview(instructionsTitleLabel)
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
        dessertImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        dessertImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        dessertImageView.heightAnchor.constraint(equalToConstant: self.frame.height / 3).isActive = true
        dessertImageView.widthAnchor.constraint(equalToConstant: self.frame.height / 3).isActive = true
    }
    
    func setUpConstraintsIngredientsLabel() {
        ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        ingredientsLabel.topAnchor.constraint(equalTo: ingredientsTitleLabel.topAnchor, constant: 20).isActive = true
    }
    
    func setUpConstraintsInstructionsLabel() {
        instructionsLabel.translatesAutoresizingMaskIntoConstraints = false
        instructionsLabel.topAnchor.constraint(equalTo: instructionsTitleLabel.bottomAnchor, constant: 10).isActive = true
        instructionsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        instructionsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
    }
    
    
    
    func setUpView() {
        self.addSubview(dessertImageView)
        self.addSubview(scrollView)
        scrollView.addSubview(instructionsLabel)
        scrollView.addSubview(ingredientsLabel)
    }
    
    func configure(with viewModel:FRDetailViewModel) {
        instructionsLabel.text = viewModel.instructions
        ingredientsLabel.text = viewModel.ingredients
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

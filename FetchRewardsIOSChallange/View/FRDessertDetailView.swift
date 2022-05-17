//
//  FRDetailView.swift
//  FetchRewardsIOSChallange
//
//  Created by Emre Yasa on 4/8/22.
//

import UIKit

class FRDessertDetailView: UIView {
    
    lazy var mealID:Int = {
        let mealID = 0
        return mealID
    }()
    
    private lazy var dessertImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private lazy var ingredientsLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    private lazy var instructionsLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.minimumScaleFactor = 0.9
        label.font = .systemFont(ofSize: 18, weight: .light)
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
        setUpConstraintsDessertImageView()
        setUpConstraintsIngredientsLabel()
        setUpConstraintsInstructionsLabel()
        
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
    
    private func setUpConstraintsDessertImageView() {
        NSLayoutConstraint.activate([
            dessertImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dessertImageView.heightAnchor.constraint(equalToConstant: self.frame.height / 3),
            dessertImageView.widthAnchor.constraint(equalToConstant: self.frame.height / 3)
        ])
        
    }
    
    private func setUpConstraintsIngredientsLabel() {
        NSLayoutConstraint.activate([
            ingredientsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            ingredientsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    private func setUpConstraintsInstructionsLabel() {
        NSLayoutConstraint.activate([
            instructionsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            instructionsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    //Set the selected dessert to view with viewModel design pattern
    //why I make network request here is we do not handle the errors in the fetching operation
    //Although it is not super applicable to SOLID principle, here in this function we do not strictly need parsing error and handling all the errors in this function.
    //However, if my supervisor or team think that it violates organisation of code, I am happy to make networking operation
    //in the network manager. I would be happy to be part of the team consensus.
    func configure(with viewModel:[FRDessertDetailViewModel]) {
        if let ingredients = viewModel.first?.ingredients {
            ingredientsLabel.text = "Ingredients: \(ingredients)"
        }
        if let instructions = viewModel.first?.instructions {
            instructionsLabel.text = "Instruction: \(instructions)"
        }
        
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

//
//  FRDetailView.swift
//  FetchRewardsIOSChallange
//
//  Created by Emre Yasa on 4/8/22.
//

import UIKit

class FRDetailView: UIView {

    //static let reusId = "FRDetailView"
     var mealID:Int = 0
     
    
     let dessertImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .darkGray
        imageView.clipsToBounds = true
        imageView.image = UIImage(named:"noFoodFound")!
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
     let instructionsLabel:UILabel = {
        let label = UILabel()
         label.text = "Empty text"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
     let ingredientsLabel:UILabel = {
        let label = UILabel()
         label.text = "Dummy text"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = true
        setUpView()
        setUpConstraintsDessertImageView()
        setUpConstraintsIngredientsLabel()
        setUpConstraintsInstructionsLabel()
    }
    func setUpConstraintsDessertImageView() {
        dessertImageView.translatesAutoresizingMaskIntoConstraints = false
        
        dessertImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        dessertImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        dessertImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        dessertImageView.bottomAnchor.constraint(equalTo: ingredientsLabel.topAnchor, constant: 50).isActive = true
    }
    
    
    func setUpConstraintsIngredientsLabel() {
        ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        ingredientsLabel.topAnchor.constraint(equalTo: dessertImageView.bottomAnchor, constant: 1).isActive = true
       //ingredientsLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
        ingredientsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        ingredientsLabel.topAnchor.constraint(equalTo: dessertImageView.bottomAnchor, constant: 10).isActive = true
        ingredientsLabel.leftAnchor.constraint(equalTo: dessertImageView.leftAnchor, constant: 0).isActive = true
    }
    
    func setUpConstraintsInstructionsLabel() {
        instructionsLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        instructionsLabel.translatesAutoresizingMaskIntoConstraints = false
        instructionsLabel.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: 1).isActive = true
        instructionsLabel.leftAnchor.constraint(equalTo: dessertImageView.leftAnchor, constant: 0).isActive = true
        //instructionsLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
        instructionsLabel.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: 30).isActive = true
        instructionsLabel.leftAnchor.constraint(equalTo: ingredientsLabel.leftAnchor, constant: 0).isActive = true
        instructionsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }
    
    
    
    func setUpView() {
        self.addSubview(dessertImageView)
        self.addSubview(instructionsLabel)
        self.addSubview(ingredientsLabel)
    }
    
    func configure(with viewModel:FRDetailViewModel) {
        instructionsLabel.text = viewModel.instructions
        ingredientsLabel.text = viewModel.ingredients
        print(viewModel.title)
        
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

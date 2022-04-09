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
        //imageView.backgroundColor = .darkGray
        imageView.clipsToBounds = true
        imageView.image = UIImage(named:"noFoodFound")!
         //imageView.alpha = 0.7
        //imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        //imageView.contentMode = .scaleToFill
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
        dessertImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        //dessertImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        //dessertImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10).isActive = true
        dessertImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        dessertImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        dessertImageView.widthAnchor.constraint(equalTo: dessertImageView.heightAnchor, multiplier:  9/9).isActive = true


    }
    
   
    
    
    func setUpConstraintsIngredientsLabel() {
        ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        ingredientsLabel.topAnchor.constraint(equalTo: dessertImageView.bottomAnchor, constant: 10).isActive = true
        ingredientsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        ingredientsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
 
    }
    
    func setUpConstraintsInstructionsLabel() {
        instructionsLabel.translatesAutoresizingMaskIntoConstraints = false
        instructionsLabel.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: 10).isActive = true
        instructionsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        instructionsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
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

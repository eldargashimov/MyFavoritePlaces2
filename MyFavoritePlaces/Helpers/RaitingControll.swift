//
//  RaitingControll.swift
//  MyFavoritePlaces
//
//  Created by Mac on 28.03.2020.
//  Copyright © 2020 Eldar Gashimov. All rights reserved.
//

import UIKit

@IBDesignable class RaitingControll: UIStackView {
// MARK: Properties
    var raiting = 0 {
        didSet {
            updateButtonSelectedStates()
        }
    }
    private var raitingButtons = [UIButton]()
    
    @IBInspectable var sizeButton: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupButtons()
        }
    }
    
    @IBInspectable var buttonCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }
    
// MARK: Inicialisation
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
// MARK: Button Action
    
    @objc func raitingButtonTapped (button: UIButton) {
        
        guard let index = raitingButtons.firstIndex(of: button) else { return }
        
        let selectedRaiting = index + 1
        
        if selectedRaiting == raiting {
            raiting = 0
        } else {
            raiting = selectedRaiting
        }
    }
    
// MARK: Private methods
    private func setupButtons () {
        
        for button in raitingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        
        raitingButtons.removeAll()
        
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlitedStar = UIImage(named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        for _ in 0..<buttonCount {
            // Create the button
            let button = UIButton()
            
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlitedStar, for: .highlighted)
            button.setImage(highlitedStar, for: [.selected,.highlighted])
            
            // Add constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: sizeButton.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: sizeButton.width).isActive = true
            // Setup the button action
            button.addTarget(self, action: #selector(raitingButtonTapped(button:)), for: .touchUpInside)
            // Add button in the stack
            addArrangedSubview(button)
            // Add button in the array
            raitingButtons.append(button)
        }
        
        updateButtonSelectedStates()
    }
    
    private func updateButtonSelectedStates() {
        for (index, button) in raitingButtons.enumerated() {
            button.isSelected = index < raiting
        }
    }

}

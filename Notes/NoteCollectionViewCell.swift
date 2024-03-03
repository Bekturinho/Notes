//
//  NoteCollectionViewCell.swift
//  Notes
//
//  Created by fortune cookie on 3/2/24.
//

import UIKit

class NoteCollectionViewCell: UICollectionViewCell, ChangeTitleDelegate{
    
    func changeTitle(title: String) {
        titleLabel.text = title
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        let view = AddNoteView()
        view.changeDelegate = self
        
        return label
    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        
        ])
    }
    
}


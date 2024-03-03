//
//  NotesInfoViewController.swift
//  Notes
//
//  Created by fortune cookie on 3/2/24.
//

import UIKit

class NotesInfoViewController: UIViewController{
    private lazy var titletextView: UITextView = {
        let text = UITextView()
        text.textColor = .white
        text.backgroundColor = .black
        text.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        text.isEditable = false
        let view = AddNoteView()
        view.teleportInfoDelegate = self
     
        return text
    }()
    private lazy var typeTextView: UITextView = {
        let text = UITextView()
        text.isEditable = false
        text.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        text.backgroundColor = .black
        text.textColor = .white
        text.isEditable = false
   
        return text
    }()
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrowshape.left.fill"), for: .normal)
        button.backgroundColor = .systemGray
        button.tintColor = .white
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
        return button
    }()
    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.backgroundColor = .systemGray
        button.tintColor = .white
        button.addTarget(self, action: #selector(edit), for: .touchUpInside)
        return button
    }()



    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.backgroundColor = .black
        setUpSubViews()
       
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       navigationItem.hidesBackButton = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.titletextView.resignFirstResponder()
        self.typeTextView.resignFirstResponder()
        print(titletextView.text ?? "")
        print(typeTextView.text ?? "")
        
    }
    
    private func setUpSubViews(){
        
        
        view.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backButton.heightAnchor.constraint(equalToConstant: 100),
            backButton.widthAnchor.constraint(equalToConstant: 100)
        
        ])
        backButton.layer.cornerRadius = 12
        
        view.addSubview(editButton)
        editButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            editButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            editButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            editButton.heightAnchor.constraint(equalToConstant: 100),
            editButton.widthAnchor.constraint(equalToConstant: 100)
        
        ])
        editButton.layer.cornerRadius = 12
        
        
        
        view.addSubview(titletextView)
        titletextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titletextView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 50),
            titletextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titletextView.heightAnchor.constraint(equalToConstant: 100),
            titletextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        
            
        ])
        
        view.addSubview(typeTextView)
        typeTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            typeTextView.topAnchor.constraint(equalTo: titletextView.bottomAnchor, constant: 50),
            typeTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            typeTextView.heightAnchor.constraint(equalToConstant: 450),
            typeTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        
        ])
//
        
    }
    @objc func back(){
        navigationController?.popViewController(animated: true)
        
    }
    @objc func edit(){
        titletextView.isEditable = true
        typeTextView.isEditable = true
    }


}

extension NotesInfoViewController: TeleportInfoDelegate{
    func changeInfo(title: String, text: String) {
        typeTextView.text = text
        titletextView.text = title
        
    }
    
    
}

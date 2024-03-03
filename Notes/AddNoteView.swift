//
//  AddNoteView.swift
//  Notes
//
//  Created by fortune cookie on 2/28/24.
//

import UIKit
protocol ViewControllerDelegate{
    func addToNoteArray(note: Notes)
    func addNewNameTitle(title: String)
    
}
protocol ChangeTitleDelegate{
    func changeTitle(title: String)
}
protocol TeleportInfoDelegate{
    func changeInfo(title: String, text: String)
}



class AddNoteView: UIViewController{
    var delegate: ViewControllerDelegate?
    var changeDelegate: ChangeTitleDelegate?
    var teleportInfoDelegate: TeleportInfoDelegate?

    private lazy var titletextView: UITextView = {
        let text = UITextView()
        text.text = "Note"
        text.textColor = .white
        text.backgroundColor = .black
        text.font = UIFont.systemFont(ofSize: 30, weight: .medium)
     
        return text
    }()
    private lazy var typeTextView: UITextView = {
        let text = UITextView()
        text.text = "Type something..."
        text.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        text.backgroundColor = .black
        text.textColor = .white

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
    private lazy var saveButton: UIButton = {
     
        let showAlertAction = UIAction{ _ in
            let alert = UIAlertController(title: "Save Changes?", message: nil, preferredStyle: .alert)
            let saveAction = UIAlertAction(title: "Save", style: .default){_ in
                self.delegate?.addToNoteArray(note: Notes(title: self.titletextView.text, text: self.typeTextView.text))
                self.delegate?.addNewNameTitle(title: self.titletextView.text)
                self.teleportInfoDelegate?.changeInfo(title: self.titletextView.text, text: self.typeTextView.text)
                
            }
            let discardAction = UIAlertAction(title: "Discard", style: .destructive){_ in
                self.titletextView.text = "Note"
                self.typeTextView.text = "Type something..."
                self.navigationController?.popViewController(animated: true)
    
            }
            
            self.dismiss(animated: true)
            alert.addAction(saveAction)
            alert.addAction(discardAction)
            self.present(alert, animated: true)
            
                                        }
        let button = UIButton(primaryAction: showAlertAction)
        button.setImage(UIImage(named: "save"), for: .normal)
        button.backgroundColor = .systemGray
        button.tintColor = .white
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
        
        view.addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 100),
            saveButton.widthAnchor.constraint(equalToConstant: 100)
        
        ])
        saveButton.layer.cornerRadius = 12
        
        
        
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


}





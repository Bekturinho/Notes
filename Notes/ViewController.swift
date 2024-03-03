//
//  ViewController.swift
//  Notes
//
//  Created by fortune cookie on 2/28/24.
//

import UIKit

class ViewController: UIViewController {

    static var identifier: String = {
        String(describing: ViewController.self)
    }()
    private lazy var notesInfoTitle = String()
    private lazy var notesInfoText = String()
    private lazy var notesArray: [Notes] = []
    private lazy var titleNAmeArray: [String] = []
    private lazy var randomColors: [UIColor] = [
        .systemRed,
        .systemOrange,
        .systemYellow,
        .systemTeal,
        .systemPink,
        .systemPurple,
        .blue,
        .cyan
    
    ]
    
    private lazy var noteCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.itemSize = CGSize(width: 365, height: 110)
        view.dataSource = self
        view.delegate = self
        view.register(NoteCollectionViewCell.self, forCellWithReuseIdentifier: ViewController.identifier)
        view.backgroundColor = .black
        
        return view
    }()
    
    private lazy var notesLabel: UILabel = {
        let label = UILabel()
        label.text = "Notes"
        label.font = UIFont.systemFont(ofSize: 43, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.backgroundColor = .systemGray
        button.tintColor = .white
        return button
    }()
    
    private lazy var infoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "info.circle"), for: .normal)
        button.backgroundColor = .systemGray
        button.tintColor = .white
        return button
    }()
    
    private lazy var addNoteButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        button.backgroundColor = .black
        button.tintColor = .white
        button.addTarget(self, action: #selector(addNote), for: .touchUpInside)
        return button
    }()
    
    private lazy var emptyNotesImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "rafiki")
        image.isHidden = true
        return image
    }()
    private lazy var emptyNotesLabel: UILabel = {
        let label = UILabel()
        label.text = "Create your first note !"
        label.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        label.textColor = .white
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setUpSubViews()
        
    }

    private func setUpSubViews(){
        
        haveNotes()
        
        view.addSubview(notesLabel)
        notesLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            notesLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            notesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        
        view.addSubview(infoButton)
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 55),
            infoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            infoButton.heightAnchor.constraint(equalToConstant: 50),
            infoButton.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        infoButton.layer.cornerRadius = 12
        
        view.addSubview(searchButton)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 55),
            searchButton.trailingAnchor.constraint(equalTo: infoButton.leadingAnchor, constant: -20),
            searchButton.heightAnchor.constraint(equalToConstant: 50),
            searchButton.widthAnchor.constraint(equalToConstant: 50),
        
        ])
        searchButton.layer.cornerRadius = 12
        
        view.addSubview(emptyNotesImage)
        emptyNotesImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emptyNotesImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyNotesImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            emptyNotesImage.heightAnchor.constraint(equalToConstant: 290),
            emptyNotesImage.widthAnchor.constraint(equalToConstant: 350)
            
        ])
        
        view.addSubview(emptyNotesLabel)
        emptyNotesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emptyNotesLabel.topAnchor.constraint(equalTo: emptyNotesImage.bottomAnchor, constant: 20),
            emptyNotesLabel.leadingAnchor.constraint(equalTo:view.leadingAnchor),
            emptyNotesLabel.trailingAnchor.constraint(equalTo:view.trailingAnchor)
        ])
        
        
        
        view.addSubview(noteCollectionView)
        noteCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            noteCollectionView.topAnchor.constraint(equalTo: notesLabel.bottomAnchor, constant: 50),
            noteCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noteCollectionView.heightAnchor.constraint(equalToConstant: 700),
            noteCollectionView.widthAnchor.constraint(equalToConstant: 400),
        ])

        
        view.addSubview(addNoteButton)
        addNoteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addNoteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -225),
            addNoteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addNoteButton.heightAnchor.constraint(equalToConstant: 70),
            addNoteButton.widthAnchor.constraint(equalToConstant: 70)
        
        ])
        addNoteButton.layer.cornerRadius = 35
        
     
    }
 
    
    @objc func addNote(){
        let teleport = AddNoteView()
        teleport.delegate = self
        teleport.teleportInfoDelegate = self
        navigationController?.pushViewController(teleport, animated: true)
        haveNotes()
        
        
    }
    
    private func haveNotes(){
        if notesArray.isEmpty{
            noteCollectionView.isHidden = true
            emptyNotesImage.isHidden = false
            emptyNotesLabel.isHidden = false
            

        }else{
            emptyNotesImage.isHidden = true
            emptyNotesLabel.isHidden = true
            noteCollectionView.isHidden = false
        
            
        }
    }
    
}

extension ViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        notesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = noteCollectionView.dequeueReusableCell(withReuseIdentifier: ViewController.identifier, for: indexPath) as? NoteCollectionViewCell else{
            return UICollectionViewCell()
        }
        let color = randomColors[indexPath.item]
        cell.backgroundColor = color
        let text = titleNAmeArray[indexPath.item]
        cell.changeTitle(title: text)
        
        
        
        return cell
    }
    

    
}
extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let teleport = NotesInfoViewController()
        navigationController?.pushViewController(teleport, animated: true)
        teleport.changeInfo(title: notesInfoTitle, text: notesInfoText)
        
    }
}

extension ViewController: ViewControllerDelegate, TeleportInfoDelegate{
    func changeInfo(title: String, text: String) {
        notesInfoText = text
        notesInfoTitle = title
    }
    
    func addNewNameTitle(title: String) {
        titleNAmeArray.append(title)
        
    }
    
 
    
    func addToNoteArray(note: Notes) {
        notesArray.append(note)
        noteCollectionView.reloadData()
        haveNotes()
        
        
    }
    
    
}




 


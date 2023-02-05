//
//  MainViewController.swift
//  Notes
//
//  Created by Алексей Авер on 30.01.2023.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var emptyLabel: UILabel?
    
    var notes: Results<Note>!
    let cell = "NotesTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Заметки"
        self.view.backgroundColor = .white
        
        createLabel()
        createButton()
        createTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        notes = realm.objects(Note.self).sorted(byKeyPath: "date", ascending:false)
        checkEmpty()
        tableView?.reloadData()
    }
    
    
    private func createLabel() {
        emptyLabel?.text = "Здесь пусто..."
        emptyLabel?.textColor = .black.withAlphaComponent(0.5)
        emptyLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
    }

    private func createButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }
    
    private func createTableView() {
        tableView?.register(UINib(nibName: NotesTableViewCell.reusableIdentifier, bundle: nil), forCellReuseIdentifier: NotesTableViewCell.reusableIdentifier)
        tableView?.delegate = self
        tableView?.dataSource = self
    }
    
    private func checkEmpty() {
        emptyLabel?.isHidden = !notes.isEmpty

    }
    
    
    @objc private func addTapped() {
        let addVC = NoteViewController(note: nil, typeController: .new)
        navigationController?.pushViewController(addVC, animated: true)
    }
}

extension MainViewController: UITableViewDelegate , UITableViewDataSource, UICollectionViewDelegateFlowLayout {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cell)!
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? NotesTableViewCell {
            let date = notes[indexPath.item].date
            let stringDate = getStringDate(currentDate: date)
            cell.noteTextLabel?.text = notes[indexPath.item].text
            cell.noteDateLabel?.text = stringDate
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let note = notes[indexPath.row]
        let editVC = NoteViewController(note: note, typeController: .edit)
        navigationController?.pushViewController(editVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionDelete = UIContextualAction(style: .destructive, title: "Delete") { [self]_,_,_ in
            let note = notes[indexPath.row]
            NoteManager.deleteObject(note)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
            checkEmpty()

        }
        let actions = UISwipeActionsConfiguration(actions: [actionDelete])
        return actions
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

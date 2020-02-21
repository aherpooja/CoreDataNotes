//
//  NotesListViewController.swift
//  CoreDataDemo
//
//  Created by webwerks on 31/07/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

/// This class display list of notes
class NotesListViewController: BaseViewController {

    //MARK:- IBOutlets
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var btnAdd: PushButton!

    //MARK:- Variables
    var arrNotes = [Note]()

    //MARK:- View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Notes"
        setupNavigationBar(true)
        getNotesList()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.title = nil
    }

    //MARK:- Initialization Methods

    /// This method configures table
    func setupTableView() {
        tblView.register(UINib(nibName: "TVCNoteDetails", bundle: nil), forCellReuseIdentifier: "TVCNoteDetails")
        tblView.dataSource = self
        tblView.delegate = self
        tblView.estimatedRowHeight = 80
        tblView.rowHeight = UITableView.automaticDimension
        tblView.tableFooterView = UIView()
        tblView.separatorStyle = .none
        btnAdd.fillColor = UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1.0)
    }

    /// This method fetche list of notes.
    func getNotesList() {
        showLoader(view: self.view)
        CoreDataManager.shared.fetchAllData(Constants.NoteEntity) { (success, data, error) in
            self.hideLoader()
            self.arrNotes = [Note]()
            if success {
                if let arrObj = data {
                    for element in arrObj {
                        let note = Note(data: element)
                        self.arrNotes.append(note)
                    }
                    self.arrNotes = self.arrNotes.sorted(by: { $0.dateTime.toDate(withFormat: Constants.yyyyMMddHHmm) > $1.dateTime.toDate(withFormat: Constants.yyyyMMddHHmm) })
                    self.tblView.reloadData()
                }
            }
        }
    }

    //MARK:- IBAction Method

    /// This method navigates user to add note screen
    ///
    /// - Parameter sender: UIButton
    @IBAction func btnAddTapped(_ sender: Any) {
        guard let vcAddUser = self.storyboard?.instantiateViewController(withIdentifier: "AddNoteViewController") as? AddNoteViewController else {
            return
        }
        self.navigationController?.pushViewController(vcAddUser, animated: true)
    }
    
}

// MARK: - UITableViewDataSource Methods
extension NotesListViewController:UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrNotes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TVCNoteDetails", for: indexPath) as? TVCNoteDetails else {
            return UITableViewCell()
        }

        let data = arrNotes[indexPath.row]
        cell.lblNoteTitle.text = data.noteTitle
        cell.lblNoteDescription.text = data.noteDescription
        let date = data.dateTime.toDate(withFormat: Constants.yyyyMMddHHmm)
        cell.lblDate.text = date.toString(dateFormat: Constants.ddMMMMyyyy)
        cell.lblTime.text = date.toString(dateFormat: Constants.HHmm)
        cell.selectionStyle = .none
        return cell
    }
}


// MARK: - UITableViewDelegate Methods
extension NotesListViewController:UITableViewDelegate {

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let selectedNote = arrNotes[indexPath.row]
            CoreDataManager.shared.deleteData((Constants.NoteTitle, selectedNote.noteTitle), entityName: Constants.NoteEntity) { (success, error) in
                if success {
                    self.arrNotes.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedNote = arrNotes[indexPath.row]
        let vcAddUser = self.storyboard?.instantiateViewController(withIdentifier: "AddNoteViewController") as? AddNoteViewController
        vcAddUser?.isAddNote = false
        vcAddUser?.currentNote = selectedNote
        self.navigationController?.pushViewController(vcAddUser!, animated: true)
    }
    
}

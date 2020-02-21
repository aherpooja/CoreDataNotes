//
//  AddNoteViewController.swift
//  CoreDataDemo
//
//  Created by webwerks on 31/07/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

/// This class handles add/update notes
class AddNoteViewController: BaseViewController {

    //MARK:- IBOutlets
    @IBOutlet weak var txfNoteTitle: UITextField!
    @IBOutlet weak var txvNoteDescription: UITextView!

    //MARK:- Variables
    var currentNote:Note?
    var isAddNote = true

    //MARK:- View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConfiguration()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar(false)
        self.navigationItem.title = currentNote?.noteTitle
        setupAddBarButton("Save")
    }

    //MARK:- Initialization Methods

    /// This method setup UI related configuration
    func setupConfiguration() {
        txfNoteTitle.font = UIFont.boldSystemFont(ofSize: 18)
        txfNoteTitle.textColor = UIColor.black
        txfNoteTitle.placeholder = "Title"

        txvNoteDescription.font = UIFont.systemFont(ofSize: 16)

        txvNoteDescription.text = "Description"

        txvNoteDescription.delegate = self
        txfNoteTitle.delegate = self

        if currentNote == nil || currentNote?.noteTitle == "" {
            txvNoteDescription.textColor = UIColor.lightGray
        } else {
            txvNoteDescription.textColor = UIColor.black
        }

        if !self.isAddNote {
            txfNoteTitle.text = currentNote?.noteTitle
            txvNoteDescription.text = currentNote?.noteDescription
        }
    }

    //MARK:- Custom Methods

    /// This method save/update note
    override func saveNote() {
        showLoader(view: self.view)
        if isAddNote {
            addNewNote()
        } else {
            updateNote()
        }
    }

    /// This method adds new note and save it persistent storage
    func addNewNote() {
        let data:[String:Any] = [Constants.NoteTitle:txfNoteTitle.text!,Constants.NoteDescription:txvNoteDescription.text!,Constants.NoteCategory:"Shopping",Constants.IsNoteBookmarked:false,Constants.NoteDateTime:Date().toString(dateFormat: Constants.yyyyMMddHHmm)]
        CoreDataManager.shared.inserData(data, entityName: Constants.NoteEntity) { (success, error) in
            if success {
                self.hideLoader()
                self.navigationController?.popViewController(animated: true)
            } else {
                self.hideLoader()
                let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }

    /// THis method updates existing note
    func updateNote() {
        showLoader(view: self.view)
        let data:[String:Any] = [Constants.NoteTitle:txfNoteTitle.text!,Constants.NoteDescription:txvNoteDescription.text!,Constants.NoteCategory:"Shopping",Constants.IsNoteBookmarked:false,Constants.NoteDateTime:Date().toString(dateFormat: Constants.yyyyMMddHHmm)]
        CoreDataManager.shared.updateData(data, search: (Constants.NoteTitle, (currentNote?.noteTitle)!), entityName: Constants.NoteEntity) { (success, error) in
            if success {
                self.hideLoader()
                self.navigationController?.popViewController(animated: true)
            } else {
                self.hideLoader()
                let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}

// MARK: - UITextViewDelegate, UITextFieldDelegate methods
extension AddNoteViewController: UITextViewDelegate, UITextFieldDelegate {

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

        // Combine the textView text and the replacement text to
        // create the updated text string
        let currentText:String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)

        // If updated text view will be empty, add the placeholder
        // and set the cursor to the beginning of the text view
        if updatedText.isEmpty {

            textView.text = "Description"
            textView.textColor = UIColor.lightGray

            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        }

            // Else if the text view's placeholder is showing and the
            // length of the replacement string is greater than 0, set
            // the text color to black then set its text to the
            // replacement string
        else if textView.text == "Description" {
            textView.textColor = UIColor.black
            textView.text = text
        }

            // For every other case, the text should change with the usual
            // behavior...
        else {
            return true
        }

        // ...otherwise return false since the updates have already
        // been made
        return false
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        self.navigationItem.title = txfNoteTitle.text
    }
}

// MARK: - Date
extension Date
{

    /// This method converts date to string for given format
    ///
    /// - Parameter format: String
    /// - Returns: String
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

// MARK: - String
extension String {

    /// This method converts string to date with date format
    ///
    /// - Parameter format: String
    /// - Returns: Date
    func toDate(withFormat format: String = "yyyy-MM-dd HH:mm:ss")-> Date{

        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format

        guard let date = dateFormatter.date(from: self) else {
            return Date()
        }

        return date
    }
}




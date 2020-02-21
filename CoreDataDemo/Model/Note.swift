//
//  Note.swift
//  CoreDataDemo
//
//  Created by webwerks on 31/07/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit
import CoreData

/// This is Note entity model
class Note:NSObject {
    //MARK:- Variables
    var noteTitle = ""
    var noteDescription = ""
    var dateTime = ""
    var category = ""
    var isBookmarked = false

    //MARK:- Initialization
    /// This custom init method to initialize object
    ///
    /// - Parameter data: [String:Any]
    init(data:[String:Any]) {
        if let title = data[Constants.NoteTitle] as? String {
            self.noteTitle = title
        }
        if let noteDescription = data[Constants.NoteDescription] as? String {
            self.noteDescription = noteDescription
        }
        if let dateTime = data[Constants.NoteDateTime] as? String {
            self.dateTime = dateTime
        }
        if let category = data[Constants.NoteCategory] as? String {
            self.category = category
        }
        if let isBookmarked = data[Constants.IsNoteBookmarked] as? Bool {
            self.isBookmarked = isBookmarked
        }
    }
}

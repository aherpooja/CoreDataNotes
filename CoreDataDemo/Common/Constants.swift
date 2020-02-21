//
//  Constants.swift
//  CoreDataDemo
//
//  Created by webwerks on 07/08/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

/// This class contains constant for the app.
final class Constants: NSObject {

    //MARK:- Notes entity
    static let NoteEntity = "Notes"
    static let NoteTitle = "title"
    static let NoteDescription = "noteDescription"
    static let NoteDateTime = "dateTime"
    static let NoteCategory = "category"
    static let IsNoteBookmarked = "isBookmarked"

    //MARK:- Date Time format
    static let yyyyMMddHHmm = "yyyy-MM-dd HH:mm"
    static let ddMMMMyyyy = "dd MMMM yyyy"
    static let HHmm = "HH:mm"

    //MARK:- Color
    static let lighGrayColor = UIColor(red: 233/255, green: 233/255, blue: 233/255, alpha: 1.0)
}

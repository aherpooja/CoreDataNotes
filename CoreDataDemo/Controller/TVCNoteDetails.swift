//
//  TVCNoteDetails.swift
//  CoreDataDemo
//
//  Created by webwerks on 31/07/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

/// This class handles Note Details cell UI
class TVCNoteDetails: UITableViewCell {

    //MARK:- IBOutlets
    @IBOutlet weak var viwContent: UIView!
    @IBOutlet weak var lblNoteTitle: UILabel!
    @IBOutlet weak var lblNoteDescription: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!

    //MARK:- View life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        viwContent.layer.cornerRadius = 5.0
        viwContent.layer.borderColor = Constants.lighGrayColor.cgColor
        viwContent.backgroundColor = Constants.lighGrayColor

        lblNoteTitle.font = UIFont.boldSystemFont(ofSize: 16)
        lblNoteDescription.font = UIFont.systemFont(ofSize: 13)
        lblTime.font = UIFont.systemFont(ofSize: 11)
        lblDate.font = UIFont.systemFont(ofSize: 11)
        lblDate.textColor = .darkGray
        lblTime.textColor = .darkGray
        lblNoteDescription.textColor = UIColor.darkText
    }
}

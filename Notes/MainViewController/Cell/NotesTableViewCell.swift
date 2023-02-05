//
//  NotesTableViewCell.swift
//  Notes
//
//  Created by Алексей Авер on 04.02.2023.
//

import UIKit

class NotesTableViewCell: UITableViewCell {

   
    @IBOutlet weak var noteTextLabel: UILabel? {
        didSet {
            noteTextLabel?.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
            noteTextLabel?.textColor = .black
        }
    }
    @IBOutlet weak var noteDateLabel: UILabel? {
        didSet {
            noteDateLabel?.font = UIFont.systemFont(ofSize: 12, weight: .thin)
            noteDateLabel?.textColor = .black.withAlphaComponent(0.9)
        }
    }
    
    static let reusableIdentifier = String(describing: NotesTableViewCell.self)
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  NoteViewController.swift
//  Notes
//
//  Created by Алексей Авер on 04.02.2023.
//

import UIKit
import RealmSwift

enum NoteControllerType {
    case new
    case edit
}

class NoteViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var textView: UITextView?
    
    var note: Note?
    var imageData: Data?
    
    var typeController: NoteControllerType?
    
    init(note: Note?, typeController: NoteControllerType) {
        self.note = note
        self.typeController = typeController
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        createButton()
        if typeController == .edit {
            guard let note = note else {return}
            let imageData = note.image
            textView?.text = note.text
            if let imageData = imageData {
                if let image = UIImage(data: imageData),
                   let textView = textView {
                    let imageAttachment = NSTextAttachment()
                    imageAttachment.image = image
                    let screenWidth = UIScreen.main.bounds.width
                    let imageWidth = screenWidth * 0.8
                    imageAttachment.bounds = CGRect(x: 0, y: 0, width: imageWidth, height: image.size.height * (imageWidth / image.size.width))
                    
                    let imageString = NSAttributedString(attachment: imageAttachment)
                    textView.textStorage.insert(imageString, at: textView.selectedRange.location)
                    self.imageData = image.jpegData(compressionQuality: 1.0)
                }
                
                
            }
        }
        textView?.becomeFirstResponder()
        
    }
    
    private func createButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(saveTapped))
    }
    
    @objc private func saveTapped() {
        switch self.typeController {
        case .new:
            guard let textView = textView else {return}
            if !textView.text.isEmpty {
                let note = Note(text: textView.text, date: Date(), imageData: imageData)
                NoteManager.saveObject(note)
                self.navigationController?.popToRootViewController(animated: true)
            }
            
        case .edit:
            guard let textView = textView,
                  let note = note
            else {return}
            if !textView.text.isEmpty {
                NoteManager.updateObject(note: note, text: textView.text, date: Date(), imageData: imageData)
                self.navigationController?.popToRootViewController(animated: true)
            }
        case .none:
            return
        }
    }
    
    @IBAction func selectImage(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage,
              let textView = textView
        else {
            return
        }
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = image
        let screenWidth = UIScreen.main.bounds.width
        let imageWidth = screenWidth * 0.8
        imageAttachment.bounds = CGRect(x: 0, y: 0, width: imageWidth, height: image.size.height * (imageWidth / image.size.width))
        let attributedStringWithImage = NSAttributedString(attachment: imageAttachment)
        textView.textStorage.insert(attributedStringWithImage, at: textView.selectedRange.location)
        imageData = image.jpegData(compressionQuality: 1.0)
    }
}

//
//  DetailViewController.swift
//  Notes
//
//  Created by Stomach Diego on 10/8/20.
//  Copyright © 2020 Mansur Nasybullin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var head: UITextField!
    @IBOutlet var bodyText: UITextView!
    
    var note: Note!
    var indexNote: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.setHidesBackButton(true, animated: true)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        let delete = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteNote))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let compose = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(addNote))
        
        toolbarItems = [delete, spacer, compose]
        navigationController?.isToolbarHidden = false
        
        head.text = note.head
        bodyText.text = note.body
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            bodyText.contentInset = .zero
        } else {
            bodyText.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }

        bodyText.scrollIndicatorInsets = bodyText.contentInset

        let selectedRange = bodyText.selectedRange
        bodyText.scrollRangeToVisible(selectedRange)
    }
    
    @objc func addNote() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Default") as? ViewController {
            let editNote = Note(head: head.text!, body: bodyText.text!)
            vc.note = editNote
            vc.indexNote = indexNote
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func deleteNote() {
        let ac = UIAlertController(title: "Are you sure you want to delete the note?", message: nil, preferredStyle: .alert)
        
        let yes = UIAlertAction(title: "Yes", style: .default) { [weak self] action in
            if let vc = self?.storyboard?.instantiateViewController(withIdentifier: "Default") as? ViewController {
                vc.deleteNote = self?.indexNote
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }
        let no = UIAlertAction(title: "No", style: .default)
        ac.addAction(yes)
        ac.addAction(no)
        present(ac, animated: true)
    }
    
    @objc func shareTapped() {
        let text = bodyText.text ?? ""
        let headText = head.text ?? ""
        
        let vc = UIActivityViewController(activityItems: [headText, text], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
        
    }
    

}

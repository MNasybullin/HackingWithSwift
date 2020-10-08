//
//  ViewController.swift
//  Notes
//
//  Created by Stomach Diego on 10/8/20.
//  Copyright © 2020 Mansur Nasybullin. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var notes = [Note]()
    
    var deleteNote: Int?
    
    var note: Note!
    var indexNote: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.setHidesBackButton(true, animated: true)
        
        let defaults = UserDefaults.standard
        
        if let savedNotes = defaults.object(forKey: "notes") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                notes = try jsonDecoder.decode([Note].self, from: savedNotes)
            } catch {
                print("Failed to load notes.")
            }
        }
        
        title = "Notes"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
        
        if deleteNote != nil {
            delete()
        }
        
        if indexNote != nil {
            updateNote()
        }
        
    }
    
    func updateNote() {
        notes[indexNote!] = note!
        tableView.reloadData()
        save()
    }
    
    func delete() {
        notes.remove(at: deleteNote!)
        tableView.reloadData()
        save()
    }
    
    @objc func addNote() {
        let note = Note(head: "New note!", body: "")
        notes.append(note)
        tableView.reloadData()
        save()
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(notes) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "notes")
        } else {
            print("Failed to save notes.")
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = notes[indexPath.row].head
        cell.detailTextLabel?.text = notes[indexPath.row].body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            
            vc.note = notes[indexPath.row]
            vc.indexNote = indexPath.row
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }


}


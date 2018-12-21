//
//  ViewController.swift
//  SO 49204823
//
//  Created by acyrman on 11/13/18.
//  Copyright © 2018 iCyrman. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }

    func getViewIndexInTableView(tableView: UITableView, view: UIView) -> IndexPath? {
        let pos = view.convert(CGPoint.zero, to: tableView)
        return tableView.indexPathForRow(at: pos)
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        // Let's localize the index of the button using a helper method
        // and also localize the Song i the database
        if let index = getViewIndexInTableView(tableView: tableView, view: sender),
            let song = DB.shared.getSong(index.row) {
            // If a the song located is the same it's currently playing just stop
            // playing it and return.
            guard song != Player.shared.currentlyPlaying() else {
                stopCurrentlyPlaying()
                return
            }
            // Stop any playing song if necessary
            stopCurrentlyPlaying()
            // Staart playing the song
            Player.shared.play(this: song)
            // Change the tapped button to a Stop image
            changeButtonImage(sender, play: false)
        }
    }
    
    func stopCurrentlyPlaying() {
        if let currentSong = Player.shared.currentlyPlaying() {
            Player.shared.stop()
            if let indexStop = DB.shared.getPosition(currentSong) {
                let cell = tableView.cellForRow(at: IndexPath(item: indexStop, section: 0)) as! CustomCell
                changeButtonImage(cell.button, play: true)
            }
        }
    }
    
    func changeButtonImage(_ button: UIButton, play: Bool) {
        UIView.transition(with: button, duration: 0.4,
                          options: .transitionCrossDissolve, animations: {
                            button.setImage(UIImage(named: play ? "Play" : "Stop"), for: .normal)
        }, completion: nil)
    }
    
    //MARK: Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DB.shared.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath)
                                                                                    as! CustomCell
        cell.label.text = DB.shared.getSong(indexPath.row)!.name
        cell.button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return cell
    }
}


//
//  Player.swift
//  SO 49204823
//
//  Created by acyrman on 11/13/18.
//  Copyright © 2018 iCyrman. All rights reserved.
//

import Foundation
import AVFoundation

class Player {
    static var shared = Player()
    var player: AVAudioPlayer?
    var song: Song?
    
    init() {
        song = nil
    }
    
    func currentlyPlaying() -> Song? {
        return song
    }
    
    func play(this song: Song) {
        stop()
        do {
            guard let url = Bundle.main.url(forResource: song.fileName, withExtension: "mp3") else { return }
            //try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            player?.play()
            self.song = song

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func stop() {
        player?.stop()
        self.song = nil
    }
}

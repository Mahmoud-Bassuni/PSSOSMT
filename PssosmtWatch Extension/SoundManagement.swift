//
//  SoundManagement.swift
//  PssosmtWatch Extension
//
//  Created by Bassuni on 11/1/19.
//  Copyright © 2019 futureface. All rights reserved.
//

import Foundation
import AVFoundation
class SoundManagement {
    static let shared = SoundManagement()
    private init() {}
    private var player: AVAudioPlayer?
    func playSound() {
           guard let url = Bundle.main.url(forResource: "voice", withExtension: "mp3") else { return }

           do {
               try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
               try AVAudioSession.sharedInstance().setActive(true)

               /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
               player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

               /* iOS 10 and earlier require the following line:
               player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

               guard let player = player else { return }

               player.play()

           } catch let error {
               print(error.localizedDescription)
           }
       }
    func stopSound(){
        player?.stop()
    }
}

//
//  ViewController.swift
//  AudioKitTest
//
//  Created by Ryan King on 12/15/16.
//  Copyright © 2016 Hello World Engineering. All rights reserved.
//

import UIKit
import AudioKit

class ViewController: UIViewController {
    let engine = AVAudioEngine()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        // Create two players
        guard let fileURL = Bundle.main.url(forResource: "TestTone", withExtension: "wav") else {
            print("Could not find file in bundle.")
            return
        }
        do {
            let playerOne = try AKAudioPlayer(file: AKAudioFile(forReading: fileURL))
            let playerTwo = try AKAudioPlayer(file: AKAudioFile(forReading: fileURL))
            let mixer = AKMixer(playerOne, playerTwo)
            
            AudioKit.output = mixer
            AudioKit.start()

            playerOne.play(from: 0, to: 0.3, when: 0.5)
            playerTwo.play(from: 0.3, to: 1.0, when: 0.8)
            
//            // Create the engine
////            let engine = AVAudioEngine()
//            
//            // Open the audio file
//            //let fileURL = Bundle.main.url(forResource: "TestTone", withExtension: "wav")
//            let file = try AVAudioFile(forReading: fileURL)
//            
//            // Create player1 and attach it to the engine, then "schedule" the audio file
//            let player1 = AVAudioPlayerNode()
//            engine.attach(player1)
//            player1.scheduleFile(file, at: nil, completionHandler: nil)
//            
//            // Repeat for player2
//            let player2 = AVAudioPlayerNode()
//            engine.attach(player2)
//            player2.scheduleFile(file, at: nil, completionHandler: nil)
//            
//            // Connect the players to the engine's main mixer
//            let mixer = engine.mainMixerNode
//            engine.connect(player1, to: mixer, format: file.processingFormat)
//            engine.connect(player2, to: mixer, format: file.processingFormat)
//            
//            // Start your engine!
//            try engine.start()
//            
//            // Find the conversion factor from host ticks to seconds
//            let currentTimeTicks = mach_absolute_time()
//            var timebaseInfo = mach_timebase_info()
//            mach_timebase_info(&timebaseInfo)
//            let hostTimeToSecFactor = Double(timebaseInfo.numer) / Double(timebaseInfo.denom) / 1000000000.0
//            
//            // Play player1 1 second from now, play player2 1.69299 seconds from now
//            player1.play(at: AVAudioTime(hostTime: currentTimeTicks + UInt64(1.0 / hostTimeToSecFactor)))
//            player2.play(at: AVAudioTime(hostTime: currentTimeTicks + UInt64((1.69299) / hostTimeToSecFactor)))
        } catch let e {
            print("ERROR: \(e.localizedDescription)")
        }
    }
}


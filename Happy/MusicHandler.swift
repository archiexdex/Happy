//
//  MusicHandler.swift
//  Happy
//
//  Created by 楊信之 on 10/2/16.
//  Copyright © 2016 楊信之. All rights reserved.
//

import UIKit
import AVFoundation

class MusicHandler: NSObject {

    // MARK: - Variable
    var audioPlayer : AVAudioPlayer
    var isPlaying   : Bool = false
    var path        : URL? 
    var isLooper    : Bool = false
    
    // MARK: - Singleton
    class var sharedInstance : MusicHandler{
        struct Singleton {
            static let instance = MusicHandler()
        }
        return Singleton.instance
    }
    
    // MARK: - Init
    override init() {
        //
        audioPlayer = AVAudioPlayer()
        
        super.init()
        
        
        
    }
    
    func isLooper( ptr : Bool) {
        
        audioPlayer.numberOfLoops = ptr == true ? -1 : 1
    }
    
    func volume( ptr : Float ) {
        audioPlayer.volume = ptr
    }
    
    func startPlay() {
        
        if audioPlayer.prepareToPlay() == true {
            audioPlayer.play()
            self.isPlaying = true
        }
    }
    
    func changeMusic( name : String ) {
        
        if self.isPlaying == true {
            self.isPlaying = false
            self.stop()
        }
        self.path = Bundle.main.url(forResource: name , withExtension: "mp3")
        
        do {
            self.audioPlayer = try AVAudioPlayer(contentsOf: path!)
            // use audioPlayer
        } catch {
            // handle error
        }
        
        self.startPlay()
    }
    
    func stop() {
        
        audioPlayer.stop()
    }
    
}

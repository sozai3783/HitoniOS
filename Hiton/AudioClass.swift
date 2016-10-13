//
//  AudioClass.swift
//  Hiton
//
//  Created by yao on 19/04/2016.
//  Copyright © 2016 apsystem. All rights reserved.
//

import UIKit
import AVFoundation

class AudioClass: NSObject {
    
    class var sharedInstance: AudioClass {
        struct Singleton {
            static var onceToken : dispatch_once_t = 0
            static var staticInstance: AudioClass? = nil
        }
        dispatch_once(&Singleton.onceToken) {
            Singleton.staticInstance = AudioClass()
        }
        return Singleton.staticInstance!
    }


    var SlideURL: NSURL?
    var SelectURL: NSURL?
    var BackURL: NSURL?
    
    var RemoveDartURL: NSURL?
    var RoundURL: NSURL?
    var ThrowDartURL: NSURL?
    
    var SmileURL: NSURL?
    var CutURL: NSURL?
    
    var SlideAudio: AVAudioPlayer?
    var SelectAudio: AVAudioPlayer?
    var BackAudio: AVAudioPlayer?
    
    var RemoveDartAudio: AVAudioPlayer?
    var RoundAudio: AVAudioPlayer?
    var ThrowDartAudio: AVAudioPlayer?
    
    var SmileAudio: AVAudioPlayer?
    var CutAudio: AVAudioPlayer?
    
    var SingleURL: NSURL?
    var DoubleURL: NSURL?
    var TripleURL: NSURL?
    var SBullURL: NSURL?
    var DBullURL: NSURL?
    var MissURL: NSURL?
    
    var Triple16URL: NSURL?
    var Triple17URL: NSURL?
    var Triple18URL: NSURL?
    var Triple19URL: NSURL?
    var Triple20URL: NSURL?
    
    
    var CRTriple15URL: NSURL?
    var CRTriple16URL: NSURL?
    var CRTriple17URL: NSURL?
    var CRTriple18URL: NSURL?
    var CRTriple19URL: NSURL?
    var CRTriple20URL: NSURL?
    
    var SingleAudio: AVAudioPlayer?
    var DoubleAudio: AVAudioPlayer?
    var TripleAudio: AVAudioPlayer?
    var SBullAudio: AVAudioPlayer?
    var DBullAudio: AVAudioPlayer?
    var MissAudio: AVAudioPlayer?
    
    var Triple16Audio: AVAudioPlayer?
    var Triple17Audio: AVAudioPlayer?
    var Triple18Audio: AVAudioPlayer?
    var Triple19Audio: AVAudioPlayer?
    var Triple20Audio: AVAudioPlayer?
    
    
    var CRTriple15Audio: AVAudioPlayer?
    var CRTriple16Audio: AVAudioPlayer?
    var CRTriple17Audio: AVAudioPlayer?
    var CRTriple18Audio: AVAudioPlayer?
    var CRTriple19Audio: AVAudioPlayer?
    var CRTriple20Audio: AVAudioPlayer?
    
    
    var StartGameURL: NSURL?
    var StartGameAudio: AVAudioPlayer?
    
    
    var HeartBeatURL: NSURL?
    var HeartBeatAudio: AVAudioPlayer?
    
    var BalloonBoomURL: NSURL?
    var BalloonBoomAudio: AVAudioPlayer?
    
    
    var CRMarkChompURL: NSURL?
    var CRMarkChompAudio: AVAudioPlayer?
    
    //mark_chomp
    
    override init() {
        SlideURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("selection", ofType: "mp3")!)
        SelectURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("menu_select", ofType: "mp3")!)
        BackURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("menu_back", ofType: "mp3")!)
        SingleURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("single", ofType: "mp3")!)
        DoubleURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("double", ofType: "mp3")!)
        TripleURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("triple", ofType: "mp3")!)
        
        Triple16URL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("T16", ofType: "mp3")!)
        Triple17URL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("T17", ofType: "mp3")!)
        Triple18URL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("T18", ofType: "mp3")!)
        Triple19URL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("T19", ofType: "mp3")!)
        Triple20URL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("T20", ofType: "mp3")!)
        
        CRTriple15URL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("CR_T15", ofType: "mp3")!)
        CRTriple16URL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("CR_T16", ofType: "mp3")!)
        CRTriple17URL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("CR_T17", ofType: "mp3")!)
        CRTriple18URL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("CR_T18", ofType: "mp3")!)
        CRTriple19URL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("CR_T19", ofType: "mp3")!)
        CRTriple20URL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("CR_T20", ofType: "mp3")!)
        
        RemoveDartURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("removedart", ofType: "mp3")!)
        RoundURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("round", ofType: "mp3")!)
        ThrowDartURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("throwdart", ofType: "mp3")!)
        
        SmileURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("smile", ofType: "mp3")!)
        CutURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("cut", ofType: "mp3")!)
        
        SBullURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bull", ofType: "mp3")!)
        DBullURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("dbull", ofType: "mp3")!)
        MissURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("miss", ofType: "mp3")!)
        
        StartGameURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("show_game", ofType: "mp3")!)

        HeartBeatURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("tempheartbeat2", ofType: "mp3")!)
        BalloonBoomURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("tempExplode", ofType: "mp3")!)
        
        
        CRMarkChompURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("mark_chomp", ofType: "mp3")!)

        super.init()
    }
    
    func SlidePlay(){
        do {
            try SlideAudio = AVAudioPlayer(contentsOfURL: SlideURL!)
            SlideAudio?.prepareToPlay()
            SlideAudio?.play()
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
    
    func SelectPlay(){
        do {
            try SelectAudio = AVAudioPlayer(contentsOfURL: SelectURL!)
            SelectAudio?.prepareToPlay()
            SelectAudio?.play()
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
    
    func BackPlay(){
        do {
            try BackAudio = AVAudioPlayer(contentsOfURL: BackURL!)
            BackAudio?.prepareToPlay()
            BackAudio?.play()
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
    
    func SinglePlay(){
        do {
            try SingleAudio = AVAudioPlayer(contentsOfURL: SingleURL!)
            SingleAudio?.prepareToPlay()
            SingleAudio?.play()
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
    
    func DoublePlay(){
        do {
            try DoubleAudio = AVAudioPlayer(contentsOfURL: DoubleURL!)
            DoubleAudio?.prepareToPlay()
            DoubleAudio?.play()
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
    
    func TriplePlay(){
        do {
            try TripleAudio = AVAudioPlayer(contentsOfURL: TripleURL!)
            TripleAudio?.prepareToPlay()
            TripleAudio?.play()
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
    
    func Triple16Play(){
        do {
            try Triple16Audio = AVAudioPlayer(contentsOfURL: Triple16URL!)
            Triple16Audio?.prepareToPlay()
            Triple16Audio?.play()
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
    
    func Triple17Play(){
        do {
            try Triple17Audio = AVAudioPlayer(contentsOfURL: Triple17URL!)
            Triple17Audio?.prepareToPlay()
            Triple17Audio?.play()
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
    
    func Triple18Play(){
        do {
            try Triple18Audio = AVAudioPlayer(contentsOfURL: Triple18URL!)
            Triple18Audio?.prepareToPlay()
            Triple18Audio?.play()
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
    
    func Triple19Play(){
        do {
            try Triple19Audio = AVAudioPlayer(contentsOfURL: Triple19URL!)
            Triple19Audio?.prepareToPlay()
            Triple19Audio?.play()
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
    
    func Triple20Play(){
        do {
            try Triple20Audio = AVAudioPlayer(contentsOfURL: Triple20URL!)
            Triple20Audio?.prepareToPlay()
            Triple20Audio?.play()
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
    
    func SBullPlay(){
        do {
            try SBullAudio = AVAudioPlayer(contentsOfURL: SBullURL!)
            SBullAudio?.prepareToPlay()
            SBullAudio?.play()
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
    
    func DBullPlay(){
        do {
            try DBullAudio = AVAudioPlayer(contentsOfURL: DBullURL!)
            DBullAudio?.prepareToPlay()
            DBullAudio?.play()
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
    
    func MissPlay(){
        do {
            try MissAudio = AVAudioPlayer(contentsOfURL: MissURL!)
            MissAudio?.prepareToPlay()
            MissAudio?.play()
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
    
    func StartGamePlay(){
        do {
            try StartGameAudio = AVAudioPlayer(contentsOfURL: StartGameURL!)
            StartGameAudio?.prepareToPlay()
            StartGameAudio?.play()
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
    
    func RemoveDartPlay(){
        do {
            try RemoveDartAudio = AVAudioPlayer(contentsOfURL: RemoveDartURL!)
            RemoveDartAudio?.prepareToPlay()
            RemoveDartAudio?.play()
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
    
    func RoundPlay(){
        do {
            try RoundAudio = AVAudioPlayer(contentsOfURL: RoundURL!)
            RoundAudio?.prepareToPlay()
            RoundAudio?.play()
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
    
    func ThrowDartPlay(){
        do {
            try ThrowDartAudio = AVAudioPlayer(contentsOfURL: ThrowDartURL!)
            ThrowDartAudio?.prepareToPlay()
            ThrowDartAudio?.play()
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
    
    func CRTriple15Play(){
        do {
            try CRTriple15Audio = AVAudioPlayer(contentsOfURL: CRTriple15URL!)
            CRTriple15Audio?.prepareToPlay()
            CRTriple15Audio?.play()
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
    
    func CRTriple16Play(){
        do {
            try CRTriple16Audio = AVAudioPlayer(contentsOfURL: CRTriple16URL!)
            CRTriple16Audio?.prepareToPlay()
            CRTriple16Audio?.play()
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
    
    func CRTriple17Play(){
        do {
            try CRTriple17Audio = AVAudioPlayer(contentsOfURL: CRTriple17URL!)
            CRTriple17Audio?.prepareToPlay()
            CRTriple17Audio?.play()
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
    
    func CRTriple18Play(){
        do {
            try CRTriple18Audio = AVAudioPlayer(contentsOfURL: CRTriple18URL!)
            CRTriple18Audio?.prepareToPlay()
            CRTriple18Audio?.play()
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
    
    func CRTriple19Play(){
        do {
            try CRTriple19Audio = AVAudioPlayer(contentsOfURL: CRTriple19URL!)
            CRTriple19Audio?.prepareToPlay()
            CRTriple19Audio?.play()
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
    
    func CRTriple20Play(){
        do {
            try CRTriple20Audio = AVAudioPlayer(contentsOfURL: CRTriple20URL!)
            CRTriple20Audio?.prepareToPlay()
            CRTriple20Audio?.play()
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
    
    func SmilePlay(){
        do {
            try SmileAudio = AVAudioPlayer(contentsOfURL: SmileURL!)
            SmileAudio?.prepareToPlay()
            SmileAudio?.play()
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
    
    func CutPlay(){
        do {
            try CutAudio = AVAudioPlayer(contentsOfURL: CutURL!)
            CutAudio?.prepareToPlay()
            CutAudio?.play()
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
    
    func HeartBeatPlay(){
        do {
            try HeartBeatAudio = AVAudioPlayer(contentsOfURL: HeartBeatURL!)
            HeartBeatAudio?.prepareToPlay()
            HeartBeatAudio?.play()
            HeartBeatAudio?.numberOfLoops = -1
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }

    func HeartBeatStop(){
        HeartBeatAudio?.stop()
    }
    
    func BalloonBoomPlay(){
        do {
            try BalloonBoomAudio = AVAudioPlayer(contentsOfURL: BalloonBoomURL!)
            BalloonBoomAudio?.prepareToPlay()
            BalloonBoomAudio?.play()
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
    
    func CRMarkChompPlay(){
        do {
            try CRMarkChompAudio = AVAudioPlayer(contentsOfURL: CRMarkChompURL!)
            CRMarkChompAudio?.prepareToPlay()
            CRMarkChompAudio?.play()
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }

}

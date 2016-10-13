//
//  VideoClass.swift
//  Hiton
//
//  Created by yao on 25/04/2016.
//  Copyright © 2016 apsystem. All rights reserved.
//

import UIKit
import AVKit
import MediaPlayer


class VideoClass: NSObject {

    var BustURL: String!
    var BustVideo: MPMoviePlayerController!
    
    
    var HatTrickURL: String!
    var HatTrickVideo: MPMoviePlayerController!
    
    
    var Ton80URL: String!
    var Ton80Video: MPMoviePlayerController!
    var Ton80AVPlayer = AVPlayerLayer()
    
    
    var ThreeInABedURL: String!
    var ThreeInABedVideo: MPMoviePlayerController!
    
    
    var WhiteHorseURL: String!
    var WhiteHorseVideo: MPMoviePlayerController!
    
    
    var LowTonURL: String!
    var LowTonVideo: MPMoviePlayerController!
    
    
    var HighTonURL: String!
    var HighTonVideo: MPMoviePlayerController!
    
    
    var HitOnURL: String!
    var HitOnVideo: MPMoviePlayerController!
    
    
    var BucketOfNailURL: String!
    var BucketOfNailVideo: MPMoviePlayerController!
    
    
    var FishAndChipURL: String!
    var FishAndChipVideo: MPMoviePlayerController!
    
    
    var VideoStart: (() -> Void)?
    var VideoEnd: (() -> Void)?
    
    override init() {
        BustURL = NSBundle.mainBundle().pathForResource("bust", ofType: "mp4")
        BustVideo = MPMoviePlayerController(contentURL: NSURL(fileURLWithPath: BustURL!))
        BustVideo.controlStyle = .None
        BustVideo.repeatMode = .None
        
        HatTrickURL = NSBundle.mainBundle().pathForResource("hat_trick", ofType: "mp4")
        HatTrickVideo = MPMoviePlayerController(contentURL: NSURL(fileURLWithPath: HatTrickURL!))
        HatTrickVideo.controlStyle = .None
        HatTrickVideo.repeatMode = .None
        
        Ton80URL = NSBundle.mainBundle().pathForResource("ton_80", ofType: "mp4")
        Ton80Video = MPMoviePlayerController(contentURL: NSURL(fileURLWithPath: Ton80URL!))
        Ton80Video.controlStyle = .None
        Ton80Video.repeatMode = .None
        
        
        
        
        
        
        ThreeInABedURL = NSBundle.mainBundle().pathForResource("3_in_a_bed", ofType: "mp4")
        ThreeInABedVideo = MPMoviePlayerController(contentURL: NSURL(fileURLWithPath: ThreeInABedURL!))
        ThreeInABedVideo.controlStyle = .None
        ThreeInABedVideo.repeatMode = .None
        
        WhiteHorseURL = NSBundle.mainBundle().pathForResource("white_horse", ofType: "mp4")
        WhiteHorseVideo = MPMoviePlayerController(contentURL: NSURL(fileURLWithPath: WhiteHorseURL!))
        WhiteHorseVideo.controlStyle = .None
        WhiteHorseVideo.repeatMode = .None
        
        
        LowTonURL = NSBundle.mainBundle().pathForResource("low_ton", ofType: "mp4")
        LowTonVideo = MPMoviePlayerController(contentURL: NSURL(fileURLWithPath: LowTonURL!))
        LowTonVideo.controlStyle = .None
        LowTonVideo.repeatMode = .None
        
        HighTonURL = NSBundle.mainBundle().pathForResource("high_ton", ofType: "mp4")
        HighTonVideo = MPMoviePlayerController(contentURL: NSURL(fileURLWithPath: HighTonURL!))
        HighTonVideo.controlStyle = .None
        HighTonVideo.repeatMode = .None
        
        
        BucketOfNailURL = NSBundle.mainBundle().pathForResource("bucket_of_nail", ofType: "mp4")
        BucketOfNailVideo = MPMoviePlayerController(contentURL: NSURL(fileURLWithPath: BucketOfNailURL!))
        BucketOfNailVideo.controlStyle = .None
        BucketOfNailVideo.repeatMode = .None
        
        
        FishAndChipURL = NSBundle.mainBundle().pathForResource("fish_chip", ofType: "mp4")
        FishAndChipVideo = MPMoviePlayerController(contentURL: NSURL(fileURLWithPath: FishAndChipURL!))
        FishAndChipVideo.controlStyle = .None
        FishAndChipVideo.repeatMode = .None
        
        
        //HitOnURL = NSBundle.mainBundle().pathForResource("RedBulHatTrick", ofType: "mp4")

        super.init()
        
    }
    
    func PlayBust(v: UIView){
        BustVideo.view.frame = v.bounds
        v.addSubview(BustVideo.view)
        BustVideo.play()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(VideoClass.BustEnd), name:MPMoviePlayerPlaybackStateDidChangeNotification, object: nil)
        if let callback = self.VideoStart{
            callback()
        }
    }
    
    func BustEnd(){
        if BustVideo.playbackState == MPMoviePlaybackState.Paused{
            BustVideo.view.removeFromSuperview()
            BustVideo.stop()
            if let callback = self.VideoEnd{
                callback()
            }
        }
    }
    
    func PlayHatTrick(v: UIView){
        
        HatTrickVideo.view.frame = v.bounds
        v.addSubview(HatTrickVideo.view)
        HatTrickVideo.play()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(VideoClass.HatTrickEnd), name:MPMoviePlayerPlaybackStateDidChangeNotification, object: nil)
        if let callback = self.VideoStart{
            callback()
        }
    }
    
    func HatTrickEnd(){
        if HatTrickVideo.playbackState == MPMoviePlaybackState.Paused{
            HatTrickVideo.view.removeFromSuperview()
            HatTrickVideo.stop()
            if let callback = self.VideoEnd{
                callback()
            }
        }
    }
    
    func PlayThreeInABed(v: UIView){
        ThreeInABedVideo.view.frame = v.bounds
        v.addSubview(ThreeInABedVideo.view)
        ThreeInABedVideo.play()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(VideoClass.ThreeInABedEnd), name:MPMoviePlayerPlaybackStateDidChangeNotification, object: nil)
        if let callback = self.VideoStart{
            callback()
        }
    }
    
    func ThreeInABedEnd(){
        if ThreeInABedVideo.playbackState == MPMoviePlaybackState.Paused{
            ThreeInABedVideo.view.removeFromSuperview()
            ThreeInABedVideo.stop()
            if let callback = self.VideoEnd{
                callback()
            }
        }
    }
    
    func PlayLowTon(v: UIView){
        LowTonVideo.view.frame = v.bounds
        v.addSubview(LowTonVideo.view)
        LowTonVideo.play()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(VideoClass.LowTonEnd), name:MPMoviePlayerPlaybackStateDidChangeNotification, object: nil)
        if let callback = self.VideoStart{
            callback()
        }
    }
    
    func LowTonEnd(){
        if LowTonVideo.playbackState == MPMoviePlaybackState.Paused{
            LowTonVideo.view.removeFromSuperview()
            LowTonVideo.stop()
            if let callback = self.VideoEnd{
                callback()
            }
        }
    }
    
    func PlayHighTon(v: UIView){
        HighTonVideo.view.frame = v.bounds
        v.addSubview(HighTonVideo.view)
        HighTonVideo.play()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(VideoClass.HighTonEnd), name:MPMoviePlayerPlaybackStateDidChangeNotification, object: nil)
        if let callback = self.VideoStart{
            callback()
        }
    }
    
    func HighTonEnd(){
        if HighTonVideo.playbackState == MPMoviePlaybackState.Paused{
            HighTonVideo.view.removeFromSuperview()
            HighTonVideo.stop()
            if let callback = self.VideoEnd{
                callback()
            }
        }
    }

    func PlayTon80(v: UIView){
        Ton80Video.view.frame = v.bounds
        v.addSubview(Ton80Video.view)
        Ton80Video.play()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(VideoClass.Ton80End), name:MPMoviePlayerPlaybackStateDidChangeNotification, object: nil)
        if let callback = self.VideoStart{
            callback()
        }
        
        /*let ton80PlayerItem = AVPlayerItem(URL: NSURL(fileURLWithPath: Ton80URL!))
        let BGPlayerLayer = AVPlayer(playerItem: ton80PlayerItem)
        BGPlayerLayer.actionAtItemEnd = AVPlayerActionAtItemEnd.None
        BGPlayerLayer.play()
        Ton80AVPlayer = AVPlayerLayer(player: BGPlayerLayer)
        v.layer.addSublayer(Ton80AVPlayer)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(VideoClass.Ton80End), name:AVPlayerItemDidPlayToEndTimeNotification, object: nil)*/
    }
    
    func Ton80End(){
        if Ton80Video.playbackState == MPMoviePlaybackState.Paused{
            Ton80Video.view.removeFromSuperview()
            Ton80Video.stop()
            if let callback = self.VideoEnd{
                callback()
            }
        }
        //Ton80AVPlayer.removeFromSuperlayer()
    }
    
    func PlayWhiteHorse(v: UIView){
        WhiteHorseVideo.view.frame = v.bounds
        v.addSubview(WhiteHorseVideo.view)
        WhiteHorseVideo.play()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(VideoClass.WhiteHorseEnd), name:MPMoviePlayerPlaybackStateDidChangeNotification, object: nil)
        if let callback = self.VideoStart{
            callback()
        }
    }
    
    func WhiteHorseEnd(){
        if WhiteHorseVideo.playbackState == MPMoviePlaybackState.Paused{
            WhiteHorseVideo.view.removeFromSuperview()
            WhiteHorseVideo.stop()
            if let callback = self.VideoEnd{
                callback()
            }
        }
    }
    
    func PlayBucketOfNail(v: UIView){
        BucketOfNailVideo.view.frame = v.bounds
        v.addSubview(BucketOfNailVideo.view)
        BucketOfNailVideo.play()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(VideoClass.BucketOfNailEnd), name:MPMoviePlayerPlaybackStateDidChangeNotification, object: nil)
        if let callback = self.VideoStart{
            callback()
        }
    }
    
    func BucketOfNailEnd(){
        if BucketOfNailVideo.playbackState == MPMoviePlaybackState.Paused{
            BucketOfNailVideo.view.removeFromSuperview()
            BucketOfNailVideo.stop()
            if let callback = self.VideoEnd{
                callback()
            }
        }
    }
    
    func PlayFishAndChip(v: UIView){
        FishAndChipVideo.view.frame = v.bounds
        v.addSubview(FishAndChipVideo.view)
        FishAndChipVideo.play()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(VideoClass.FishAndChipEnd), name:MPMoviePlayerPlaybackStateDidChangeNotification, object: nil)
        if let callback = self.VideoStart{
            callback()
        }
    }
    
    func FishAndChipEnd(){
        if FishAndChipVideo.playbackState == MPMoviePlaybackState.Paused{
            FishAndChipVideo.view.removeFromSuperview()
            FishAndChipVideo.stop()
            if let callback = self.VideoEnd{
                callback()
            }
        }
    }
    
    func PlayHitOn(v: UIView){
        /*hiton = MPMoviePlayerController(contentURL: NSURL(fileURLWithPath: ThreeInABedURL!))
        ThreeInABedVideo.view.frame = v.bounds
        ThreeInABedVideo.controlStyle = .None
        ThreeInABedVideo.repeatMode = .None
        v.addSubview(ThreeInABedVideo.view)
        ThreeInABedVideo.play()
        addListener()*/
    }
    
    
    func stopVideo(){
        if HatTrickVideo.playbackState == MPMoviePlaybackState.Playing{
            HatTrickVideo.view.removeFromSuperview()
            HatTrickVideo.stop()
        }else if WhiteHorseVideo.playbackState == MPMoviePlaybackState.Playing{
            WhiteHorseVideo.view.removeFromSuperview()
            WhiteHorseVideo.stop()
        }else if Ton80Video.playbackState == MPMoviePlaybackState.Playing{
            Ton80Video.view.removeFromSuperview()
            Ton80Video.stop()
        }else if LowTonVideo.playbackState == MPMoviePlaybackState.Playing{
            LowTonVideo.view.removeFromSuperview()
            LowTonVideo.stop()
        }else if HighTonVideo.playbackState == MPMoviePlaybackState.Playing{
            HighTonVideo.view.removeFromSuperview()
            HighTonVideo.stop()
        }else if ThreeInABedVideo.playbackState == MPMoviePlaybackState.Playing{
            ThreeInABedVideo.view.removeFromSuperview()
            ThreeInABedVideo.stop()
        }else if BustVideo.playbackState == MPMoviePlaybackState.Playing{
            BustVideo.view.removeFromSuperview()
            BustVideo.stop()
        }else if FishAndChipVideo.playbackState == MPMoviePlaybackState.Playing{
            FishAndChipVideo.view.removeFromSuperview()
            FishAndChipVideo.stop()
        }else if BucketOfNailVideo.playbackState == MPMoviePlaybackState.Playing{
            BucketOfNailVideo.view.removeFromSuperview()
            BucketOfNailVideo.stop()
        }
    }

}

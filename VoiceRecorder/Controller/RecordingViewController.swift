//
//  RecordingViewController.swift
//  VoiceRecorder
//
//  Created by CHUBBY on 2022/06/30.
//

import UIKit
import AVFoundation

class RecordingViewController: UIViewController {
    
    @IBOutlet weak var recordTimeLabel: UILabel!
    @IBOutlet weak var recordingButton: UIButton!
    @IBOutlet weak var goBackwardButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var goForwardButton: UIButton!
    var progressTimer: Timer!
    var inRecordMode = true
    var inPlayMode = true
    
    let audioRecorderHandler = AudioRecoderHandler(handler: LocalFileHandler(), updateTimeInterval: UpdateTimeInterval())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.recordTimeLabel.text = "00:00"
        self.goBackwardButton.isEnabled = false
        self.goForwardButton.isEnabled = false
        self.playButton.isEnabled = false
    }
    
    func setButton(recording: Bool, goBack: Bool, goForward: Bool) {
        self.recordingButton.isEnabled = recording
        self.goBackwardButton.isEnabled = goBack
        self.goForwardButton.isEnabled = goForward
    }
    
    @IBAction func recordingButtonTapped(_ sender: UIButton) {
        if inRecordMode {
            sender.controlFlashAnimate(recordingMode: true)
            self.playButton.isEnabled = false
            audioRecorderHandler.startRecord()
            self.progressTimer = Timer.scheduledTimer(timeInterval: 0.1,
                                                      target: self,
                                                      selector: #selector(updateRecordTime),
                                                      userInfo: nil,
                                                      repeats: true)
            inRecordMode = !inRecordMode
        } else {
            sender.controlFlashAnimate(recordingMode: false)
            self.playButton.isEnabled = true
            audioRecorderHandler.stopRecord()
            progressTimer.invalidate()
            inRecordMode = !inRecordMode
        }
    }
    
    @objc func updateRecordTime() {
        self.recordTimeLabel.text = audioRecorderHandler.updateTimer(audioRecorderHandler.audioRecorder.currentTime)
    }
    
}

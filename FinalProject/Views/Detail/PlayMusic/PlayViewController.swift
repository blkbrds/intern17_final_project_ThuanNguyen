//
//  PlayViewController.swift
//  MyMusic
//
//  Created by thuan.nguyen on 13/06/2022.
//

import UIKit
import AVFoundation
import AVFAudio
import MediaPlayer
import AVKit

final class PlayViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var songNameLabel: UILabel!
    @IBOutlet private weak var singNameLabel: UILabel!
    @IBOutlet private weak var timeSlider: UISlider!
    @IBOutlet private weak var playPauseButton: UIButton!
    @IBOutlet private weak var currentTimeLabel: UILabel!
    @IBOutlet private weak var durationLabel: UILabel!
    @IBOutlet private weak var repeatButton: UIButton!

    // MARK: - Properties
    var playModel = PlayViewControllerModel()
    private var isPause: Bool = false
    private var player: AVPlayer?
    private var playerItem: AVPlayerItem?
    private var playingIndex = 0

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        updateUI()
    }

    // MARK: - private funtions
    private func setupNavigation() {
        title = "My Music"
        let rightButton = UIBarButtonItem(image: UIImage(imageLiteralResourceName: "ic-reveal"), style: .plain, target: self, action: #selector(rightAction))
        let downloadButton = UIBarButtonItem(image: UIImage(imageLiteralResourceName: "ic-heart"), style: .plain, target: self, action: #selector(downloadAction))
        let closeButton = UIBarButtonItem(image: UIImage(imageLiteralResourceName: "ic-close"), style: .plain, target: self, action: #selector(closeAction))
        self.navigationItem.rightBarButtonItems = [rightButton, downloadButton]
        self.navigationItem.leftBarButtonItem = closeButton
    }

    private func updateUI() {
        rotateView()
        configure()
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.clipsToBounds = true
        if let imgUrl = playModel.item?.track?.album?.images {
            imageView.loadImageInPlaylistTrack(from: imgUrl)
        }
        songNameLabel.text = playModel.item?.track?.name
        singNameLabel.text = playModel.item?.track?.album?.name
    }

    private func rotateView(duration: Double = 5.0) {
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { (timer) in
            if self.isPause {
                timer.invalidate()
                return
            }
            self.imageView.transform = self.imageView.transform.rotated(by: CGFloat.pi / 360)
        }
    }

    private func configure() {
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            if let urlString = playModel.item?.track?.previewUrl, let url = URL(string: urlString) {
                let playerItem: AVPlayerItem = AVPlayerItem(url: url)
                player = AVPlayer(playerItem: playerItem)
            }
            player?.play()
        }
        catch {
            print("error")
        }
    }

    // MARK: Actions
    @objc private func rightAction() {

    }

    @objc private func downloadAction() {

    }

    @objc private func closeAction() {
            player?.pause()
            navigationController?.popViewController(animated: true)
    }

    @IBAction private func handlePauseTouchUpInside(_ sender: UIButton) {
        if player?.timeControlStatus == .paused {
            player?.play()
            isPause = false
            playPauseButton.setImage(UIImage(imageLiteralResourceName: "ic-pause"), for: .normal)
            rotateView()
        } else {
            player?.pause()
            isPause = true
            playPauseButton.setImage(UIImage(imageLiteralResourceName: "ic-play"), for: .normal)
        }
    }

    @IBAction private func repeatButtonTapped(_ sender: UIButton) {

    }

    @IBAction private func handleTimeSliderTouchUpInside(_ sender: UISlider) {
        if let duration = player?.currentItem?.duration {
            let totalsecs = CMTimeGetSeconds(duration)
            let val = Float64(sender.value) * totalsecs

            let seekTime = CMTime(value: Int64(val), timescale: 1)
            player?.seek(to: seekTime, completionHandler: { (completedSeek) in
            })
        }
    }

    private func getFormattedTime(timeInterval: TimeInterval) -> String {
        let mins = timeInterval / 60
        let secs = timeInterval.truncatingRemainder(dividingBy: 60)
        let timeFormatter = NumberFormatter()
        timeFormatter.minimumIntegerDigits = 2
        timeFormatter.minimumFractionDigits = 0
        timeFormatter.roundingMode = .down
        guard let minsString = timeFormatter.string(from: NSNumber(value: mins)), let secStr = timeFormatter.string(from: NSNumber(value: secs)) else {
            return "00:00"
        }
        return "\(minsString):\(secStr)"
        }
    }

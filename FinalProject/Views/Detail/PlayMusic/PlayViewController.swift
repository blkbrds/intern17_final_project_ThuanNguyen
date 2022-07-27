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
import SwiftUI

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
    @IBOutlet private weak var shuffleButton: UIButton!

    // MARK: - Properties
    var playModel = PlayViewModel()

    private var isPause: Bool = false {
        didSet {
            if !isPause {
                player?.play()
                playPauseButton.setImage(UIImage(imageLiteralResourceName: "ic-pause"), for: .normal)
            } else {
                player?.pause()
                playPauseButton.setImage(UIImage(imageLiteralResourceName: "ic-play"), for: .normal)
            }
        }
    }
    private var isOnRepeat: Bool = false
    private var player: AVPlayer?
    private var playerItem: AVPlayerItem?
    private var playingIndex = 0
    private var index: Int = 0
    private var isLoop: Bool = false
    var items: [Item] = []

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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
        DispatchQueue.main.async {
            self.imageView.layer.cornerRadius = self.imageView.frame.height / 2
            self.imageView.clipsToBounds = true
        }

        if let imgUrl = playModel.item?.track?.album?.images {
            imageView.loadImageInPlaylistTrack(from: imgUrl)
        }
        songNameLabel.text = playModel.item?.track?.name
        singNameLabel.text = playModel.item?.track?.artists
    }

    private func rotateView(duration: Double = 5.0) {
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] (timer) in
            guard let this = self else { return }
            if this.isPause {
                timer.invalidate()
                return
            }
            this.imageView.transform = this.imageView.transform.rotated(by: CGFloat.pi / 360)
        }
    }

    private func configure() {
            if let urlString = playModel.item?.track?.previewUrl, let url = URL(string: urlString) {
                let playerItem: AVPlayerItem = AVPlayerItem(url: url)
                player = AVPlayer(playerItem: playerItem)
            }
            player?.volume = 1.0
            player?.play()
    }

    private func playList() {
        NotificationCenter.default.addObserver(self, selector: #selector(audioPlayerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }

    private func shufflePlayList() {
       // let numberIndex = playModel.item?.track?.id
    }

    private func updateTimeSlider(value: Float) {
        timeSlider.minimumValue = 0
        let duration = 29.00
        let val = Float64(value) * duration
        currentTimeLabel.text = getFormattedTime(timeInterval: val)
        durationLabel.text = getFormattedTime(timeInterval: duration)
        timeSlider.maximumValue = Float(duration)
        timeSlider.isContinuous = true
        timeSlider.tintColor = .purple
        player?.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: DispatchQueue.main) { (CMTime) -> Void in
            if self.player?.currentItem?.status == .readyToPlay {
                guard let times = self.player?.currentTime() else { return }
                let time: Float64 = CMTimeGetSeconds(times)
                self.timeSlider.value = Float(time)
                self.currentTimeLabel.text = self.getFormattedTime(timeInterval: time)
            }
        }
    }
    private func nextTrack() {

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

    private func setupUI() {
        nextTrack()
        setupNavigation()
        updateUI()
        playList()
        updateTimeSlider(value: timeSlider.value)
    }

    // MARK: Actions
    @objc private func audioPlayerDidFinishPlaying() {
        if self.isLoop {
            player?.seek(to: CMTime.zero)
            player?.play()
        } else {
//            isPause = true
//            playPauseButton.setImage(UIImage(imageLiteralResourceName: "ic-play"), for: .normal)
        }

    }

    @objc private func rightAction() {

    }

    @objc private func downloadAction() {

    }

    @objc private func closeAction() {
        player?.pause()
        navigationController?.popViewController(animated: true)
    }

    @IBAction private func handlePauseTouchUpInside(_ sender: UIButton) {
        isPause = !(player?.timeControlStatus == .paused)
        rotateView()
    }

    @IBAction private func repeatButtonTapped(_ sender: UIButton) {
        self.isOnRepeat = !self.isOnRepeat
        if self.isOnRepeat {
            repeatButton.setImage(UIImage(imageLiteralResourceName: "ic-repeat-one"), for: .normal)
            NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem, queue: .main) { [weak self] _ in
                self?.player?.seek(to: CMTime.zero)
                self?.player?.play()
                self?.isPause = false
            }
        } else {
            repeatButton.setImage(UIImage(imageLiteralResourceName: "ic-repeat"), for: .normal)
            NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem, queue: .main) { [weak self] _ in
                self?.player?.seek(to: CMTime.zero)
                self?.isPause = true
            }
        }
    }

    @IBAction private func handlePreviousTouchUpInSide(_ sender: UIButton) {
        playingIndex -= 1
        if playingIndex < 0 {
            guard let numberIndex = playModel.item?.track?.id?.count else { return }
            playingIndex = numberIndex - 1
            updateUI()
            player?.play()
        }


    }
    @IBAction private func handNextTouchUpInside(_ sender: UIButton) {
        playingIndex += 1
        if playingIndex >= playModel.itemsFromHome.count {
            playingIndex = 0
        }
        updateUI()
    }

    @IBAction private func handleTimeSliderTouchUpInside(_ sender: UISlider) {
        timeSlider.minimumValue = 0
        let seconds: Int64 = Int64(timeSlider.value)
        let targetTime: CMTime = CMTimeMake(value: seconds, timescale: 1)
        player?.seek(to: targetTime)
        if player?.rate == 0 {
           // player?.play()
            isPause = !(player?.timeControlStatus == .paused)
            rotateView()
        }
    }
}

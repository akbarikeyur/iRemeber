//
//  VideoDisplayVC.swift
//  iRemeber
//
//  Created by PC on 13/05/19.
//  Copyright © 2019 PC. All rights reserved.
//

import UIKit
import AVKit

class VideoDisplayVC: UIViewController {

    @IBOutlet weak var descriptionTxtView: TextView!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var saveBtn: UIButton!
    
    var player: AVPlayer?
    var playerController : AVPlayerViewController?
    var videoURL : URL!
    var flag : Int = 0
    var selectedData : LocatorModel = LocatorModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveBtn.setTitle("Save", for: .normal)
        if flag == 1 {
            videoURL = URL(fileURLWithPath: getVideo(videoName: selectedData.image)!)//getVideo(videoName: selectedData.image)
            descriptionTxtView.text = selectedData.descriptions
            saveBtn.setTitle("Update", for: .normal)
        }        
        
        playVideo()
    }
    
    func playVideo()
    {
        player = AVPlayer(url: videoURL)
        playerController = AVPlayerViewController()
        
        guard player != nil && playerController != nil else {
            return
        }
        playerController!.showsPlaybackControls = false
        
        playerController!.player = player!
        self.addChild(playerController!)
        videoView.addSubview(playerController!.view)
        var newFrame = videoView.frame
        newFrame.origin.x = 0
        newFrame.origin.y = 0
        
        playerController!.view.frame = newFrame
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.player!.currentItem)
        
        // Allow background audio to continue to play
        do {
            if #available(iOS 10.0, *) {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: .default, options: [])
            } else {
            }
        } catch let error as NSError {
            print(error)
        }
        
        do {
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error as NSError {
            print(error)
        }
        player?.play()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if player != nil {
            player?.pause()
        }
    }
    
    @objc fileprivate func playerItemDidReachEnd(_ notification: Notification) {
        if self.player != nil {
            self.player!.seek(to: CMTime.zero)
            self.player!.play()
        }
    }
    
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToEdit(_ sender: Any) {
        self.view.endEditing(true)
        if descriptionTxtView.text.count == 0 {
            displayToast("Please add caption.")
        }
        else if videoURL == nil {
            self.navigationController?.popViewController(animated: true)
        }
        else {
            showLoader()
            selectedData.id = flag == 1 ? selectedData.id : getCurrentTimeStampValue()
            selectedData.type = 2
            selectedData.image = selectedData.id
            selectedData.descriptions = descriptionTxtView.text
            selectedData.time = getDateStringFromDate(date: Date())
            
            if flag == 1 {
                CoreDataUtility.shared.updateCapture(item: selectedData, TableName: "CaptureList")
            }
            else {
                storeVideoInDocumentDirectory(videoUrl: videoURL, videoName: selectedData.image)
                
                let image = generateThumbImage(VideoName: selectedData.image, fileName: selectedData.image)
                print(image)
           
                CoreDataUtility.shared.saveCaptureData(Model: selectedData, TableName: "CaptureList")
            }
            
            delay(0.1) {
                removeLoader()
                if self.flag == 1 {
                    NotificationCenter.default.post(name: NSNotification.Name.init(NOTIFICATION.UPDATE_CAPTURE), object: nil)
                    self.navigationController?.popViewController(animated: true)
                }
                else {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "CapatureListVC") as! CapatureListVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
}



extension UIImage {
    func rotate(radians: CGFloat) -> UIImage {
        let rotatedSize = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: CGFloat(radians)))
            .integral.size
        UIGraphicsBeginImageContext(rotatedSize)
        if let context = UIGraphicsGetCurrentContext() {
            let origin = CGPoint(x: rotatedSize.width / 2.0,
                                 y: rotatedSize.height / 2.0)
            context.translateBy(x: origin.x, y: origin.y)
            context.rotate(by: radians)
            draw(in: CGRect(x: -origin.y, y: -origin.x,
                            width: size.width, height: size.height))
            let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return rotatedImage ?? self
        }
        
        return self
    }
}

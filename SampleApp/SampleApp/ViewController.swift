//
//  ViewController.swift
//  SampleApp
//
//  Created by 서채희 on 2024/03/10.
//

import UIKit
import ReededGlassView

class ViewController: UIViewController {
    @IBOutlet weak var targetImageView: UIImageView!
    @IBOutlet weak var reededGlassView: ReededGlassView!
    private lazy var activitiIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.stopAnimating()
        return activityIndicator
    }()
    
    var currentImageName = "katsiaryna-endruszkiewicz-unsplash"
    var currentWidthIndex = 1
    
    // Sample images are downloaded via unsplash.com
    let imageNames = ["katsiaryna-endruszkiewicz-unsplash",
                      "aiony-haust-unsplash",
                      "cemrecan-yurtman-MQO_7joYVOM-unsplash",
                      "sq-lim-RPT9QxdL1IM-unsplash",
                      "musa-ortac-GXFhhbKZhaY-unsplash"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(activitiIndicator)
        reededGlassView.applyReededGlassEffect(with: targetImageView, widthType: .default)
    }

    @IBAction func segmentedControlValueChanged(segment: UISegmentedControl) {
        activitiIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.currentWidthIndex = segment.selectedSegmentIndex
            self.reededGlassView.setWidthType(to: self.currentWidthIndex == 0 ? .narrow 
                                                    : self.currentWidthIndex == 1 ? .default : .wide) {
                // Effect Applying completed
                self.activitiIndicator.stopAnimating()
            }
        }
    }
    
    @IBAction func imageShuffleButtonDidTap(_ sender: Any) {
        activitiIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let newImage = self.imageNames.filter{ $0 != self.currentImageName}.randomElement() ?? ""
            self.currentImageName = newImage
            self.targetImageView.image = UIImage(named: self.currentImageName)
            self.reededGlassView.applyReededGlassEffect(with: self.targetImageView, 
                                                        widthType: self.currentWidthIndex == 0 ? .narrow
                                                                    : self.currentWidthIndex == 1 ? .default : .wide) {
                // Effect Applying completed
                self.activitiIndicator.stopAnimating()
            }
        }
    }
}


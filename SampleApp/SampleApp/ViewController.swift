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
    
    // Sample images are downloaded via unsplash.com
    let imageNames = ["katsiaryna-endruszkiewicz-unsplash",
                      "alrick-gillard-unsplash",
                      "aiony-haust-unsplash",
                      "dom-hill-unsplash",
                      "alexander-krivitskiy-unsplash",
                      "gabriel-silverio-unsplash",
                      "albert-dera-unsplash",
                      "kimson-doan-unsplash",
                      "jurica-koletic-unsplash",
                      "clem-onojeghuo-unsplash"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(activitiIndicator)
        reededGlassView.setReededGlassEffect(with: targetImageView)
    }

    @IBAction func segmentedControlValueChanged(segment: UISegmentedControl) {
        activitiIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let selectedIndex = segment.selectedSegmentIndex
            self.reededGlassView.setWidthType(to: selectedIndex == 0 ? .narrow :
                                                  selectedIndex == 1 ? .default : .wide) {
                // Effect Applying completed
                self.activitiIndicator.stopAnimating()
            }
        }
    }
    
    @IBAction func imageShuffleButtonDidTap(_ sender: Any) {
        activitiIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.targetImageView.image = UIImage(named: self.imageNames.randomElement() ?? "")
            self.reededGlassView.setReededGlassEffect(with: self.targetImageView) {
                // Effect Applying completed
                self.activitiIndicator.stopAnimating()
            }
        }
    }
}


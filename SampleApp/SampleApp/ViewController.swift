//
//  ViewController.swift
//  SampleApp
//
//  Created by 서채희 on 2024/03/10.
//

import UIKit
import ReededGlassEffectView

class ViewController: UIViewController {
    @IBOutlet weak var targetImageView: UIImageView!
    @IBOutlet weak var reededGlassView: ReededGlassView!
    
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
        reededGlassView.setReededGlassEffect(with: targetImageView)
    }

    @IBAction func segmentedControlValueChanged(segment: UISegmentedControl) {
        let selectedIndex = segment.selectedSegmentIndex
        reededGlassView.setWidthType(to: selectedIndex == 0 ? .narrow :
                                        selectedIndex == 1 ? .default : .wide)
    }
    
    @IBAction func imageShuffleButtonDidTap(_ sender: Any) {
        targetImageView.image = UIImage(named: imageNames.randomElement() ?? "")
        reededGlassView.setReededGlassEffect(with: targetImageView)
    }
}


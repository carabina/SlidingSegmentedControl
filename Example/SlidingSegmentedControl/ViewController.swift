//
//  ViewController.swift
//  SlidingSegmentedControl
//
//  Created by DimaNakhratiants on 12/14/2017.
//  Copyright (c) 2017 DimaNakhratiants. All rights reserved.
//

import UIKit
import SlidingSegmentedControl

class ViewController: UIViewController, SlidingSegmentedControlDelegate {

    @IBOutlet weak var segmentedControl: SlidingSegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        segmentedControl.segments = ["mon", "tue", "wed", "thu", "fri", "sat", "sun"]
        segmentedControl.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func slidingSegmentedControl(didChangeSelectionFor segment: Int, selection: Bool) {
        print("one: \(segment) - \(selection)")
    }
    
    func slidingSegmentedControl(didEndSelecting segments: [Int]) {
        print("many: \(segments)")
    }

}


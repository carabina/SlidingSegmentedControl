//
//  SlidingSegmentedControl.swift
//  SlidingSegmentedControl
//
//  Created by Дима on 12.12.2017.
//  Copyright © 2017 Дима. All rights reserved.
//

import UIKit

@IBDesignable
public class SlidingSegmentedControl: UIView, SegmentDelegate {
    
    @IBInspectable var selectedColor: UIColor = UIColor.blue
    @IBInspectable var unselectedColor: UIColor = UIColor.white
   
    private var segmentStackView = UIStackView(frame: CGRect.zero)
    private var selection: Bool?
    
    public var delegate: SlidingSegmentedControlDelegate?
    
    public var segments: [String] = []{
        didSet{
            for segment in segmentStackView.arrangedSubviews{
                segmentStackView.removeArrangedSubview(segment)
                segment.removeFromSuperview()
            }
            for segment in segments{
                addSegment(with: segment)
            }
        }
    }

 
    
    public var selectedSegments: [Int]{
        get{
            guard let segments = segmentStackView.arrangedSubviews as? [Segment] else { return [] }
            return segments.indices.filter({segments[$0].isSelected})
        }
    }
    private var lastLocation: CGPoint?
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        self.layer.cornerRadius = 5
        segmentStackView.distribution = .fillEqually
        segmentStackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(segmentStackView)
        self.addConstraints([
            NSLayoutConstraint(item: segmentStackView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: segmentStackView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: segmentStackView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: segmentStackView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0)
            ])
        self.initGestures()
    }
    
    
    private func initGestures() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan(sender:)))
        self.addGestureRecognizer(panGestureRecognizer)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        roundRect()
    }
    
    
    @objc func onPan(sender: UIPanGestureRecognizer)  {
        if sender.numberOfTouches > 0 {
            guard let segments = segmentStackView.arrangedSubviews as? [Segment] else { return }
            let location =  sender.location(ofTouch: 0, in: self)
            if let lastLocation = self.lastLocation, let selection = self.selection{
                
                if let enteredSegment = segments.first(where: { segment in
                    return segment.frame.contains(location) && !segment.frame.contains(lastLocation)
                }){
                    //when drag enter segment
                    enteredSegment.isSelected = selection
                }
            }
            self.lastLocation = location
            if let beginSegment = segments.first(where: {$0.frame.contains(location)}){
                self.selection = beginSegment.isSelected
            }
            
            
        } else {
            delegate?.slidingSegmentedControl(didEndSelecting: selectedSegments)
            lastLocation = nil
            selection = nil
        }
    }
    
    public func addSegment(with title: String){
        let segment = Segment(title: title, delegate: self)
        segmentStackView.addArrangedSubview(segment)
        segment.tintColor = selectedColor
        segment.backgroundColor = unselectedColor
        segment.isSelected = false
        roundRect()
    }
    
    private func roundRect(){
        
        guard let segments = segmentStackView.arrangedSubviews as? [Segment],
            let firstSegment = segments.first,
            let lastSegment = segments.last else { return }
        let cornerRadius = self.frame.size.height/2.5
        
        for i in 1..<segments.count{
            segments[i].button.layer.maskedCorners = []
        }
        
        firstSegment.button.layer.cornerRadius = cornerRadius
        firstSegment.button.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        
        lastSegment.button.layer.cornerRadius = cornerRadius
        lastSegment.button.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        
    }
    
    fileprivate func segmentDidChangeSelection(segment: Segment, selection: Bool) {
        guard let segments = segmentStackView.arrangedSubviews as? [Segment],
            let index = segments.indices.first(where: {segments[$0] == segment})
            else { return }
        delegate?.slidingSegmentedControl(didChangeSelectionFor: index, selection: selection)
    }
    
    func segmentDidChangeSelection() {
        delegate?.slidingSegmentedControl(didEndSelecting: selectedSegments)
    }
    
}

fileprivate class Segment: UIView {
    
    var button = UIButton(type: .system)
    
    fileprivate var delegate: SegmentDelegate?
    
    var title: String = "segment"{
        didSet{
            button.setTitle(title, for: .normal)
        }
    }
    
    
    var isSelected: Bool = false{
        didSet{
            if isSelected != oldValue {
                delegate?.segmentDidChangeSelection(segment: self, selection: isSelected)
            }
            if isSelected {
                self.button.backgroundColor = tintColor
                self.button.setTitleColor(backgroundColor, for: .normal)
                button.layer.borderColor = tintColor.cgColor
            }else{
                self.button.backgroundColor = backgroundColor
                self.button.setTitleColor(tintColor, for: .normal)
                button.layer.borderColor = tintColor.cgColor
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    fileprivate init(title: String, delegate: SegmentDelegate){
        super.init(frame: CGRect.zero)
        self.delegate = delegate
        self.title = title
        commonInit()
    }
    
    private func commonInit(){
        button.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(button)
        self.addConstraints([
            NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: button, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0)
            ])
        
        button.layer.borderWidth = 1
        button.layer.borderColor = tintColor.cgColor
        button.setTitle(title, for: .normal)
        
        button.addTarget(self, action: #selector(didEndSegmentSelecting(_:)), for: .touchUpInside)
        button.addTarget(self, action: #selector(didBeginSegmentSelecting(_:)), for: .touchDown)
    }
    
    @objc func didEndSegmentSelecting(_ sender: UIButton) {
        delegate?.segmentDidChangeSelection()
    }
    @objc func didBeginSegmentSelecting(_ sender: Any) {
        self.isSelected = !self.isSelected
    }
    
}

public protocol SlidingSegmentedControlDelegate {
    func slidingSegmentedControl(didChangeSelectionFor segment: Int, selection: Bool)
    func slidingSegmentedControl(didEndSelecting segments: [Int])
}

fileprivate protocol SegmentDelegate {
    func segmentDidChangeSelection(segment: Segment, selection: Bool)
    func segmentDidChangeSelection()
}

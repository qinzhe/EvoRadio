//
//  ClockView.swift
//  EvoRadio
//
//  Created by Jarvis on 9/6/16.
//  Copyright © 2016 JQTech. All rights reserved.
//

import UIKit

class ClockView: UIControl {

    var timeLabel: UILabel!
    var dayLabel: UILabel!
    var lineView: UIView!
    
    var timer: Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        prepareUI()
        
        timer = Timer(timeInterval: 1, target: self, selector: #selector(timerHandle), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: RunLoopMode.commonModes)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let w = frame.size.width
        let h = frame.size.height
        
        lineView.frame = CGRect(x: 4, y: h*0.55, width: w-8, height: 1)
        timeLabel.frame = CGRect(x: 0, y: 2, width: w, height: h*0.55)
        dayLabel.frame = CGRect(x: 0, y: h*0.55, width: w, height: h*0.45)
    }
    
    deinit {
        if let _ = timer {
            timer?.invalidate()
            timer = nil
        }
    }
    
    func prepareUI() {
        clipsToBounds = true
        layer.cornerRadius = 4
        layer.borderWidth = 2
        layer.borderColor = UIColor.gray.cgColor
        backgroundColor = UIColor(netHex: 0x000000, alpha: 0.8)
        
        timeLabel = UILabel()
        addSubview(timeLabel)
        timeLabel.font = UIFont.sizeOf12()
        timeLabel.textColor = UIColor.white
        timeLabel.text = "00:00"
        timeLabel.textAlignment = .center
        
        dayLabel = UILabel()
        addSubview(dayLabel)
        dayLabel.font = UIFont.systemFont(ofSize: 8)
        dayLabel.textColor = UIColor.white
        dayLabel.text = "星期日"
        dayLabel.textAlignment = .center

        lineView = UIView()
        addSubview(lineView)
        lineView.backgroundColor = UIColor.grayColor3()
        
    }
    
    func timerHandle() {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateFormat = "EEEE-HH:mm"
        
        let formatterText = formatter.string(from: Date())
        let day_time = formatterText.components(separatedBy: "-")
        
        dayLabel.text = day_time.first
        timeLabel.text = day_time.last
    }
}
//
//  HomeTimerView.swift
//  swift_blp
//
//  Created by Apple on 10/19/23.
//

import UIKit

class HomeTimerView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    lazy var dateLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 30, width: kScreenWidth, height: 80))
        label.font = UIFont.systemFont(ofSize: 36)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.text = "0000:00:00";
        return label
        
    }()
    lazy var timeLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: self.dateLabel.bottomY, width: kScreenWidth, height: 50))
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "00:00:00";
        return label
        
    }()
    
    convenience init() {
        self.init(frame: CGRect(x: 0, y: kNavigationBar64, width: kScreenWidth, height: 150))
    }
    
    private override init(frame: CGRect) {
        
        super.init(frame: frame)
        _setSubViews()
            
    }
    
    func _setSubViews() {
        
        self.addSubview(self.dateLabel)
        self.addSubview(self.timeLabel)
        
        
        self.dateLabel.text = currentDate()
        self.timeLabel.text = currentTime()

        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerHandler), userInfo: nil, repeats: true)
        
    }
    
    @objc func timerHandler() {
//        self.timeLabel.text = currentTime()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

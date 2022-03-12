//
//  CustomSegmentedController.swift
//  NewsApp
//
//  Created by Ernest Mwangi on 25/02/2022.
//

import UIKit

protocol CustomSegmentedControlDelegate:class {
    func changeToIndex(index: Int)
}

@IBDesignable
class CustomSegmentedControl: UIControl {
    var buttons = [UIButton]()
    var selectedSegmentIndex = 0
    var selector:UIButton!
    
    weak var delegate:CustomSegmentedControlDelegate?
    
    @IBInspectable
    var selectorColor: UIColor = UIColor.black {
        didSet {
            updateView()
        }
    }
    @IBInspectable
    var fontSize: CGFloat = CGFloat(13) {
        didSet {
            selector.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize)
            selector.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize)
        }
    }
    @IBInspectable
    var commaSeperatedButtonTitles: String = "" {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var cornerRadius: Int = 10 {
        didSet {
            layer.cornerRadius = CGFloat(cornerRadius)
        }
    }
    
    func updateView() {
        layer.cornerRadius = frame.height / 2
        layer.masksToBounds = true
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        buttons.removeAll()
        subviews.forEach {
            $0.removeFromSuperview()
        }
        let btnTitles = commaSeperatedButtonTitles.components(separatedBy: ",")
        for btntitle in btnTitles {
            let button = UIButton(type: .system)
            button.setTitle(btntitle, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize)
            button.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            button.layer.borderWidth = 3
            button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
            buttons.append(button)
        }
        
        let selectorWidth = frame.width / CGFloat(buttons.count)
        
        let sv = UIStackView(arrangedSubviews: buttons)
        sv.axis = .horizontal
        sv.distribution = .fillProportionally
        sv.alignment = .fill
        sv.translatesAutoresizingMaskIntoConstraints = false
        addSubview(sv)
        sv.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        sv.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        sv.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        sv.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        selector = UIButton(frame: CGRect(x: 0, y: 0, width: selectorWidth , height: frame.height))
        selector.setTitle(btnTitles[0], for: .normal)
        selector.setTitleColor(Colors.segment_bg_clr, for: .normal)
        selector.backgroundColor = selectorColor
        selector.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize)
        selector.layer.cornerRadius = frame.height / 2
        addSubview(selector)
        bringSubviewToFront(selector)
    }
    

    override func draw(_ rect: CGRect) {
    
         updateView()
    }
    
    
    override func layoutSubviews() {
         
    }
    
    func setIndex(index:Int) {
               buttons.forEach({ $0.setTitleColor(Colors.segment_bg_clr, for: .normal) })
               let button = buttons[index]
                selectedSegmentIndex = index
               button.setTitleColor(Colors.black, for: .normal)
               let selectorPosition = frame.width/CGFloat(buttons.count) * CGFloat(index)
                UIView.animate(withDuration: 0.3, animations: {
                    self.selector.frame.origin.x = selectorPosition
                    
                })
                
                for (btnIndex,btn) in buttons.enumerated() {
                    if btn == button {
                        let btnTitles = commaSeperatedButtonTitles.components(separatedBy: ",")
                        selector.setTitle(btnTitles[btnIndex], for: .normal)
                        btn.setTitleColor(Colors.segment_bg_clr, for: .normal)
                        selectedSegmentIndex = btnIndex
                        delegate?.changeToIndex(index: selectedSegmentIndex)
                        let selectorStartPosition = frame.width / CGFloat(buttons.count) * CGFloat(btnIndex)
                        UIView.animate(withDuration: 0.3, animations: {
                            self.selector.frame.origin.x = selectorStartPosition
                        })
                    } else {
                        btn.setTitleColor(.black, for: .normal)
                    }
                }
                
           }
    
    @objc func buttonTapped(button: UIButton) {
        for (btnIndex,btn) in buttons.enumerated() {
            if btn == button {
                let btnTitles = commaSeperatedButtonTitles.components(separatedBy: ",")
                selector.setTitle(btnTitles[btnIndex], for: .normal)
                btn.setTitleColor(Colors.segment_bg_clr, for: .normal)
                selectedSegmentIndex = btnIndex
                delegate?.changeToIndex(index: selectedSegmentIndex)
                let selectorStartPosition = frame.width / CGFloat(buttons.count) * CGFloat(btnIndex)
                UIView.animate(withDuration: 0.3, animations: {
                    self.selector.frame.origin.x = selectorStartPosition
                })
            } else {
                btn.setTitleColor(.black, for: .normal)
            }
        }
        sendActions(for: .valueChanged)
    }

}

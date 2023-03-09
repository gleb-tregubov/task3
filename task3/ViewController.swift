//
//  ViewController.swift
//  task3
//
//  Created by Gleb Tregubov on 08.03.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var animator = UIViewPropertyAnimator(duration: 0.2, curve: .linear)
    var slider: UISlider!
    var rect: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }
    
    func configureViews() {
        slider = UISlider(frame: .zero)
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(handler(sender:)), for: .valueChanged)
        slider.addTarget(self, action: #selector(handlerCancel(sender:)), for: .touchUpInside)
        view.addSubview(slider)
        
        NSLayoutConstraint.activate([
            slider.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            slider.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            slider.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100)
        ])
        
        
        rect = UIView(frame: .zero)
        rect.backgroundColor = .systemGray
        
        rect.layer.cornerRadius = 5
        rect.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rect)
        
        NSLayoutConstraint.activate([
            rect.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            rect.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            rect.widthAnchor.constraint(equalToConstant: 50),
            rect.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        animator.pausesOnCompletion = true

        animator.addAnimations { [weak self, rect] in
            let transform = CGAffineTransform(rotationAngle: 90 * .pi/180)
                .concatenating(CGAffineTransform(scaleX: 1.5, y: 1.5))
            rect!.transform = transform
            let newBounds = CGRectApplyAffineTransform(rect!.bounds, transform)
            rect!.center.x = (UIScreen.main.bounds.size.width - self!.view.layoutMargins.right)  + newBounds.midX
        }

    }
    
    @objc
    func handler(sender: UISlider) {
        animator.fractionComplete = CGFloat(sender.value)
    }
    
    @objc
    func handlerCancel(sender: UISlider) {
        slider.setValue(1, animated: true)
        animator.startAnimation()
    }
}

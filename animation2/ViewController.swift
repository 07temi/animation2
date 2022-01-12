//
//  ViewController.swift
//  animation2
//
//  Created by Артем Черненко on 11.01.2022.
//

import Spring

class ViewController: UIViewController {

    private let animations = Spring.AnimationPreset.allCases.map({ "\($0)" })
    private let curves = Spring.AnimationCurve.allCases.map({ "\($0)" })
    private var indexEffect = 0
    
    @IBOutlet weak var springAnimationView: SpringView!
    @IBOutlet weak var animationNameLabel: UILabel!
    @IBOutlet weak var curveNameLabel: UILabel!
    @IBOutlet weak var forceValueLabel: UILabel!
    @IBOutlet weak var durationValueLabel: UILabel!
    @IBOutlet weak var delayValueLabel: UILabel!
    @IBOutlet weak var nextAnimationButton: SpringButton!
    
    @IBAction func runSpringAnimation(_ sender: Any) {
        let animation = setNextEffect(effects: animations, effectIndex: indexEffect)
        let curve = setNextEffect(effects: curves, effectIndex: indexEffect)
        
        if !animation.nextAvailable {
            indexEffect = 0
        }
        if !curve.nextAvailable {
            indexEffect = 0
        }
        
        springAnimationView.animation = animation.effect
        springAnimationView.curve = curve.effect
        
        springAnimationView.force = CGFloat(Float.random(in: 0.1...2))
        springAnimationView.duration = CGFloat(Float.random(in: 0.1...2))
        springAnimationView.delay = CGFloat(Float.random(in: 0.1...2))
        
        setTitles(for: animationNameLabel,
                       curveNameLabel,
                       forceValueLabel,
                       durationValueLabel,
                       delayValueLabel)
        
        nextAnimationButton.setTitle("Run \(animation.nextEffect)", for: .normal)
        
        springAnimationView.animate()
        indexEffect += 1
    }
    
    private func setTitles(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case animationNameLabel:
                label.text = "preset: \(springAnimationView.animation)"
            case curveNameLabel:
                label.text = "curve: \(springAnimationView.curve)"
            case forceValueLabel:
                label.text = "force: \(formatString(value: springAnimationView.force))"
            case durationValueLabel:
                label.text = "duration: \(formatString(value: springAnimationView.duration))"
            default:
                label.text = "delay: \(formatString(value: springAnimationView.delay))"
            }
        }
    }
}

private func formatString (value: CGFloat) -> String {
    String(format: "%.2f", value)
}


private func setNextEffect(effects: [String], effectIndex: Int) -> (effect: String, nextEffect: String, nextAvailable: Bool) {
    
    var currentEffect = ""
    var nextEffect = ""
    var nextAvailable = false
    
    if effects.indices.contains(effectIndex) {
        currentEffect = effects[effectIndex]
        nextAvailable = true
    } else {
        currentEffect = effects.first ?? ""
    }
    
    if effects.indices.contains(effectIndex + 1) {
        nextEffect = effects[effectIndex + 1]
        nextAvailable = true
    } else {
        nextEffect = effects.first ?? ""
    }
    
    return(currentEffect, nextEffect, nextAvailable)
}

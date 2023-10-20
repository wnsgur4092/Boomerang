//
//  LottieHandler.swift
//  Boomerang
//
//  Created by JunHyuk Lim on 20/10/2023.
//

import Foundation
import Lottie
import SwiftUI

struct LottieHandler : UIViewRepresentable {
    let name : String
    let loopMode : LottieLoopMode
    let animationSpeed : CGFloat
    
    init(name: String, loopMode: LottieLoopMode, animationSpeed: CGFloat) {
        self.name = name
        self.loopMode = loopMode
        self.animationSpeed = animationSpeed
    }
    
    func makeUIView(context: Context) -> some UIView {
        let animationView = LottieAnimationView(name: name)
        animationView.loopMode = loopMode
        animationView.animationSpeed = animationSpeed
        animationView.play()
        return animationView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}

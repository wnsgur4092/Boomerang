//
//  OnBoardingPhase.swift
//  Boomerang
//
//  Created by JunHyuk Lim on 20/10/2023.
//

import SwiftUI

struct OnBoardingPhase: View {
    var lottieFileName : String
    var mainText : String
    var subText : String
    
    var body: some View {
        VStack(alignment: .center, spacing: 20){
            LottieHandler(name: lottieFileName, loopMode: .loop, animationSpeed: 1.2)
                .frame(width: 350, height: 350)
                .scaleEffect(0.8)
            
            Text(mainText)
                .font(Font.mediumFont(size: 20))
            
            Text(subText)
                .font(Font.regularFont(size: 18))
                .multilineTextAlignment(.center)
            
        }
    }
}

#Preview {
    OnBoardingPhase(lottieFileName: "onBoarding", mainText: "Stop procrastinate to check", subText: "Check your notes in lock screen")
}

//
//  OnBoardingView.swift
//  Boomerang
//
//  Created by JunHyuk Lim on 20/10/2023.
//

import SwiftUI

struct OnBoardingView: View {
    @AppStorage("hasSeenOnBoarding") var hasSeenOnBoarding: Bool = false
    @State private var selectedPhase = 0
    
    var body: some View {
        VStack {
            //HEADER
            HStack{
                Text("Boomerang")
                    .font(Font.boldFont(size: 24))
                
                Spacer()
            }
            
            TabView(selection: $selectedPhase) {
                //PHASE 1
                phaseOne
                .tag(0)
                
                //PHASE 2
                phaseTwo
                .tag(1)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        .padding(20)
    }
    
    //MARK: - COMPONENTS
    fileprivate var phaseOne : some View {
        VStack(alignment: .center, spacing: 20){
            OnBoardingPhase(lottieFileName: "onBoarding", mainText: "Stop Procrastinate to Check", subText: "Check your notes in lock screen")
            
            Spacer()
            
            VStack(spacing: 20){
                phaseIndicator()
                navigationButton()
            }
        }
    }
    
    fileprivate var phaseTwo : some View {
        VStack(alignment: .center, spacing: 20){
            OnBoardingPhase(lottieFileName: "onBoarding2", mainText: "Allow to send notification", subText: "Check your notes from the notification center")
            
            Spacer()
            
            VStack(spacing: 20){
                phaseIndicator()
                navigationButton()
            }
        }
    }
    
    func phaseIndicator() -> some View {
        HStack{
            ForEach(0..<2) { phase in
                Rectangle()
                    .fill(Color.onMainColor)
                    .frame(width: phase == selectedPhase ? 20 : 10, height: 5)
                    .cornerRadius(2.5)
            }
        }
    }
    
    func navigationButton() -> some View {
        Button(action: {
            if selectedPhase < 1 {
                selectedPhase += 1
            } else {
                requestNotificationPermission()
                hasSeenOnBoarding = true
            }
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 28)
                    .fill(Color.onMainColor)
                    .frame(height: 60)
                
                if selectedPhase == 1 {
                    HStack {
                        Text("Get Start")
                            .font(Font.mediumFont(size: 20))
                            .foregroundColor(.white)
                        
                        Image(systemName: "arrow.right")
                            .foregroundColor(.white)
                    }
                    .offset(x: 10)
                } else {
                    HStack {
                        Text("Next")
                            .font(Font.mediumFont(size: 20))
                            .foregroundColor(.white)
                        
                        Image(systemName: "arrow.right")
                            .foregroundColor(.white)
                    }
                    .offset(x: 10)
                }
            }
            .frame(maxWidth: .infinity)
        })
    }
        
    func requestNotificationPermission() {
            let notificationCenter = UNUserNotificationCenter.current()
            notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                if granted {
                    print("Notification permission granted.")
                } else if let error = error {
                    print(error.localizedDescription)
                    print("Notification permission denied.")
                }
            }
        }

}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}

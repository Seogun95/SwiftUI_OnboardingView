//
//  IntroView.swift
//  SwiftUI_OnboardingView
//
//  Created by Seogun Kim on 2021/05/18.
//

import SwiftUI

struct IntroView: View {
    @AppStorage("start_view") var currentUserProfile: Bool = false

    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [Color.peach, Color.PaleOrange]), center: .center, startRadius: 5, endRadius: UIScreen.main.bounds.height)
                
                .ignoresSafeArea()
            
            if currentUserProfile {
                ProFileView()
                    .transition(AnyTransition.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .top)))
            } else {
                onboardingViews()
            }
        }
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}
    
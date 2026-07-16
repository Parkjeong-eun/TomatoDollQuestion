//
//  SplashView.swift
//  TomatoDollQuestion
//
//  Created by 박정은 on 7/17/26.
//

import SwiftUI

struct SplashView: View {
    var body: some View {

            VStack(spacing: 16) {
                Image("AppLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding(.bottom, 50)
            }
    }
}


#Preview {
    SplashView()
}

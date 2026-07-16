//
//  ContentView.swift
//  TomatoDollQuestion
//
//  Created by 박정은 on 7/17/26.
//

import SwiftUI

struct ContentView: View {
    @State private var showSplash = true

    var body: some View {
        ZStack {
            if showSplash {
                SplashView()
                    .transition(.opacity)
            } else {
                TabView {
                    CameraPreviewView()
                        .tabItem {
                            Label("카메라", systemImage: "camera")
                        }

                    AnswerListView()
                        .tabItem {
                            Label("기록", systemImage: "list.bullet")
                        }
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation(.easeOut(duration: 0.3)) {
                    showSplash = false
                }
            }
        }
    }
}

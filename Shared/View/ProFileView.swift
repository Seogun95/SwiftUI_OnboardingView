//
//  ProFileView.swift
//  SwiftUI_OnboardingView
//
//  Created by Seogun Kim on 2021/05/18.
//

import SwiftUI

struct ProFileView: View {
    @AppStorage("name") var currentUserName: String?
    @AppStorage("age") var currentUserAge: Int?
    @AppStorage("gender") var currentUserGender: String?
    @AppStorage("start_view") var currentUserProfile: Bool = false
    
    var body: some View {
        VStack {
           
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .foregroundColor(.PaleBlue)
                .padding()
            
            
            VStack(alignment: .leading, spacing: 10) {
                
            Text("이름 : \(currentUserName ?? "unKnown")")
            Text("나이 : \(currentUserAge ?? 20)")
            Text("성별 : \(currentUserGender ?? "unKnown")")
            }
            
            Button(action: {
                signOut()
            }, label: {
                Text("로그아웃")
                    .font(.title3)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.PaleBlue)
                    .cornerRadius(20)
            })
            .padding(20)
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
        .padding(.horizontal, 20)
    }
    func signOut() {
        currentUserName = nil
        currentUserAge = nil
        currentUserGender = nil
        currentUserProfile = false
    }
}

struct ProFileView_Previews: PreviewProvider {
    static var previews: some View {
        ProFileView()
    }
}

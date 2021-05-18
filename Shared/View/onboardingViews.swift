//
//  onboardingViews.swift
//  SwiftUI_OnboardingView
//
//  Created by Seogun Kim on 2021/05/18.
//

import SwiftUI

// MARK: BODY
struct onboardingViews: View {
    @State var onboardingState: Int = 0
    @State var name: String = ""
    @State var age: Double = 6
    @State var gender: String = ""
    @State var showAlert: Bool = false
    @State var AlertTitle: String = ""
    
    @AppStorage("name") var currentUserName: String?
    @AppStorage("age") var currentUserAge: Int?
    @AppStorage("gender") var currentUserGender: String?
    @AppStorage("start_view") var currentUserProfile: Bool = false
    
    //gender
    let filterOption: [String] = [
        "남성", "여성", "선택안함"
    ]
    //애니메이션
    let transition: AnyTransition = .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
    
    
    var body: some View {
        ZStack {
            
            ZStack {
                switch onboardingState {
                case 0:
                    welcomUserView
                        .transition(transition)
                case 1:
                    addUserName
                        .transition(transition)
                case 2:
                    addUserAge
                        .transition(transition)
                case 3:
                    addUserGender
                        .transition(transition)
                    
                default:
                    addUserName
                }
            }
            VStack {
                Spacer()
                signInButton
                    .padding()
                    .padding(.bottom, 30)
            }
            .alert(isPresented: $showAlert, content: {
                return Alert(title: Text(AlertTitle), message: nil, dismissButton: .default(Text("확인")))
            })
        }
    }
}


//MARK: EXTENSIONS


extension onboardingViews {
    private var signInButton: some View {
        
        Text(onboardingState == 0 ? "회원가입" : onboardingState == 3 ? "완료" : "계속하기")
            .font(.title3)
            .foregroundColor(.black)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(Color.white)
            .cornerRadius(20)
            .onTapGesture {
                handleButton()
            }
    }
    
    private var welcomUserView: some View {
        VStack(spacing: 20) {
            Spacer()
            Text("원하는것을 찾으세요")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Image(systemName: "books.vertical.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .foregroundColor(.white)
            
            Text("이 앱은 지금까지 배워본 SwiftUI 기본 기능에 대해 하나 하나 씩 사용해가면서 익혀보기 위한 최고의 앱입니다.")
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            
            Spacer()
            Spacer()
        }
        .padding()
    }
    
    private var addUserName: some View {
        VStack(spacing: 20) {
            Spacer()
            Text("이름이 무엇인가요?")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            TextField("이름을 이곳에 입력해주세요", text: $name)
                .padding()
                .font(.title3)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .background(Color.white)
                .cornerRadius(20)
                .disableAutocorrection(true)
            
            Spacer()
            Spacer()
        }
        .padding()
    }
    
    private var addUserAge: some View {
        VStack(spacing: 20) {
            Spacer()
            Text("나이는 몇세 이신가요?")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text("\(age,specifier: "%.0f")세")
                .font(.title3)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .background(Color.white)
                .cornerRadius(20)
            
            Slider(value: $age, in: 6...70, step: 1)
                .accentColor(.white)
            
            Spacer()
            Spacer()
        }
        .padding()
    }
    private var addUserGender: some View {
        VStack(spacing: 20) {
            Spacer()
            Text("사용자의 성별")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Picker(selection: $gender,
                   label:
                    Text(gender.count > 1 ? gender : "성별을 선택해주세요")
                    .font(.title3)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(Color.white)
                    .cornerRadius(20)
                   ,
                   content: {
                    ForEach(filterOption, id: \.self) { data in
                        HStack {
                            Image(systemName: "person.fill")
                            Text(data)
                        }
                        .tag(data)
                    }
                   })
                .pickerStyle(MenuPickerStyle())
            
            Spacer()
            Spacer()
        }
        .padding()
    }
}

extension onboardingViews {
    func handleButton() {
        
        switch onboardingState {
        case 1:
            guard name.count > 1 else {
                getAlert(title: "두 글자 이상 입력해주세요")
                return
            }
        case 3:
            guard gender.count > 1 else {
                getAlert(title: "성별이 선택되지 않았습니다")
                
                return
            }
        default:
            break
        }
        
        if onboardingState == 3 {
            signIn()
        } else {
            withAnimation(.spring()) {
                onboardingState += 1
            }
        }
    }
    
    func getAlert(title: String) {
        AlertTitle = title
        showAlert.toggle()
    }
    func signIn() {
        currentUserName = name
        currentUserAge = Int(age)
        currentUserGender = gender
        currentUserProfile = true
    }
}

// MARK: PREVIEWS
struct onboardingViews_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            onboardingViews()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(RadialGradient(gradient: Gradient(colors: [Color.peach, Color.PaleOrange]), center: .center, startRadius: 5, endRadius: 500))
                .ignoresSafeArea()
        }
    }
}

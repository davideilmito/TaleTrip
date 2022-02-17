//
//  HomeView.swift
//  Taletrip
//
//  Created by Willy Merlet on 14/02/22.
//
import SwiftUI
import AVFoundation
import SwiftSpeech

struct HomeView: View {
    
    var sessionConfiguration: SwiftSpeech.Session.Configuration
    
    @State private var text = ""
    
    public init(sessionConfiguration: SwiftSpeech.Session.Configuration) {
        self.sessionConfiguration = sessionConfiguration
    }
    
    public init(locale: Locale = .current) {
        self.init(sessionConfiguration: SwiftSpeech.Session.Configuration(locale: locale))
    }
    
    public init(localeIdentifier: String) {
        self.init(locale: Locale(identifier: localeIdentifier))
    }
    
   
    
    func text2Speech() {
    do {
        try AVAudioSession.sharedInstance().setCategory(.playback,mode: .default)
        
    } catch let error {
        print("\(error.localizedDescription)")
    }
    let speechUtterance: AVSpeechUtterance = AVSpeechUtterance(string: "\(desc[index])")
    speechUtterance.rate = AVSpeechUtteranceMaximumSpeechRate / 2.0
    speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-US")
    
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(speechUtterance)
}
    func text2Speeech() {
    do {
        try AVAudioSession.sharedInstance().setCategory(.playback,mode: .default)
        
    } catch let error {
        print("\(error.localizedDescription)")
    }
    let speechUtterance: AVSpeechUtterance = AVSpeechUtterance(string: "\(intro)")
    speechUtterance.rate = AVSpeechUtteranceMaximumSpeechRate / 2.0
    speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-US")
    
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(speechUtterance)
}
    enum Fsm {
        case wait, response, check
    }
    
    @State var state: Fsm = .wait
    @State var index: Int = 0
    @State var die: Int = 0
    @State var list: [(session: SwiftSpeech.Session, text: String)] = []
    
    let desc = [
        /*0*/"Perfect. Some choices are more difficult than others and will require the roll of dice. You don’t truly remember how to get to the bar, but fortunately you have a map. Try using the map.",
        /*1*/"You get lost a couple of times, but in the end you arrive at your destination.",
        /*2*/"With the help of the map you easily arrive at your destination."
    ]
    let intro = "You are working as private investigators in Cramwood. After you got paid for a very difficult case solved, you wanted to take some days off work. You had the idea to go together to a bar, but living in such a small city, there are very few options when it comes to it.\n\nLet’s try to make a choice. This is the first one of many that you are going to do in this adventure. Would you like to go to “Puzzles” or “Beer Garden”?\n"
    let answer = "Go to beer garden"
    let answer2 = "Use map"
    
    func correct() {
            print("answer matched")
            index += 1
            text2Speech()
            state = .response
            
            text = ""
    }
    func wrong() {
        if (text != answer) {
            print("answer not matched")
            state = .wait
           
        }
    }
    var body: some View {
        VStack {
            HStack(spacing: 10){
                Image("story")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .cornerRadius(15)
                VStack(alignment: .leading){
                    Text("The Detective's Day Off")
                        .fontWeight(.bold)
                    Text("Chapter 1")
                }
                .frame(width: 200)
                .padding(.trailing, 35)
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
              
            }
            .frame(width: UIScreen.screenWidth - 20)
            .padding(.top, 20)
            ScrollView{
                   Text(intro)
                    .padding()
                    .padding(.trailing, 15)
                    .lineSpacing(6)
                    .onAppear(perform: {
                        text2Speeech()
                    })
                
                
                    Spacer()
                    
                    ForEach(list, id: \.session.id) { pair in
                        VStack(alignment: .trailing){
                        Text(pair.text)
                            .fontWeight(.bold)
                            .foregroundColor(Color("bluish"))
                            .autocapitalization(.none)
                            .frame(width: 150)
                            .padding(.trailing, 35)
                            .padding(.bottom, 20)
                        }.frame(width: 100)
                        ForEach(desc, id: \.self) { chunk in
                         Group {
                                if (pair.text == answer) {
                                    Text(chunk)
                                        .padding()
                                        .padding(.trailing, 15)
                                        .lineSpacing(6)
                                        .onAppear(perform: {
                                         correct()
                                        })
                                }
                            }
                            
                         }
                }
            
           
                switch index {
                case 0:
                    VStack{
//                        if (text == answer) {
//                           Text("")
//                                .onAppear{
//                                    correct()
//
//                                }
//                        } else {
//                            Text("")
//                                .onAppear{
//                                    wrong()
//
//                                }
//                        }
                        Text("")
                    }
                case 1:
                    VStack{
//                        if(text == answer2) {
//                            Text("")
//                                .onAppear{
//                                    correct()
//                                }
//                        } else {
//                            Text("")
//                                .onAppear{
//                                    wrong()
//                                }
//                        }
                        Text("")
                    }
                   
                    
                    //                }
                    //                else if (state == .response) {
                    //                    //voice talking
                    //                    //when it stops
                    //                    state = .check
                    //                }
                    //                else if (state == .check) {
                    //                    //checks for boolean var
                    //                    state = .wait
                    //                }
                default:
                    //                if(state == .wait) {
                    Button("Test") {
                        index = 0
                        state = .response
                    }
                    .foregroundColor(Color.white)
                    .background(Color.blue)
                    .padding()
                    //               }
                    //                else if (state == .response) {
                    //                    //voice

                    //                    //when it stops
                    //                    state = .check
                    //                }
                    //                else if (state == .check) {
                    //                    //checks for boolean var
                    //                    state = .wait
                    //                }
                }
            Spacer()
                SwiftSpeech.RecordButton()
                    .swiftSpeechToggleRecordingOnTap(sessionConfiguration: sessionConfiguration, animation: .spring(response: 0.4, dampingFraction: 0.4, blendDuration: 0))
                    .onStartRecording { session in
                        list.append((session, ""))
                    }
                    .onRecognize(includePartialResults: true) { session, result in
                        list.firstIndex { $0.session.id == session.id }
                            .map { index in
                                list[index].text = result.bestTranscription.formattedString + (result.isFinal ? "" : "...")
                            }
                    } handleError: { session, error in
                        list.firstIndex { $0.session.id == session.id }
                            .map { index in
                                list[index].text = "Error \((error as NSError).code)"
                            }
                    }
         }
        }
        .padding(.top, 35)
        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
        .background(Color("beige"))
        .onAppear
                    {
                SwiftSpeech.requestSpeechRecognitionAuthorization()
                    }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}




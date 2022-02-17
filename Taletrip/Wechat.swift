//
//  ContentView.swift
//  Taletrip
//
//  Created by Willy Merlet on 14/02/22.
//

import SwiftUI
import AVFoundation
import SwiftSpeech

struct ComeView: View {
    
    var locale: Locale
    
    
    
    
    public init(locale: Locale = .autoupdatingCurrent) {
        self.locale = locale
    }
    
    public init(localeIdentifier: String) {
        self.locale = Locale(identifier: localeIdentifier)
    }
    
    
    
    func text2Speech(ind: Int) {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback,mode: .default)
            
        } catch let error {
            print("\(error.localizedDescription)")
        }
        text = desc[ind]
        let speechUtterance: AVSpeechUtterance = AVSpeechUtterance(string: "\(text)")
        //speechUtterance.rate = AVSpeechUtteranceMaximumSpeechRate / 2.0
        speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(speechUtterance)
    }
    
    enum Fsm {
        case wait, response, check
    }
    
    @State var state: Fsm = .response
    @State var index: Int = 0
    @State var die: Int = 0
    @State var indT: Int = 0
    @State var list: [(session: SwiftSpeech.Session, text: String)] = []
    
    @State var text = "ciuakjvjgcjgcvmnbgcn"
    
    @State var desc = [
        /*0*/"You are working as private investigators in Cramwood. After you got paid for a very difficult case solved, you wanted to take some days off work. You had the idea to go together to a bar, but living in such a small city, there are very few options when it comes to it.\n\nLet’s try to make a choice. This is the first one of many that you are going to do in this adventure. Would you like to go to “Puzzles” or “Beer Garden”?\n",
             /*1*/"Perfect. Some choices are more difficult than others and will require the roll of dice. You don’t truly remember how to get to the bar, but fortunately you have a map. Try using it.\n",
             /*2*/"You get lost a couple of times, but in the end you arrive at your destination.\n",
             /*3*/"With the help of the map you easily arrive at your destination.\n",
             /*4*/"From outside the bar seems to be really small. There are a couple of windows, but you can’t see the inside because they are completely covered by some old and dusty curtains. The neon signboard flickers from time to time, leaving the rest of the alleyway in darkness for short periods of time. You push the metal door, with the open sign hanging, and enter the bar.\nThe whole place is a lot bigger than it seemed, but it’s still not that spacious. Maybe it’s just because it’s crowded with tables and seats, which, except for two ladies talking, are empty. The walls are covered in an old purple wallpaper. At the right there's the counter, with a bartender working behind it. At the left there is an old jukebox with a guy desperately trying to make it stop playing and a pool table with two men playing. At the back of the room there are the toilets.\n",
             /*5*/"An intimidating man in his fifties, maybe even more. He is really tall and has broad shoulders. Behind him, on the wall, there is a medal of courage that he got during an obscure war in the east. He has a limp, probably a memory of his life as a soldier.\n",
             /*6*/"New faces, huh? We don’t see new faces here often. My name is John, do you want a drink? Since you are new, the first one is on the house.\n",
             /*7*/"Have you seen the medal? Yeah, I was a soldier. Actually I am a soldier, in a way I feel like I never left the war… But let’s not talk about that now, shall we?\n",
             /*8*/"Hope you like the drink.\n",
             /*9*/"Two rough men are playing a game of pool table. They are not talking a lot, so it’s difficult to say if they know each other at all. The game is about even.\n",
             /*10*/"We are having a serious game, if you want to talk, offer us a drink first at least.\n",
             /*11*/"Ah, now we are talking… We are CJ and Rob. You seem cool, maybe later we could play together. We like to have really big stakes in our games, so maybe don’t interrupt us again.\n",
             /*12*/"You don’t think it’s a good idea.\n",
             /*13*/"A dude of eastern origin in his thirties. He is so nervous that he is trembling. Even his fixation with the jukebox tells you that something is wrong with him.\n",
             /*14*/"I really hate this stupid song. Why won’t this jukebox just shut up? I have an important meeting here in a bit. Yeah, I know, I know… It’s not the best place to do so, but I needed an inconspicuous place. Ok, I’m talking too much maybe… I need a cigarette.\n",
             /*15*/"Oh… that’s nice of you. I’m Omar. As I said I have to meet someone really important in a bit, this will help me relax. Thanks.\n",
             /*16*/"Two ladies are talking while sipping really colorful drinks with straws. They seem to be old friends catching up on their lives. They are talking friendly, but they are somewhat stiff.\n",
             /*17*/"Hi, we are Veronica and Jessica. Maybe join us for a smoke after we finish this conversation.\n",
             /*18*/"A cigarette for that guy over there? Yeah sure, if he’d help him calm down, he’s been really annoying… and I wanted to quit smoking anyway…\n",
             /*19*/"I finished my cigarettes, sorry!\n",
             /*20*/"You don’t feel the need right now. Maybe later?\n",
             /*21*/"The Medal of Courage was awarded to John Carter almost 30 years ago. It’s still shiny, he probably cleans it with pride regularly.\n",
             /*22*/"The pavement is a gray moquette mostly clean, the big exception is a big wine stain near one of the tables. There is a cobweb in one corner of the ceiling. Behind the counter there are a bunch of shelves full of colorful bottles of liquor.\n",
             /*23*/"You don’t feel like drinking right now.\n",
             /*24*/"Omar finally lets go of his fixation with the jukebox and starts to go outside to smoke his cigarette. In doing so though, probably because he is still thinking about his meeting, he bumps into CJ and he falls on the table, moving all the cue balls. CJ and Rob get really angry, shouting at the poor guy and even pushing it from time to time while doing so. At that point John intervenes to calm them down, but to your surprise, when he sees Omar he sides with the two men. “We won the war, you know that right?”. You heard enough nonsense, you stop them from arguing and you let Omar go outside to smoke. The two ladies remain silent during the whole ordeal, exchanging strange looks with each other.\n\nThe atmosphere in the bar is really tense. The only thing breaking the silence is the repetitive jukebox. After five minutes, Omar enters the bar again and approaches you. “Thank you so much for what you did before… and the cigarette. If this meeting wasn’t a life or death thing, I would have left.” After telling you this, he goes sitting on a table at the end of the room, far away enough from everyone.\n\nSadly, the atmosphere didn’t really change, with CJ, Rob and John checking on Omar periodically and even Veronica and Jessica looking at him from time to time, exchanging just a few whispered words after each look. Then out of nowhere, the lights go off, it’s a blackout. You hear some movement in the room and then a big thump. After that, complete silence. “Don’t worry dear customers, I’m going to switch on the lights in a second.”. As soon as the lights are back on, there is a collective gasp. Omar is covered in blood and has a knife sticking out of his neck. The limp body rests on his table with the eyes still open. After a brief moment to realize what happened, you call the police. They arrive in five minutes. The chief of police is there too. “Ok, none will leave until we understand what happened here”.\n",
             /*25*/"Various policemen and policewomen are in front of the entrance. Amongst them there is the police chief: Belker. You have already collaborated with him in the past, he is a good and honest man, even if sometimes can seem a bit cold due to his job.\n",
             /*26*/"I see you are here too. Well, of course we are going to investigate what happened, but help us, will you? I have information that you don’t have, but you were here during the murder, so also the opposite is true.\n",
             /*27*/"I’m sorry, I know that you want to help but I can’t share with you that information.\n",
             /*28*/"I’m sorry but I really can’t reveal much. Let’s just say that I am here because I had to meet Omar for work related stuff.\n",
             /*29*/"Yeah, I get it. If we want your help, you’ll need the whole picture. Omar had a meeting with me, he was a key witness in an incoming case.\n",
             /*30*/"Are you ready to tell me who the culprit is?\nYes or no?\n",
             /*31*/"The intimidating man is the only one that has access to lots of knives. He was also the one that switched up the lights again and he seemed to despise Omar. But you need more than this to incriminate him.\n",
             /*32*/"Yeah, I know… I made a real scene, but  I was busy fixing the lights. Someone has killed that man, and that someone is not me.\n",
             /*33*/"Ok… You got me. I stabbed Omar, but I didn’t kill him. I was a soldier, ok? You have to believe me, when I got to him in the dark he was already dead. His face was on his table and he didn’t move or started screaming even when I stabbed him. If I wanted to kill him fast, I wouldn’t have stabbed him behind his neck. Inspect the corpse, I assure you I am right.\n",
             /*34*/"I told you. I don’t know what killed him, but I believe that it was something that doesn’t leave many traces. Maybe try to inspect the corpse again?\n",
             /*35*/"That could be it, yeah. Inspect the whole bar, toilets included for more clues.\n",
             /*36*/"The two rough men are completely silent. They don’t seem bothered by the police, even if they are suspects, it wouldn’t be surprising if this wasn’t the first time that they got in a situation like this. They also despised Omar, but a ruined game is not enough to incriminate them.\n",
             /*37*/"You wanna know about the stakes of our game? We like to bet a lot of money, but if you think that we killed Omar, you are completely wrong. We didn’t lose any money, we just have to restart the game, it’s not a problem to kill for. We would investigate John, all that war stuff was weird. Inspect the counter and see if there are any missing knives.\n",
             /*38*/"Inspect the counter and see if there are any missing knives.\n",
             /*39*/"The ladies are still talking with each other, even if they are just whispering right now. They also seemed off from the start in a way. Even if they are the least suspicious, their behavior is still very weird.\n",
             /*40*/"That was pretty crazy, right? We believe that Omar was killed by the men playing at the pool table. Have you seen how they shouted and pushed him before?\n",
             /*41*/"That is not ours, but it seems like it contained perfume maybe? We don’t know who left it there, sorry.\n",
             /*42*/"Ah, yeah. That was ours, it used to contain perfume, we left it in the toilet accidentally.\n",
             /*43*/"So you actually caught us. Congratulations. Yeah, the cigarette we gave him was poisoned. Omar was a key witness in the trial of Jessica’s son. We had to kill him to save her son from prison, not that matters now. Now go, tell the police.\n",
             /*44*/"The knife wound is deep and on the back of the neck. If someone wanted to kill this man this way is really slow and painful, but you didn’t hear any screams and the body was already dead when the lights were switched on… So what happened here?\n",
             /*45*/"Focusing on everything but the knife, you see some strange traces on his mouth. Did someone poison him? He didn’t drink anything though.\n",
             /*46*/"Do you want to go to the gentlemen’s or ladies’ toilet?\n",
             /*47*/"The toilet is not as clean as you’d hoped. Aside from that, there is nothing strange here.\n",
             /*48*/"You find a small empty glass vial in one of the stalls.\n",
             /*49*/"It’s empty. It seemed to contain some kind of liquid. It doesn’t smell at all. Did it contain poison?\n",
             /*50*/"There is one knife missing. They are really similar to the one that is in Omar’s neck.\n",
             /*51*/"The pavement is a gray moquette mostly clean, the big exception is a big blood stain near one of the tables. There is a cobweb in one corner of the ceiling. Behind the counter there are a bunch of shelves full of colorful bottles of liquor.\n",
             /*52*/"So, who do you think is the murderer? “John”, “CJ and Rob” or “Veronica and Jessica”?\n",
             /*53*/"The police take John away. You don’t think about it too much for the next few days, but it soon turns out that you incriminated the wrong person. The real murderer fled the country and is free.\nDo you want to try again?\n",
             /*54*/"The police take CJ and Rob away. You don’t think about it too much for the next few days, but it soon turns out that you incriminated the wrong person. The real murderer fled the country and is free.\nDo you want to try again?\n",
             /*55*/"The police take Veronica and Jessica away. They killed Omar in a futile attempt of saving Jessica’s son from prison, since Omar was the only witness that could incriminate him. The police department is grateful again for your help, even if it was supposed to be your day off.\n"
    ]
    
    let answer = "Go to beer garden"
    let answer2 = "Use map"
    let john = "Inspect John"
    let john1 = "Talk to John"
    
    func correct(ind: Int) {
        print("answer matched")
//        text = "mammamamia"
        index = ind
        text2Speech(ind: ind)
        // state = .response
    }
    func talkTo(ind: Int) {
      indT += ind
    }
    func wrong() {
        print("answer not matched")
        //state = .wait
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
                Text(desc[0])
                    .padding()
                    .padding(.trailing, 15)
                    .lineSpacing(6)
                    .onAppear(perform: {
                        text2Speech(ind: 0)
                    })
                VStack{
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
                         VStack {
                                if (pair.text == answer) {
                                    Text(desc[1])
                                        .padding()
                                        .padding(.trailing, 15)
                                        .lineSpacing(6)
                                        .onAppear(perform: {
                                            correct(ind: 1)
                                        })
                                }
                             if (pair.text == answer2) {
                                 if (die >= 4) {
                                     Text(desc[3])
                                         .padding()
                                         .padding(.trailing, 15)
                                         .lineSpacing(6)
                                         .onAppear(perform: {
                                             correct(ind: 2)
                                             die = Int.random(in: 1..<6)
                                         })
                                     Text(desc[4])
                                         .padding()
                                         .padding(.trailing, 15)
                                         .lineSpacing(6)
                                         .onAppear(perform: {
                                             correct(ind: 4)
                                         })
                                 } else {
                                     Text(desc[2])
                                         .padding()
                                         .padding(.trailing, 15)
                                         .lineSpacing(6)
                                         .onAppear(perform: {
                                             correct(ind: 2)
                                             die = Int.random(in: 1..<6)
                                         })
                                     Text(desc[4])
                                         .padding()
                                         .padding(.trailing, 15)
                                         .lineSpacing(6)
                                         .onAppear(perform: {
                                             correct(ind: 4)
                                         })
                                 }
                             }
                             if (pair.text == john) {
                                 Text(desc[5])
                                     .padding()
                                     .padding(.trailing, 15)
                                     .lineSpacing(6)
                                     .onAppear(perform: {
                                         correct(ind: 5)
                                         talkTo(ind: indT)
                                     })
                             } else if (pair.text == john1) {
                                 Text(desc[6])
                                     .padding()
                                     .padding(.trailing, 15)
                                     .lineSpacing(6)
                                     .onAppear(perform: {
                                         correct(ind: 6)
                                     })
                             }
                            }
                }
                }
//                switch index {
//                case 0:
//
//                    if (list.count > 0 ) {
//                         Text("\(list[list.count - 1].text)")
//                               .frame(height: 40, alignment: .trailing)
//                                .foregroundColor(Color("bluish"))
//                        if (list[list.count - 1].text == answer[0] || list[list.count - 1].text == answer[1]) {
//                            Text(desc[1])
//                                .padding()
//                                .padding(.trailing, 15)
//                                .lineSpacing(6)
//                                .onAppear {
//                                    correct(ind: 1)
//                                }
//                        }
//
//                            /*else {
//                           Text("")
//                           .onAppear{
//                           wrong()
//                           }
//                           }*/
//                    }
//
//                case 1:
//                    Text("\(list[list.count - 1].text)")
//                        .frame(height: 40, alignment: .trailing)
//                        .foregroundColor(Color("bluish"))
//                    if (list[list.count - 1].text == answer2) {
//                        Text(desc[2])
//                            .padding()
//                            .padding(.trailing, 15)
//                            .lineSpacing(6)
//                            .onAppear{
//                                correct(ind: 2)
//                            }
//                    } /*else {
//                       Text("")
//                       .onAppear{
//                       wrong()
//                       }
//                       }*/
//
//                    //                }
//                    //                else if (state == .response) {
//                    //                    //voice talking
//                    //                    //when it stops
//                    //                    state = .check
//                    //                }
//                    //                else if (state == .check) {
//                    //                    //checks for boolean var
//                    //                    state = .wait
//                    //                }
//                default:
//                    //                if(state == .wait) {
//                    Button("Test") {
//                        index = 0
//                        state = .response
//                    }
//                    .foregroundColor(Color.white)
//                    .background(Color.blue)
//                    .padding()
//                    //               }
//                    //                else if (state == .response) {
//                    //                    //voice
//
//                    //                    //when it stops
//                    //                    state = .check
//                    //                }
//                    //                else if (state == .check) {
//                    //                    //checks for boolean var
//                    //                    state = .wait
//                    //                }
//                }
                
                
                Spacer()
                
                                    
                
                
                
                Spacer()
                SwiftSpeech.RecordButton()
                    .swiftSpeechToggleRecordingOnTap(locale: self.locale,
                                                     animation: .spring(response: 0.3, dampingFraction: 0.3, blendDuration: 0))
                    .onStartRecording { session in
                        list.append((session, ""))
                    }.onCancelRecording { session in
                        _ = list.firstIndex { $0.session.id == session.id }
                        .map { list.remove(at: $0) }
                    }.onRecognize(includePartialResults: true) { session, result in
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

struct ComeView_Previews: PreviewProvider {
    static var previews: some View {
        ComeView()
    }
}


//extension UIScreen{
//   static let screenWidth = UIScreen.main.bounds.size.width
//   static let screenHeight = UIScreen.main.bounds.size.height
//   static let screenSize = UIScreen.main.bounds.size
//}

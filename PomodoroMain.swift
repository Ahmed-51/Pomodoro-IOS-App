//
//  PomodoroMain.swift
//  Pomodoro
//
//  Created by Ashfaq on 12/18/22.
//
// \
import SwiftUI

struct PomodoroMain: View {
    @State var progress: CGFloat = 0
    @State var timerStringValue: String = "00:00"
    
    @State var isStarted: Bool = false
    @State var addNewTimer: Bool = false
    @State var isPaused: Bool = false
    
    @State var hour: Int = 0
    @State var minutes: Int = 0
    @State var seconds: Int = 5
    
//    Total Seconds
    @State var totalSeconds = 0
    @State var staticTotalSeconds = 0
    
//    Post timer properties
    @State var isFinished: Bool = false
    
//    Textfield Values
    @State var textFieldValue = ""
    @State var hourValue = ""
    @State var minValue = ""
    @State var secValue = ""
    
    
    @State var dataArray : [String] = []
    
    func saveText(){
        hour = Int(hourValue) ?? 0
        minutes = Int(minValue) ?? 0
        seconds = Int(secValue) ?? 0
    }
    
    
    //    Start Timer
    func startTimer(){
        if !(hour == 0 && minutes == 0 && seconds == 0){
            withAnimation(.easeInOut(duration: 0.25)){isStarted = true}
            timerStringValue = "\(hour == 0 ? "" : "\(hour):")\(minutes >= 10 ? "\(minutes)":"0\(minutes)")\(seconds >= 10 ? "\(seconds)":"0\(seconds)")"
            //        Total seconds for timer animation
            totalSeconds = (hour * 3600) + (minutes * 60) + seconds
            staticTotalSeconds = totalSeconds
        }
    }
    //    Stop Timer
    func stopTimer(){
        withAnimation {
            isStarted = false
            hour = 0
            minutes = 0
            seconds = 0
            progress = 1
        }
        totalSeconds = 0
        staticTotalSeconds = 0
        timerStringValue = "00:00"
    }
    //    Pause Timer
    func pauseTimer(){
        isStarted = false
        isPaused = true
    }
    //    updatingTimer
    func updateTimer(){
        isStarted = true
        isPaused = false
        totalSeconds -= 1
        progress = CGFloat(totalSeconds) / CGFloat(staticTotalSeconds)
        progress = (progress < 0 ? 0 : progress )
        hour = totalSeconds / 3600
        minutes = (totalSeconds / 60) % 60
        seconds = (totalSeconds % 60)
        timerStringValue = "\(hour == 0 ? "" : "\(hour):")\(minutes >= 10 ? "\(minutes)":"0\(minutes)"):\(seconds >= 10 ? "\(seconds)":"0\(seconds)")"
        if hour == 0 && minutes == 0 && seconds == 0{
            isStarted = false
            print("Finished")
            isFinished = true
        }
    }
    var body: some View {
        VStack{
            Text("Pomodoro Timer")
                .font(.title2.bold())
                .foregroundColor(.white)
            GeometryReader{proxy in
                VStack(spacing: 15){
                    ZStack{
                        Circle()
                            .fill(.white.opacity(0.3))
                        Circle()
                            .trim(from: 0, to: 0.5)
                            .stroke(Color("Purple").opacity(0.7), lineWidth: 10)
                    }
                    .padding(60)
                    .frame(height: proxy.size.width)
                    
                }
                .frame(minWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            ZStack{
                Circle()
                    .fill(.white.opacity(0.03))
                    .padding(-40)
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(.white.opacity(0.03), lineWidth:80)
                Circle()
                    .stroke(.purple, lineWidth: 15)
                    .blur(radius: 15)
                    .padding(-2)
                Circle()
                //                    .fill(Color("BG"))
                    .fill(.gray.opacity(0.2))
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(.red.opacity(0.5), lineWidth: 15)
                Circle()
                    .fill(.blue)
                    .frame(width: 30, height: 30)
                    .overlay(content: {
                        Circle()
                            .fill(.white)
                            .padding(5)
                    })
                    .offset(x: 120)
                    .rotationEffect(.init(degrees: progress * 360 ))
                Text(timerStringValue)
                    .font(.system(size:45, weight: .light))
                    .rotationEffect(.init(degrees: 90))
                    .animation(.none, value: progress)
            }
            .padding(60)
            .frame(height: 400)
            .rotationEffect(.init(degrees: -90))
            .animation(.easeInOut, value: progress)
            .offset(y: -100)
            
            HStack(alignment: .center, spacing: 20){
                Button {
                    if isStarted{
                        pauseTimer()
                    }
                    else if isPaused{
                        updateTimer()
                    }
                    else{
                        addNewTimer = true
                    }
                } label: {
                    Image(systemName: (!isStarted && !isPaused) ? "timer" : "pause")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                        .frame(width: 80,height: 80)
                        .background{
                            Circle()
                                .fill(.blue)
                        }
                        .shadow(color: Color.blue.opacity(0.5),radius: 10, x: 0.0, y: 10)
                    
                }
                Button {
                    if isStarted{
                        stopTimer()
                    }
                    else if isPaused {
                        isStarted = false
                        isPaused = false
                        stopTimer()
                    }
                } label: {
                    Image(systemName:"restart")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                        .frame(width: 80,height: 80)
                        .background{
                            Circle()
                                .fill(.blue)
                        }
                        .shadow(color: Color.blue.opacity(0.5),radius: 10, x: 0.0, y: 10)
                }
//                .disabled(!isStarted && isPaused)
//                .opacity( !isStarted || !isPaused ? 0.5 : 1)
            }

        }
        
        .padding(10)
        .background{
            Color("BG")
                .ignoresSafeArea()
        }
        .overlay(content: {
            ZStack{
                Color.black.opacity(addNewTimer ? 0.25 : 0)
                    .onTapGesture{
                        hour = 0
                        minutes = 0
                        seconds = 0
                        addNewTimer = false
                    }
                NewTimerView()
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .offset(y: addNewTimer ? 0 : 400)
            }
            .animation(.easeInOut, value: addNewTimer)
        })
        .preferredColorScheme(.light)
        .background(
            LinearGradient(gradient: Gradient(colors: [.purple,.blue, .white]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
        )
        .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) {
            _ in
            if isStarted{
                updateTimer()
            }
        }
        .alert("Congragulations You did it hooray", isPresented: $isFinished){
            Button("Start New"){
                stopTimer()
                addNewTimer = true
            }
            Button("Close", role: .destructive){
                stopTimer()
            }
        }
    }
    //    New Timer bottom sheet
    @ViewBuilder
    func NewTimerView()->some View{
        VStack(spacing: 15){
            Text("Add New Timer")
                .font(.title2.bold())
                .foregroundColor(.white)
                .padding(.top, 10)
            
            HStack(spacing: 15){
                
                TextField("hours", text: $hourValue)
                    .keyboardType(.decimalPad)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .frame(width: 90, alignment: .center)
                    .background{
                        Capsule()
                            .fill(.white.opacity(0.07))
                    }
                TextField("mins", text: $minValue)
                    .keyboardType(.decimalPad)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .frame(width: 90, alignment: .center)
                    .background{
                        Capsule()
                            .fill(.white.opacity(0.07))
                    }
                TextField("secs", text: $secValue)
                    .keyboardType(.decimalPad)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .frame(width: 90, alignment: .center)
                    .background{
                        Capsule()
                            .fill(.white.opacity(0.07))
                    }
                    
            }
            Button {
                saveText()
                startTimer()
            } label: {
                Text("Save")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .padding(.horizontal, 100)
                    .background{
                        Capsule()
                            .fill(.blue)
                    }
            }
            .disabled(isStarted)
//            .opacity(!isStarted ? 0.5 : 1)
            .padding(.top)
        }
        .padding( )
        .frame(maxWidth: .infinity)
        .background{
            RoundedRectangle(cornerRadius: 10, style: .circular)
            //                .fill(Color("BG"))
                .fill(Color(.lightGray))
                .ignoresSafeArea()
        }
    }
    //    Reusable Context Menu
    @ViewBuilder
    func ContextMenuOptions(maxValue: Int, hint: String, Onclick: @escaping
                            (Int)->())->some View{
        ForEach(0...maxValue, id: \.self){ value in
            Button("\(value) \(hint)"){
                Onclick(value)
            }
        }
    }
}
    
    struct PomodoroMain_Previews: PreviewProvider {
        static var previews: some View {
            PomodoroMain()
        }
    }


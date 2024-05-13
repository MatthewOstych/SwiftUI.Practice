
import SwiftUI
struct NeumorphismUnselected: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color("lightShadow").opacity(0.3), radius: 3, x: -3, y: -3)
            .shadow(color: Color("darkShadow"), radius: 3, x: 3, y: 3)
    }
}

struct NeumorphismSelected: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color("lightShadow").opacity(0.3), radius: 3, x: 3, y: 3)
            .shadow(color: Color("darkShadow"), radius: 3, x: -3, y: -3)
    }
}

struct NeumorphismUnselectedCircle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.all, 10)
            .background(Circle().fill(Color("background")))
            .shadow(color: Color("lightShadow").opacity(0.3), radius: 3, x: -3, y: -3)
            .shadow(color: Color("darkShadow"), radius: 3, x: 3, y: 3)
    }
}

extension View {
    func neumorphismUnselectedStyle() -> some View {
        modifier(NeumorphismUnselected())
    }
    func neumorphismSelectedStyle() -> some View {
        modifier(NeumorphismSelected())
    }
    func neumorphismSelectedCircleStyle() -> some View {
        modifier(NeumorphismUnselectedCircle())
    }
    
    
}

enum Windows {
    case leftFront
    case rightFront
    case leftBack
    case rightBack
}


struct ContentView: View {
    
    @State var isCarColse = false
    @State var istematureEditing = false
    @State var isConditionisOn = false
    @State var isLightIsOn = false
    
    @State var temature = 0.0
    @State var tagSelected = 0
    @State var selectedWindows: Windows?
    @State var lightProgress = 0.0
    
    @State var lightTimer: Timer.TimerPublisher = Timer.publish(every: 0.1, on: .main, in: .common)

    @State var leftFrontWindow = 0.0
    @State var rightFrontWindow = 0.0
    @State var leftBackWindow = 0.0
    @State var rightBackWindow = 0.0
    
    func startProgress() {
        self.lightProgress = 0.0 // Reset progress
        incrementProgress()
    }
    
    private func incrementProgress() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if self.lightProgress < 1.0 && self.isLightIsOn {
                self.lightProgress += 0.02 // Increment progress
                self.incrementProgress()
            } else {
                self.lightProgress = 0.0 // Reset or complete progress
                self.isLightIsOn = false // Turn off the light
            }
        }
    }
    
    func adjustWindow(_ window: Windows, by amount: Double) {
           switch window {
           case .leftFront:
               leftFrontWindow = max(min(leftFrontWindow + amount, 1.0), 0.0)
           case .rightFront:
               rightFrontWindow = max(min(rightFrontWindow + amount, 1.0), 0.0)
           case .leftBack:
               leftBackWindow = max(min(leftBackWindow + amount, 1.0), 0.0)
           case .rightBack:
               rightBackWindow = max(min(rightBackWindow + amount, 1.0), 0.0)
           }
       }

       func windowValue(_ window: Windows) -> Double {
           switch window {
           case .leftFront:
               return leftFrontWindow
           case .rightFront:
               return rightFrontWindow
           case .leftBack:
               return leftBackWindow
           case .rightBack:
               return rightBackWindow
           }
       }
    
    func backgroundStackView<Content: View>(content: () -> Content) -> some View {
        ZStack {
            Rectangle()
                .fill(Color("background"))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            content()
        }
    }
    
    
    
    var headerView: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Tesla")
                    .font(.system(size: 28))
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                Text("180 km")
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
                    .opacity(0.4)
                    
            }
            Spacer()
        }
        .padding(.all, 25)
    }
    
    
    var CarView: some View {
        Image("closeCar")
            .resizable()
            .frame(height: 200)
            .padding(.horizontal)
            .padding(.bottom, 40)
            .shadow(color: .white.opacity(0.5), radius: 15, x: 10, y: 10)
    }
    
    var gradient: LinearGradient {
        LinearGradient(colors: [Color("topGradient"), Color("bottomGradient")], startPoint: .bottom, endPoint: .top)
    }
    
    var controllPanelView: some View {
        HStack(spacing: 30) {
            ForEach(1..<5) { index in
                Button {
                    withAnimation {
                        tagSelected = index
                    }
                } label: {
                    Image("\(index)")
                        .resizable()
                        .frame(width: 40, height: 30)
                        .neumorphismSelectedCircleStyle()
                        .overlay(
                            Circle()
                                .stroke(gradient, lineWidth: 2)
                                .opacity(tagSelected == index ? 1 : 0)
                        )
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 50).fill(Color("background")))
        .neumorphismUnselectedStyle()
        
    }
    
    var lightControllView: some View {
        
        VStack {
            Button {
                isLightIsOn.toggle()
            } label: {
                HStack {
                    Image(systemName: "light.overhead.right")
                    Text("Blink")
                }
                .background(RoundedRectangle(cornerRadius: 50).fill(Color("background")))
               
                .neumorphismSelectedStyle()
          
            }.disabled(isLightIsOn ? true : false)
            
            if isLightIsOn {
                ProgressView(value: lightProgress, total: 1.0)
                    .progressViewStyle(LinearProgressViewStyle())
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 50).fill(Color("background")))
                    .neumorphismUnselectedStyle()
                    .onAppear {
                        startProgress()
                    }
            }
        }
        
    }
    
    var closeCarControllView: some View {
        Button {
            withAnimation {
                isCarColse.toggle()
            }
        } label: {
            HStack {
                Label {
                    Text(isCarColse ? "Close" : "Open")
                        .foregroundStyle(.white)
                } icon: {
                    Image(systemName: isCarColse ? "lock.open.fill" : "lock.fill")
                        .renderingMode(.template)
                    
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 50).fill(Color("background")))
            .neumorphismSelectedStyle()
        }
    }
    
    var windowsControllVew: some View {
        VStack {
            HStack {
                Button {
                    selectedWindows = .leftFront
                } label: {
                    Text("Left Front Window")
                }
                .frame(width: 150, height: 30)
                .padding()
                .background(RoundedRectangle(cornerRadius: 50).fill(Color("background")))
                .neumorphismUnselectedStyle()

                Button {
                    selectedWindows = .rightFront
                } label: {
                    Text("Right Front Window")
                }
                .frame(width: 150, height: 30)
                .padding()
                .background(RoundedRectangle(cornerRadius: 50).fill(Color("background")))
                .neumorphismUnselectedStyle()
            }

            HStack {
                Button {
                    selectedWindows = .leftBack
                } label: {
                    Text("Left Back Window")
                }
                .frame(width: 150, height: 30)
                .padding()
                .background(RoundedRectangle(cornerRadius: 50).fill(Color("background")))
                .neumorphismUnselectedStyle()

                Button {
                    selectedWindows = .rightBack
                } label: {
                    Text("Right Back Window")
                }
                .frame(width: 150, height: 30)
                .padding()
                .background(RoundedRectangle(cornerRadius: 50).fill(Color("background")))
                .neumorphismUnselectedStyle()
            }
            .padding(.top, 20)
            
            if let window = selectedWindows {
                            HStack {
                                VStack {
                                    Button(action: {
                                        adjustWindow(window, by: 0.1)
                                    }) {
                                        Image(systemName: "arrow.up")
                                    }
                                        .padding()
                                        Image(systemName: "arrowtriangle.up.arrowtriangle.down.window.left")
                                        .foregroundStyle(.white)
                                    
                                    Button(action: {
                                        adjustWindow(window, by: -0.1)
                                    }) {
                                        Image(systemName: "arrow.down")
                                    }
                                        .padding()
                                }
                                .padding(.top, 10)

                                ProgressView(value: {
                                    switch window {
                                    case .leftFront:
                                        return leftFrontWindow
                                    case .rightFront:
                                        return rightFrontWindow
                                    case .leftBack:
                                        return leftBackWindow
                                    case .rightBack:
                                        return rightBackWindow
                                    }
                                        
                                }(), total: 1.0)
                                .progressViewStyle(.linear)
                            }
            }
        }
        .padding(.horizontal, 10)
    }

    
    var tempControllView: some View {
        VStack {
            Button {
                withAnimation {
                    isConditionisOn.toggle()
                }
            } label: {
                Text(isConditionisOn ? "Turn Off" : "Turn On")
                    .padding()
            }
            .background(RoundedRectangle(cornerRadius: 50).fill(Color("background")))
            .neumorphismSelectedStyle()
            if isConditionisOn {
                VStack {
                    Text("Temperature: \(temature, specifier: "%.1f")°C")
                        .bold()
                        .foregroundStyle(.white)
                        .padding(.top, 5)
                    Slider(value: $temature, in: 0...100)
                        .accentColor(temature > 50 ? .red : .green)
                        .padding()
                }
                .background(RoundedRectangle(cornerRadius: 50).fill(Color("background")))
                .neumorphismUnselectedStyle()
                .padding()
                .transition(.opacity)
            }
        }
    }
    
        
    
    var body: some View {
        VStack {
            backgroundStackView {
                VStack {
                    headerView
                    CarView
                    controllPanelView
                    Spacer()
                        .frame(height: 40)
                    
                    switch tagSelected {
                    case 1: closeCarControllView
                    case 2: tempControllView
                    case 3: lightControllView
                    case 4: windowsControllVew
                    default: VStack {}
                    }

                    
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(\.colorScheme, .dark)
}

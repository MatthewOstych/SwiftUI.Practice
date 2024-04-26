import SwiftUI

struct MainView: View {
    @State var segmentIndex = 0
    @State var offsetX = 0
    @State var genderIndex = 0
    @State var gender = ["male", "female"]
    @State var imgToShow = ["Nike", "Puma", "Reebok"]
    @State var isSharePresented = false
    
    var company = ["Nike", "Puma", "Reebok"]
    var sneakersImg = ["Nike", "Puma", "Reebok"]
    var femaleSneakersImg = ["NikeFemale", "PumaFemale", "ReebokFemale"]
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Sneakers - \(company[segmentIndex])")
                    .font(Font.system(.title))
                Spacer()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.gray)
                        .padding()
                    Image(imgToShow[segmentIndex])
                        .resizable()
                        .frame(width: 300, height: 300)
                        .offset(x: CGFloat(offsetX))
                        .animation(.easeInOut, value: imgToShow[segmentIndex])
                }
                
                Picker(selection: Binding(get: {
                    self.segmentIndex
                }, set: { newValue in
                    self.segmentIndex = newValue
                    moveBack()
                    chooseImages()
                }), label: Text("")) {
                    ForEach(0..<company.count) {
                        Text(self.company[$0]).tag($0)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                    .padding()
                
                Picker(selection: Binding(get: {
                    self.genderIndex
                }, set: { newValue in
                    self.genderIndex = newValue
                    chooseImages()
                }), label: Text("")) {
                    ForEach(0..<gender.count) {
                        Text(self.gender[$0]).tag($0)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                    .padding()
                
                NavigationLink(destination: BasketView(sneakers: sneakersImg[segmentIndex], gender: gender[genderIndex], adress: "")) {
                    Text("Add to Basket")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color.blue)
                        .cornerRadius(16)
                        .padding()
                }
                .padding(.horizontal, 0)  // Убедитесь, что отступы установлены в 0
                
                Button("Share") {
                    self.isSharePresented = true
                }
                .sheet(isPresented: $isSharePresented) {
                    ActivityView(activityItems: ["Sneakers - \(company[segmentIndex]) for \(gender[genderIndex])", UIImage(named: imgToShow[segmentIndex]) ?? UIImage()])
                }
                
                Spacer().frame(height: 200)
            }        .padding(.top, 100)
        }
    }
    
    private func moveBack() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.offsetX = 0
        }
    }
    
    private func chooseImages() {
        switch genderIndex {
        case 1:
            self.imgToShow = self.femaleSneakersImg
        default:
            self.imgToShow = self.sneakersImg
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

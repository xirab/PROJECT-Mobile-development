

import SwiftUI
import Combine

class SelectedPoint: ObservableObject {
    @Published var selectedIndex: Int = 0
}

struct EventDetailView : View {
    @Binding var isShowing: Bool
    @Binding var eventItems: ActivitiesEvent?
    let defaultPoint = EventDescription(id: 0, pointName: "Default", pointImage: "Default PlaceHolder", pointDescription: "Default Description PlaceHolder")
    
    @ObservedObject var selectedPoint = SelectedPoint()
    
    var body: some View {
        GeometryReader { g in
            ZStack {
                Image(self.eventItems?.eventDescription[self.selectedPoint.selectedIndex].pointImage ?? "")
                    .resizable()
                    .frame(width: g.size.width, height: g.size.height)
                    .aspectRatio(contentMode: .fit)
                    .opacity(0.3)
                    .background(Color.black)
                    .onDisappear {
                        self.isShowing = false
                }
                
                VStack(alignment: .leading) {
                    Text(self.eventItems?.activityPlace ?? "")
                        .foregroundColor(Color.white)
                        .font(.system(size: 30, weight: .bold, design: .default))
                        .padding(.top, 34)
                        .padding(.leading, 30)
                    HStack{
                        Spacer()
                    }
                    
                    Spacer()
                    
                 
                    
                    
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}


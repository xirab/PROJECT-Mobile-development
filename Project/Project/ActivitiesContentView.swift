

import SwiftUI
import Combine

//structure pour les filtres
struct FiltreItem {
    var id: Int
    var filtreName: String
    var filtreNameLabel: String
    var filtreImage: String
    var selectedFiltre: Bool
}

//structures pour la liste des events //EN ATTENTE DES DONNEES
struct ActivitiesEvent {
    var id: Int
    var activityPlace: String
    var activityPlaceImage: String
    var eventDescription: [EventDescription]
   
}

struct ActivitiesData {
    var id: Int
    var ActivitiesEvent: [ActivitiesEvent]
}

struct EventDescription {
    var id: Int
    var pointName: String
    var pointImage: String
    var pointDescription: String
}

class Activities: ObservableObject {
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    var activitiesCollection : [ActivitiesData] {
       willSet {
            objectWillChange.send()
        }
    }
    
    var activities: [FiltreItem] {
        willSet {
                   objectWillChange.send()
               }
    }
    
    init(data: [ActivitiesData], items: [FiltreItem] ) {
        self.activitiesCollection = data
        self.activities = items
    }
}

class ActivitySelected: ObservableObject {
    @Published var index: Int = 0
}



struct ActivitiesContentView: View {

    @ObservedObject var activtiesData : Activities
    @ObservedObject var selectedActivity = ActivitySelected()
    @State var isShowing: Bool = false
    @State var placeItemSelected: ActivitiesEvent? = nil
    
    
    
    var body: some View {
        
        Text("MY EVENT")
            .font(.system(size: 40))
            .padding(.leading, 30)
            .padding(.top, 10)
        GeometryReader { g in
            ScrollView{
                    VStack(alignment: .leading) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack (spacing: 10){
                                ForEach(self.activtiesData.activities, id: \.id) { item in
                                    ShopPromotionBannerView(activtiesItems: item, selectedActivity: self.selectedActivity)
                                            .frame(width: 120, height: 60)
                                }
                            }.padding(.leading, 30)
                            .padding(.trailing, 30)
                            .padding(.bottom, 10)
                        }
                        .padding(.top, 20)
                        Text("\(self.activtiesData.activities[self.selectedActivity.index].filtreNameLabel) évènements")
                            .font(.system(size: 20))
                            .padding(.leading, 30)
                            .padding(.top, 10)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                                    HStack (spacing: 10) {
                                        ForEach(self.activtiesData.activitiesCollection[self.selectedActivity.index].ActivitiesEvent, id: \.id) { item in
                                            Button(action: {
                                                self.placeItemSelected = item
                                                self.isShowing = true
                                            }) {
                                                ShopBestSellerViews(activityPlaces: item)
                                                                    .frame(width: 155, height: 225)
                                            }
                                        }
                                        
                                }.padding(.leading, 30)
                                 .padding(.trailing, 30)
                                 .padding(.bottom, 10)
                                
                        }
                        
                       
                        
                    }
                    .navigationBarTitle("My Event")
                    
            }.sheet(isPresented: self.$isShowing) { EventDetailView(isShowing: self.$isShowing, eventItems: self.$placeItemSelected)}
        }
    }
}







////////////////////////////// SCROLL

struct ShopBestSellerViews: View {
    
    var activityPlaces: ActivitiesEvent
    
    var body: some View {
        
            ZStack{
                
                
                Image("\(activityPlaces.activityPlaceImage)").renderingMode(.original)
                        .resizable()
                        .frame(width: 155, height: 225)
                        .background(Color.black)
                        .cornerRadius(10)
                        .opacity(0.8)
                        .aspectRatio(contentMode: .fill)
               
                VStack (alignment: .leading) {
                    Spacer()
                    
                    Text(activityPlaces.activityPlace)
                        .foregroundColor(Color.white)
                        .font(.system(size: 20, weight: .bold, design: Font.Design.default))
                        .padding(.bottom, 24)
                }
                    
                
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(Color.white)
          
    }
}








//////////////////////////BANDERAU


struct ShopPromotionBannerView: View {
    var activtiesItems: FiltreItem
    @ObservedObject var selectedActivity: ActivitySelected
    
    var body: some View {
        
        Button(action: {
            self.selectedActivity.index = self.activtiesItems.id
            
        }) {
            GeometryReader { g in
                   ZStack{
                    Image("\(self.activtiesItems.filtreName)").renderingMode(.original)
                       .resizable()
                       .opacity(0.8)
                       .aspectRatio(contentMode: .fill)
                       .background(Color.black)
                    
                    
                    if (self.selectedActivity.index == self.activtiesItems.id) {
                           Text("✓ \(self.activtiesItems.filtreName)")
                                    .font(.system(size: 14, weight: .bold, design: Font.Design.default))
                                    .foregroundColor(Color.white)
                    } else {
                             Text(self.activtiesItems.filtreName)
                                    .font(.system(size: 14, weight: .bold, design: Font.Design.default))
                                     .foregroundColor(Color.white)
                    }
                               
                   }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                   .cornerRadius(15)
               }
        }
    }
}

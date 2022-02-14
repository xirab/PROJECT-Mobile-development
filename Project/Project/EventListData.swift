
import SwiftUI

class EventListData {
    
    static let activities: [FiltreItem] = [
        FiltreItem(id: 0, filtreName: "Récents", filtreNameLabel: "Récent", filtreImage: "fond", selectedFiltre: false),
        FiltreItem(id: 1, filtreName: "Topics", filtreNameLabel: "Topics", filtreImage: "fond", selectedFiltre: false),
        FiltreItem(id: 2, filtreName: "Themes", filtreNameLabel: "Themes", filtreImage: "fond", selectedFiltre: false)
        
        
        
    ]
    
    static let activityData: [ActivitiesData] = [
        
        ActivitiesData(id: 0, ActivitiesEvent:
            [ActivitiesEvent(id: 0, activityPlace: "Event", activityPlaceImage: "fond", eventDescription: [EventDescription(id: 0, pointName: "Tamarindo", pointImage: "fond", pointDescription: "")
            ]),
             
             ActivitiesEvent(id: 1, activityPlace: "Event", activityPlaceImage: "fond", eventDescription: [EventDescription(id: 0, pointName: "Kuta", pointImage: "fond", pointDescription: "")
             ]),
             
             ActivitiesEvent(id: 2, activityPlace: "Event", activityPlaceImage: "fond", eventDescription: [EventDescription(id: 0, pointName: "Muizenberg", pointImage: "fond", pointDescription: "")
             ])]
                      
          ),
       
        ActivitiesData(id: 1, ActivitiesEvent: [
        
            ActivitiesEvent(id: 1, activityPlace: "Event", activityPlaceImage: "fond", eventDescription: [EventDescription(id: 0, pointName: "Snowbird", pointImage: "fond", pointDescription: "")]),
            ActivitiesEvent(id: 2, activityPlace: "Event", activityPlaceImage: "fond", eventDescription: [EventDescription(id: 0, pointName: "Cervinia", pointImage: "fond", pointDescription: "")]),
            ActivitiesEvent(id: 3, activityPlace: "Event", activityPlaceImage: "fond", eventDescription: [EventDescription(id: 0, pointName: "Chamonix", pointImage: "fond", pointDescription: "")])]
                      
                      ),
            
       
       
        ActivitiesData(id: 2, ActivitiesEvent: [
        
            ActivitiesEvent(id: 1, activityPlace: "Event", activityPlaceImage: "fond", eventDescription: [EventDescription(id: 0, pointName: "The Fauna Trail", pointImage: "fond", pointDescription: "")
            ]),
            
            ActivitiesEvent(id: 2, activityPlace: "Event", activityPlaceImage: "fond", eventDescription: [EventDescription(id: 0, pointName: "Inca Trail", pointImage: "fond", pointDescription: "")
            
            ]),
            ActivitiesEvent(id: 3, activityPlace: "Event", activityPlaceImage: "fond", eventDescription: [EventDescription(id: 0, pointName: "South Rim Trail", pointImage: "fond", pointDescription: "")

            ])]
                      
                      
     )
       
    ]
    
    
    
}

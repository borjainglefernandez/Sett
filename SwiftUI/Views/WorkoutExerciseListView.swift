//
//  WorkoutExerciseListView.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 10/15/23.
//

import SwiftUI

struct WorkoutExerciseListView: View {
//
//    @FetchRequest(entity: Exercise.entity(), sortDescriptors: [], predicate: nil, animation: .linear)
//    var items: FetchedResults<Exercise>
//    var body: some View {
//        VStack {
//            List {
//                ForEach(items) {(item) in
//                    Text(item.name!)
//                }
//              }
//            }
//        .background(Color(.systemCyan))
//    }
    
     let contacts = [
       "John",
       "Ashley",
       "Bobby",
       "Jimmy",
       "Fredie"
     ]
     
     @State var showingSection1 = true
     @State var showingSection2 = true
     
    var body: some View {
        GeometryReader { geometry in
            
            VStack {
                
                List {
                    Section(
                        header: SectionHeader(
                            title: "Section 1",
                            isOn: $showingSection1,
                            onLabel: "Hide",
                            offLabel: "Show"
                        )
                    ) {
                        if showingSection1 {
                            
                                ForEach(contacts, id: \.self) { contact in
                                    HStack {
//                                        Rectangle().fill(Color(.clear))
//                                        Text(contact).background(.clear)
                                    }.background(Color(.systemCyan))
                                }.background(Color(.systemCyan))
                        }
                    }.listRowBackground(Color(.clear))

                    
                    Section(
                        header: SectionHeader(
                            title: "Section 2",
                            isOn: $showingSection2,
                            onLabel: "Hide",
                            offLabel: "Show"
                        )
                    ) {
                        if showingSection2 {
                            ForEach(contacts, id: \.self) { contact in
                                Text(contact)
                            }
                        }
                    }.padding(.bottom, -5) 
                    
                }
                .scaleEffect(x: 1.05)
                .scrollContentBackground(.hidden)
                
            }
            .background(Color(.systemCyan))
        }

     }
}

struct WorkoutExerciseListView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutExerciseListView()
    }
}


struct SectionHeader: View {
  
  @State var title: String
  @Binding var isOn: Bool
  @State var onLabel: String
  @State var offLabel: String
  
    var body: some View {
        ZStack {
                
                
            Rectangle()
                .cornerRadius(15, corners: isOn ? [.topLeft, .topRight] : [.topLeft, .topRight, .bottomLeft, .bottomRight] )
                .scaleEffect(x: 1.1)
                .frame(height: 30)
                .foregroundColor(Color(.systemGray4))
                
    
            HStack {
                Text("Hello")
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        isOn.toggle()
                    }
                }, label: {
                    if isOn {
                        Image(systemName: "chevron.up")
                                                .foregroundColor(Color(.label))
                            .font(.system(size: 17, weight: .bold))
                        
                    } else {
                        Image(systemName: "chevron.down")
                                                .foregroundColor(Color(.label))
                            .font(.system(size: 17, weight: .bold))
                    }
                }).scrollContentBackground(.hidden)
            }
        }
    }
}

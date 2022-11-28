//
//  TeamListView.swift
//  WorldCupData
//
//  Created by Leonardo Armelin on 27/11/22.
//

import SwiftUI
import ComposableArchitecture

struct TeamListView: View {
    @EnvironmentObject var storeWrapper: WrappedStruct<Store<WorldCupFeature.State, WorldCupFeature.Action>>
    
    var body: some View {
        WithViewStore(storeWrapper.item, observe: {$0}) { viewStore in
            ZStack {
                Color(cgColor: CGColor(red: 255, green: 223, blue: 0, alpha: 1))
                
                ScrollView {
                    LazyVStack {
                        if viewStore.isTeamsListLoading == true {
                            ProgressView()
                        } else {
                            ForEach(viewStore.teamsList, id: \.id, content: TeamItemView.init)
                        }
                    }
                    .padding([.top, .bottom], 16)
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.top, 32)
                .padding(.bottom, 64)
            }.ignoresSafeArea()
        }
    }
}

struct TeamItemView: View {
    let team: Team
    
    var body: some View {
        HStack {
            if let flag = team.flag {
                AsyncImage(url: URL(string: flag)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 36, height: 24)
                
            }
            
            Text(team.name_en ?? "Nothing")
                .frame(maxWidth: .infinity, maxHeight: 50, alignment: .leading)
        }
        .padding([.leading, .trailing], 32)
        .padding([.top, .bottom], 2)
    }
    
    init(team: Team) {
        self.team = team
    }
}

struct TeamListView_Previews: PreviewProvider {
    static var previews: some View {
        TeamListView()
    }
}

struct TeamItemView_Previews: PreviewProvider {
    static var previews: some View {
        TeamItemView(team: Team(flag: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/Flag_of_Brazil.svg/125px-Flag_of_Brazil.svg.png", name_en: "Brazil"))
    }
}

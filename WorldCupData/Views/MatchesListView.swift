//
//  MatchesListView.swift
//  WorldCupData
//
//  Created by Leonardo Armelin on 27/11/22.
//

import SwiftUI
import ComposableArchitecture

struct MatchesListView: View {
    @EnvironmentObject var storeWrapper: WrappedStruct<Store<WorldCupFeature.State, WorldCupFeature.Action>>
    
    var body: some View {
        WithViewStore(storeWrapper.item, observe: {$0}) { viewStore in
            ZStack {
                Color(cgColor: CGColor(red: 255, green: 223, blue: 0, alpha: 1))
                
                ScrollView {
                    LazyVStack {
                        if viewStore.isMatchesListLoading == true {
                            ProgressView()
                        } else {
                            ForEach(viewStore.matchesList, id: \.id, content: MatchItemView.init)
                        }
                    }
                    .padding([.top, .bottom], 16)
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.top, 48)
                .padding(.bottom, 64)
            }.ignoresSafeArea()
        }
    }
}

struct MatchItemView: View {
    let match: Match
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    if let flag = match.home_flag {
                        AsyncImage(url: URL(string: flag)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 18, height: 12)
                    }
                    
                    Text("\(match.home_team_en ?? "null") x \(match.away_team_en ?? "null")")
                    
                    if let flag = match.away_flag {
                        AsyncImage(url: URL(string: flag)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 18, height: 12)
                    }
                }
                
                    if match.finished == "TRUE" {
                        Text("\(match.home_score ?? 0) x \(match.away_score ?? 0)")
                            .font(.system(.title))
                            .frame(maxWidth: .infinity)
                    } else {
                        Text("\(match.local_date ?? "null")")
                            .font(.system(.title2))
                            .frame(maxWidth: .infinity)
                    }
                    
                    Text("Group \(match.group ?? "null")")
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .frame(maxWidth: .infinity, alignment: .bottom)
        .padding()
        .background(Color.white.cornerRadius(16))
        .padding([.horizontal], 32)
    }
}

struct MatchesListView_Previews: PreviewProvider {
    static var previews: some View {
        MatchesListView()
    }
}

struct MatchItemView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.yellow
            
            MatchItemView(
                match: Match(
                    id: "1",
                    away_team_id: "4",
                    away_score: 2,
                    away_team_en: "Netherlands",
                    away_flag: "https://upload.wikimedia.org/wikipedia/commons/thumb/2/20/Flag_of_the_Netherlands.svg/125px-Flag_of_the_Netherlands.svg.png",
                    home_team_id: "3",
                    home_score: 0,
                    home_team_en: "Senegal",
                    home_flag: "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fd/Flag_of_Senegal.svg/125px-Flag_of_Senegal.svg.png",
                    finished: "TRUE",
                    group: "A",
                    matchday: "2",
                    stadium_id: "1",
                    local_date: "11/21/2022 19:00"
                )
            )
        }
        .ignoresSafeArea()
    }
}

//
//  WorldCupFeature.swift
//  WorldCupData
//
//  Created by Leonardo Armelin on 24/11/22.
//

import Foundation
import ComposableArchitecture

struct WorldCupFeature : ReducerProtocol {
    
    let url = "http://api.cup2022.ir"
    
    struct State: Equatable {
        var token: String = ""
        
        var isLoginRequestLoading: Bool = false
        
        var teamsList: [Team] = []
        var isTeamsListLoading: Bool = false
        
        var matchesList: [Match] = []
        var isMatchesListLoading: Bool = false
    }
    
    enum Action {
        case loginUser(email: String, password: String)
        case loginUserResponse(TaskResult<APIResponse<Token>>)
        
        case getTeamsList
        case teamsListResponse(TaskResult<APIResponse<[Team]>>)
        
        case getMatchesList
        case matchesListResponse(TaskResult<APIResponse<[Match]>>)
    }
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
            
            // Login
        case .loginUser(let email, let password):
            state.isLoginRequestLoading = true
            let token = state.token
            return .task {
                let loginUserUrl = URL(string: "\(url)/api/v1/user/login")!
                var urlRequest = URLRequest(url: loginUserUrl)
                urlRequest.httpMethod = "POST"
                urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                let jsonBody = try JSONEncoder().encode(LoginRequest(email: email, password: password))
                urlRequest.httpBody = jsonBody
                urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                let (data, _) = try await URLSession.shared.data(for: urlRequest)
                let response = try JSONDecoder().decode(APIResponse<Token>.self, from: data)
                
                return await Action.loginUserResponse(
                    TaskResult {
                        response
                    }
                )
            }
            
        case .loginUserResponse(.success(let value)):
            if let token = value.data?.token {
                state.token = token
            }
            state.isLoginRequestLoading = false
            return .none
            
        case .loginUserResponse(.failure(let err)):
            print("Error loginUserResponse \(err)")
            state.isLoginRequestLoading = false
            return .none
            // END Login
            
            // Teams List
        case .getTeamsList:
            if !state.teamsList.isEmpty { return .none }
            state.isTeamsListLoading = true
            let token = state.token
            return .task {
                let listTeamsUrl = URL(string: "\(url)/api/v1/team")!
                var urlRequest = URLRequest(url: listTeamsUrl)
                urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                let (data, _) = try await URLSession.shared.data(for: urlRequest)
                let response = try JSONDecoder().decode(APIResponse<[Team]>.self, from: data)
                
                return await Action.teamsListResponse(
                    TaskResult {
                        response
                    }
                )
            }
            
        case .teamsListResponse(.success(let value)):
            if let newTeamsList = value.data {
                state.teamsList = newTeamsList
            }
            state.isTeamsListLoading = false
            return .none
            
        case .teamsListResponse(.failure(let err)):
            print("Error teamsListResponse \(err)")
            state.isTeamsListLoading = false
            return .none
            // END Teams List
            
            // Matches List
        case .getMatchesList:
            if !state.matchesList.isEmpty { return .none }
            state.isMatchesListLoading = true
            let token = state.token
            return .task {
                let listMatchesUrl = URL(string: "\(url)/api/v1/match")!
                var urlRequest = URLRequest(url: listMatchesUrl)
                urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                let (data, _) = try await URLSession.shared.data(for: urlRequest)
                let response = try JSONDecoder().decode(APIResponse<[Match]>.self, from: data)
                
                return await Action.matchesListResponse(
                    TaskResult {
                        response
                    }
                )
            }
            
        case .matchesListResponse(.success(let value)):
            if let newMatchesList = value.data {
                state.matchesList = newMatchesList
            }
            state.isMatchesListLoading = false
            return .none
            
        case .matchesListResponse(.failure(let err)):
            print("Error matchesListResponse \(err)")
            state.isMatchesListLoading = false
            return .none
        }
        // END Matches List
    }
}

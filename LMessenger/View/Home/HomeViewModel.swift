//
//  HomeViewModel.swift
//  LMessenger
//
//  Created by 박진성 on 2/5/24.
//

import Foundation
import Combine

class HomeViewModel : ObservableObject {
    
    enum Action {
        case load
        case requestContacts
        case presentMyProfileView
        case presentOtherProfileView(String)
    }
    
    @Published var myUser : User?
    @Published var users : [User] = []
    @Published var phase : Phase = .notRequested
    @Published var modalDestination : HomeModalDestination?
    
    private var userId : String
    private var container : DIContainer
    private var subsciptions = Set<AnyCancellable>()
    
    init(container : DIContainer, userId : String) {
        self.container = container
        self.userId = userId
    }
    
    func send(action : Action) {
        switch action {
        case .load:
            phase = .loading
            container.services.userService.getUser(userId : userId)
                .handleEvents(receiveOutput: { [weak self] user in
                    self?.myUser = user
                })
                .flatMap { user in
                    self.container.services.userService.loadUsers(id: user.id)
                }
                .sink { [weak self] completion in
                    if case .failure = completion {
                        self?.phase = .fail
                    }
                } receiveValue: { [weak self] users in
                    self?.phase = .success
                    self?.users = users
                }.store(in: &subsciptions)
            
        case .requestContacts:
            container.services.contactService.fetchContacts()
                .flatMap { users in
                    self.container.services.userService.addUserAfterContact(users: users)
                }
                .flatMap { _ in
                    self.container.services.userService.loadUsers(id: self.userId)
                }
                .sink { [weak self] completion in
                    if case .failure = completion {
                        self?.phase = .fail
                    }
                } receiveValue: { [weak self] users in
                    self?.phase = .success
                    self?.users = users
                }.store(in: &subsciptions)


            
        case .presentMyProfileView:
            modalDestination = .myProfile
            
        case let .presentOtherProfileView(userId):
            modalDestination = .otherProfile(userId)
            
        }
    }
}


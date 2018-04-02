//
//  SearchViewPresenter.swift
//  MVP
//
//  Created by 佐藤賢 on 2018/04/01.
//  Copyright © 2018年 佐藤賢. All rights reserved.
//

import Foundation
import GithubKit

protocol SearchPresenter {
  init(view: SearchView)
  var numberOfUsers: Int { get }
  func user(at index: Int) -> User
  var isFetchingUsers: Bool { get }
  func showUser(at index: Int)
  func setIsReachedBottom(_ isReachedBottom: Bool)
  func showLoadingView(on view: UIView)
}

final class SearchViewPresenter: SearchPresenter {
  private var view: SearchView
  
  required init(view: SearchView) {
    self.view = view
  }
  
  private var totalCount: Int = 0 {
    didSet {
      DispatchQueue.main.async { [weak self] in
        guard let strongSelf = self else { return }
        strongSelf.view.updateTotalCountLabel("\(strongSelf.users.count)/\(strongSelf.totalCount)")
      }
    }
  }
  
  private var users: [GithubKit.User] = [] {
    didSet {
      DispatchQueue.main.async { [weak self] in
        guard let strongSelf = self else { return }
        strongSelf.view.updateTotalCountLabel("\(strongSelf.users.count)/\(strongSelf.totalCount)")
      }
    }
  }
  
  private var isReachedBottom: Bool = false {
    didSet {
      if isReachedBottom && isReachedBottom != oldValue {
        
      }
    }
  }
  
  private fetchUsers() {
  
  }

  var numberOfUsers: Int {
    return users.count
  }
  
  func user(at index: Int) -> User {
    return users[index]
  }
  
  
  var isFetchingUsers = false {
    didSet {
      DispatchQueue.main.async { [weak self] in
        self?.view.reloadData()
      }
    }
  }
  
  func showUser(at index: Int) {
    let user = users[index]
    view.showUserRepository(with: user)
  }
  
  func setIsReachedBottom(_ isReachedBottom: Bool) {
    self.isReachedBottom = isReachedBottom
  }
  
  func showLoadingView(on view: UIView) {
    self.view.updateLoadingView(with: view, isLoading: isFetchingUsers)
  }
}

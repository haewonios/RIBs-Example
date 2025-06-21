//
//  AppComponent.swift
//  RIBs-Example
//
//  Created by hyewon on 2025/06/21.
//

import RIBs

class AppComponent: Component<EmptyDependency>, RootDependency {

    init() {
        super.init(dependency: EmptyComponent())
    }
}

//
//  TVDetailsVM.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 29/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol TVDetailsPresentable {
    var displayDetails: PublishSubject<TVDetailsData> { get }
    var closeBtnTapped: AnyObserver<Void> { get set }
}

protocol TVDetailsReactable {
    var closeScreen: Observable<Void> { get }
}

class TVDetailsVM: TVDetailsPresentable, TVDetailsReactable {
    private let tvId: Int
    private let dataServices: DataServices
    private let disposeBag: DisposeBag
    private let tvsHelper: TVsHelper
    var displayDetails: PublishSubject<TVDetailsData>
    var closeBtnTapped: AnyObserver<Void>
    var closeScreen: Observable<Void>
    
    init(dataServices: DataServices, tvId: Int, tvsHelper: TVsHelper, disposeBag: DisposeBag) {
        self.dataServices = dataServices
        self.tvId = tvId
        self.tvsHelper = tvsHelper
        self.disposeBag = disposeBag
        self.displayDetails = PublishSubject<TVDetailsData>()
        
        let _closed = PublishSubject<Void>()
        closeBtnTapped = _closed.asObserver()
        closeScreen = _closed.asObservable()
        
        fetchTVDetails()
    }
    
    private func parse(tv: TV) -> TVDetailsData {
        return self.tvsHelper.tranform(tv: tv)
    }
    
    private func fetchTVDetails() {
        dataServices.getTVDetails(tvId: tvId)
            .subscribe(onNext: { [unowned self] (tv) in
                let tvDetailsData = self.parse(tv: tv)
                self.displayDetails.onNext(tvDetailsData)
            })
            .disposed(by: disposeBag)
    }
}

//
//  ViewModelType.swift
//  ghibli-mvvm-texture
//
//  Created by wendy.kurniawan on 21/11/22.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

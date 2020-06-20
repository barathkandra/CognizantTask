//
//  CanadaViewModel.swift
//  CognizantTask
//
//  Created by Barath on 20/06/20.
//  Copyright © 2020 Barath. All rights reserved.
//

import Foundation

class CanadaViewModel{
    func getCanadaDetails(url : String, completion: @escaping (Result<CanadaDataModel,APIServiceError>) -> ()){
        APIClient().getDataFrom(for: CanadaDataModel.self, url: url) {(result) in
         completion(result)
        }
    }
}

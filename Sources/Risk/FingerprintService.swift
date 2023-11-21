//
//  FingerprintService.swift
//  
//
//  Created by Precious Ossai on 31/10/2023.
//

import FingerprintPro
import Foundation

final class FingerprintService {
    private var requestID: String?
    private let client: FingerprintClientProviding
    private let internalConfig: RiskSDKInternalConfig
    
    init(fingerprintPublicKey: String, internalConfig: RiskSDKInternalConfig) {
        let customDomain: Region = .custom(domain: internalConfig.fingerprintEndpoint)
        let configuration = Configuration(apiKey: fingerprintPublicKey, region: customDomain)
        client = FingerprintProFactory.getInstance(configuration)
        self.internalConfig = internalConfig
    }
    
    func publishData(completion: @escaping (Result<String, RiskError>) -> Void) {
        
        guard requestID == nil else {
            return completion(.success(requestID!))
        }
        
        let metadata = createMetadata(sourceType: internalConfig.sourceType.rawValue)
        
        client.getVisitorIdResponse(metadata) { [weak self] result in
            
            switch result {
            case .failure:
                #warning("TODO: - Handle the error here (https://checkout.atlassian.net/browse/PRISM-10482)")
                return completion(.failure(RiskError.description("Error publishing risk data")))
            case let .success(response):
                #warning("TODO: - Dispatch collected event and/or log (https://checkout.atlassian.net/browse/PRISM-10482)")
                self?.requestID = response.requestId
                completion(.success(response.requestId))
            }
        }
    }
    
    func createMetadata(sourceType: SourceType.RawValue) -> Metadata {
        var meta = Metadata()
        meta.setTag(sourceType, forKey: "fpjsSource")
        meta.setTag(Date().timeIntervalSince1970 * 1000, forKey: "fpjsTimestamp")
        
        return meta
    }
    
}
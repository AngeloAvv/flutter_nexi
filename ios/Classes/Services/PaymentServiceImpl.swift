//
//  PaymentServiceImpl.swift
//  Pods
//
//  Created by Angelo Cassano on 20/05/25.
//
import XPaySDK
import UIKit

public class PaymentServiceImpl: NSObject, PaymentApi {

    func pay(request: PaymentRequest, completion: @escaping (Result<PaymentResult, Error>) -> Void) {
        do {
            let xPay = try XPay(secretKey: request.secretKey)

            if let domain = request.domain, !domain.isEmpty {
                xPay._FrontOffice.setDomain(newUrl: domain)
            }

            xPay._FrontOffice.SelectedEnvironment = (request.environment == .production) ?
                EnvironmentUtils.Environment.prod :
                EnvironmentUtils.Environment.test

            let xPayRequest = ApiFrontOfficeQPRequest(
                alias: request.alias,
                codTrans: request.codTrans,
                currency: request.currency,
                amount: Int(request.amount)
            )

            guard let rootViewController = Self.findRootViewController() else {
                return completion(.failure(PigeonError(
                    code: "missing_rootVC",
                    message: "No root view controller available",
                    details: nil
                )))
            }

            xPay._FrontOffice.paga(
                xPayRequest,
                navigation: true,
                parentController: rootViewController
            ) { response in
                if response.IsValid {
                    completion(.success(response.IsCanceled ? .canceled : .completed))
                } else {
                    completion(.failure(PigeonError(
                        code: "payment_failed",
                        message: "An error has occurred during payment",
                        details: nil
                    )))
                }
            }

        } catch {
            completion(.failure(PigeonError(
                code: "exception",
                message: "A generic error has occurred",
                details: error.localizedDescription
            )))
        }
    }

    private static func findRootViewController() -> UIViewController? {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first(where: { $0.activationState == .foregroundActive })?
            .windows
            .first(where: { $0.isKeyWindow })?
            .rootViewController
    }
}

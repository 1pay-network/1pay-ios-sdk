import Foundation
import UIKit

public struct PaymentResponse {
    public let hash: String?
    public let success: Bool
    public let amount: Float
    public let network: String
    public let token: String
    public let note: String
}


extension PaymentResponse {
    static func fromDict(_ dict: [String: AnyObject]) -> PaymentResponse {
        return PaymentResponse(
            hash: dict["hash"] as? String,
            success: (dict["success"] as? Int ?? 0).boolValue(),
            amount: dict["amount"]?.floatValue ?? 0.0,
            network: dict["network"] as? String ?? "",
            token: dict["token"] as? String ?? "",
            note: dict["note"] as? String ?? "")
    }
}

extension Int {
    func boolValue() -> Bool {
        if (self == 0) {
            return false
        }
        return true
    }
}


public class OnePay {
    
    internal static var RECIPIENT = ""
    internal static var TOKENS = ""
    internal static var NETWORKS = ""
    private static var isInitialized = false
    
    public static func initialize(recipient: String, supportedTokens: [String], supportedNetworks: [String]) {
        if isInitialized {
            return print("SDK has been initialized")
        }
        self.RECIPIENT = recipient
        self.TOKENS = supportedTokens.joined(separator: ",")
        self.NETWORKS = supportedNetworks.joined(separator: ",")
        isInitialized = true
    }
    
    public static func pay(_ rootVC: UIViewController, amount: Float, token: String, note: String, callback: @escaping (PaymentResponse) -> Void) {
        guard !RECIPIENT.isEmpty && !TOKENS.isEmpty && !NETWORKS.isEmpty else {
            print("SDK is not initialized")
            return
        }
        let vc = PaymentViewController()
        vc.amount = amount
        vc.token = token
        vc.note = note
        vc.callback = callback
        rootVC.present(vc, animated: true, completion: nil)
    }
}

enum OnePayError: Error {
    case uninitialize
}

extension OnePayError {
    var isFatal: Bool {
        return true
    }
}

extension OnePayError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .uninitialize:
            return "SDK unintialized"
        }
    }
}
    
extension OnePayError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .uninitialize:
            return NSLocalizedString(
                "SDK has not been intialized",
                comment: "SDK unintialized"
            )
        }
    }
}



//public protocol OnePayPaymentDelegate: class {
//    func onepaySuccess(response: PaymentResponse)
//    func onepayFailed(response: PaymentResponse)
//}

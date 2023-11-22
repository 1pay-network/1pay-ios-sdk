import Foundation
import SwiftUI
import WebKit

public struct OnePayView: UIViewControllerRepresentable {
    
    public typealias UIViewControllerType = PaymentViewController
    
    public let amount: Float
    public let token: String
    public let note: String
    
    private var onSuccess: ((PaymentResponse) -> Void)? = nil
    private var onFail: ((PaymentResponse) -> Void)? = nil
    
    public func makeUIViewController(context: Context) -> PaymentViewController {
        let vc = PaymentViewController()
        vc.amount = amount
        vc.token = token
        vc.note = note
        vc.callback = { [self] response in
            if response.success {
                if let onSuccess = onSuccess {
                    onSuccess(response)
                }
            } else {
                if let onFail = onFail {
                    onFail(response)
                }
            }
        }
        return vc
    }
    
    
    
    public func updateUIViewController(_ uiViewController: PaymentViewController, context: Context) {
        
    }
    
    public func onepaySuccess(_ action: @escaping (PaymentResponse) -> Void) -> Self {
        var copy = self
        copy.onSuccess = action
        return copy
    }

    public func onepayFail(_ action: @escaping (PaymentResponse) -> Void) -> Self {
        var copy = self
        copy.onFail = action
        return copy
    }

}

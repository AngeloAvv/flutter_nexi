import Flutter
import UIKit

public class FlutterNexiPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
      let paymentApi : PaymentApi = PaymentServiceImpl()
      PaymentApiSetup.setUp(binaryMessenger: registrar.messenger(), api: paymentApi)
  }

}

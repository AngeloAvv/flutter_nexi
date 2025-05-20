import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/services/payment_service.dart',
  kotlinOut:
  'android/src/main/kotlin/it/angelocassano/flutter_nexi/services/payment/PaymentService.kt',
  kotlinOptions: KotlinOptions(
    package: 'it.angelocassano.flutter_nexi.services.payment',
  ),
  swiftOut: 'ios/Classes/Services/PaymentService.swift',
  dartPackageName: 'flutter_nexi',
))

enum Environment {
  test,
  production;
}

enum PaymentResult {
  completed,
  canceled;
}

class PaymentRequest {
  final String alias;
  final String codTrans;
  final int amount;
  final String currency;
  final String secretKey;
  final String? domain;
  final Environment environment;

  const PaymentRequest({
    required this.alias,
    required this.codTrans,
    required this.amount,
    required this.currency,
    required this.secretKey,
    required this.domain,
    this.environment = Environment.test,
  });
}

@HostApi()
abstract class PaymentApi {
  @async
  PaymentResult pay(PaymentRequest request);
}

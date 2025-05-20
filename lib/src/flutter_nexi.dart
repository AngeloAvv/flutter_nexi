import 'package:flutter_nexi/src/services/payment_service.dart';

class FlutterNexi {
  final String _secretKey;
  final String? _domain;
  final Environment _environment;
  final PaymentApi _service;

  FlutterNexi({
    required String secretKey,
    String? domain,
    Environment environment = Environment.test,
  }) : _secretKey = secretKey,
       _domain = domain,
       _environment = environment,
       _service = PaymentApi();

  Future<PaymentResult> pay({
    required String alias,
    required String codTrans,
    required int amount,
    required String currency,
  }) {
    return _service.pay(
      PaymentRequest(
        alias: alias,
        codTrans: codTrans,
        amount: amount,
        currency: currency,
        secretKey: _secretKey,
        domain: _domain,
        environment: _environment,
      ),
    );
  }
}

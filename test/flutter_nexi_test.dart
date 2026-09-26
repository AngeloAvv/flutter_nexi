import 'package:flutter/services.dart';
import 'package:flutter_nexi/flutter_nexi.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('wire contract', () {
    test('Environment ordinals are stable', () {
      expect(Environment.test.index, 0);
      expect(Environment.production.index, 1);
    });

    test('PaymentResult ordinals are stable', () {
      expect(PaymentResult.completed.index, 0);
      expect(PaymentResult.canceled.index, 1);
    });
  });

  group('PaymentRequest', () {
    test('survives an encode/decode roundtrip', () {
      final request = PaymentRequest(
        alias: 'alias',
        codTrans: 'codTrans',
        amount: 1000,
        currency: 'EUR',
        secretKey: 'secret_key',
        domain: 'example.com',
        environment: Environment.production,
      );

      expect(PaymentRequest.decode(request.encode()), request);
    });

    test('keeps an omitted domain null', () {
      final request = PaymentRequest(
        alias: 'alias',
        codTrans: 'codTrans',
        amount: 1,
        currency: 'EUR',
        secretKey: 'secret_key',
        environment: Environment.test,
      );

      expect(PaymentRequest.decode(request.encode()).domain, isNull);
    });
  });

  group('FlutterNexi.pay', () {
    final channel = BasicMessageChannel<Object?>(
      'dev.flutter.pigeon.flutter_nexi.PaymentApi.pay',
      PaymentApi.pigeonChannelCodec,
    );
    final messenger =
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;

    tearDown(() {
      messenger.setMockDecodedMessageHandler<Object?>(channel, null);
    });

    test('forwards the constructor arguments on the Pigeon channel', () async {
      Object? sent;
      messenger.setMockDecodedMessageHandler<Object?>(channel, (
        Object? message,
      ) async {
        sent = message;
        return <Object?>[PaymentResult.completed];
      });

      final result = await FlutterNexi(
        secretKey: 'secret_key',
        domain: 'example.com',
        environment: Environment.production,
      ).pay(
        alias: 'alias',
        codTrans: 'codTrans',
        amount: 1000,
        currency: 'EUR',
      );

      expect(result, PaymentResult.completed);

      final request = (sent! as List<Object?>).single! as PaymentRequest;
      expect(request.alias, 'alias');
      expect(request.codTrans, 'codTrans');
      expect(request.amount, 1000);
      expect(request.currency, 'EUR');
      expect(request.secretKey, 'secret_key');
      expect(request.domain, 'example.com');
      expect(request.environment, Environment.production);
    });

    test('defaults to the test environment and a null domain', () async {
      Object? sent;
      messenger.setMockDecodedMessageHandler<Object?>(channel, (
        Object? message,
      ) async {
        sent = message;
        return <Object?>[PaymentResult.canceled];
      });

      final result = await FlutterNexi(secretKey: 'secret_key').pay(
        alias: 'alias',
        codTrans: 'codTrans',
        amount: 1,
        currency: 'EUR',
      );

      expect(result, PaymentResult.canceled);

      final request = (sent! as List<Object?>).single! as PaymentRequest;
      expect(request.environment, Environment.test);
      expect(request.domain, isNull);
    });
  });
}

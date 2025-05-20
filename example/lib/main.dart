import 'package:flutter/material.dart';
import 'package:flutter_nexi/flutter_nexi.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _flutterNexiPlugin = FlutterNexi(secretKey: 'secret_key');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Plugin example app')),
        body: Center(
          child: FilledButton(
            onPressed: () {
              _flutterNexiPlugin.pay(
                alias: 'alias',
                codTrans: 'codTrans',
                amount: 1000,
                currency: 'EUR',
              );
            },
            child: Text('Pay'),
          ),
        ),
      ),
    );
  }
}

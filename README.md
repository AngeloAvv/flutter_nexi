# flutter_nexi

> ⚠️ **Unofficial Flutter plugin** for integrating Nexi/XPay payments on Android and iOS.

[![Pub](https://img.shields.io/pub/v/flutter_nexi.svg)](https://pub.dev/packages/flutter_nexi)
![Pipeline](https://github.com/AngeloAvv/flutter_nexi/workflows/Pipeline/badge.svg)
[![Star on GitHub](https://img.shields.io/github/stars/AngeloAvv/flutter_nexi.svg?style=flat&logo=github&colorB=deeppink&label=stars)](https://github.com/AngeloAvv/flutter_nexi)
[![License: GPLv3](https://img.shields.io/badge/license-GPLv3-purple.svg)](https://www.gnu.org/licenses/gpl-3.0.html)
[![](https://img.shields.io/static/v1?label=Sponsor&message=%E2%9D%A4&logo=GitHub&color=%23fe8e86)](https://github.com/sponsors/AngeloAvv)

## Overview

`flutter_nexi` is a cross-platform plugin that allows you to integrate Nexi's [XPay SDK](https://developer.nexi.it/) into your Flutter apps. It provides a simple interface to initiate and handle payments on both Android and iOS using the official native libraries under the hood.

> **Note:** This is not an official Nexi package. Use it at your own discretion and verify compliance with Nexi's terms and security requirements.

---

## Features

- ✅ Payment processing via Nexi XPay
- 📱 Native integration on Android and iOS
- 🔁 Callback-based payment result handling
- 🧪 Test and production environment support

---

## Supported Platforms

- ✅ Android (API 21+)
- ✅ iOS (15.6+)

---

## Installation

Add the plugin to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_nexi: ^1.0.0
```

## How to Make a Payment

You can trigger a payment using the `FlutterNexi` class. Here's a minimal example of how to initiate a payment when a button is pressed:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_nexi/flutter_nexi.dart';

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Initialize the plugin with your secret key
  final _flutterNexiPlugin = FlutterNexi(secretKey: 'your_secret_key');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Nexi Payment Example')),
        body: Center(
          child: FilledButton(
            onPressed: () {
              _flutterNexiPlugin.pay(
                alias: 'your_alias',
                codTrans: 'your_transaction_code',
                amount: 1000, // in cents, i.e., €10.00
                currency: 'EUR',
              );
            },
            child: const Text('Pay'),
          ),
        ),
      ),
    );
  }
}
```

## 🔐 ProGuard Configuration (Android)

If you're building a **release version** of your app with **code shrinking and obfuscation** enabled (e.g., using R8 or ProGuard), you must add the following rules to prevent breaking Nexi's SDK functionality.

### ➕ Add to `android/app/proguard-rules.pro`:

```proguard
## Nexi Rules
-keep class it.angelocassano.flutter_nexi.**  { *; }
-keep class it.nexi.xpay.**  { *; }

# Suppress warnings for 3DS SDK classes
-dontwarn com.nets.igfs_3ds_sdk_android.dto.project.AuthenticationRequestParameters
-dontwarn com.nets.igfs_3ds_sdk_android.dto.project.ChallengeParameters
-dontwarn com.nets.igfs_3ds_sdk_android.dto.project.ConfigParameters
-dontwarn com.nets.igfs_3ds_sdk_android.dto.protocol.ErrorMessage
-dontwarn com.nets.igfs_3ds_sdk_android.event.CompletionEvent
-dontwarn com.nets.igfs_3ds_sdk_android.event.ProtocolErrorEvent
-dontwarn com.nets.igfs_3ds_sdk_android.event.RuntimeErrorEvent
-dontwarn com.nets.igfs_3ds_sdk_android.graphics.IUiCustomization
-dontwarn com.nets.igfs_3ds_sdk_android.graphics.UiCustomization
-dontwarn com.nets.igfs_3ds_sdk_android.service.IChallengeStatusReceiver
-dontwarn com.nets.igfs_3ds_sdk_android.service.ITransaction
-dontwarn com.nets.igfs_3ds_sdk_android.service.impl.ThreeDS2Service
```

## License

`flutter_nexi` is available under the GPLv3 license. See the COPYING file for more info.

## NEXT

* **Breaking:** raised the minimum supported versions to Flutter 3.44.0 and Dart 3.12.0. The
  previously declared floors (Flutter 3.3.0 / Dart 3.5.0) were never actually buildable, since
  the Android side requires an AGP 9 toolchain and iOS requires a 15.6 deployment target.
* Migrated the Android build to Built-in Kotlin. The plugin no longer applies the Kotlin Gradle
  Plugin conditionally on the host app's AGP version, so it now builds both with and without
  `android.builtInKotlin`. See
  https://docs.flutter.dev/release/breaking-changes/migrate-to-built-in-kotlin/for-plugin-authors
* Raised the Android Java and Kotlin JVM target from 11 to 17, matching Flutter's plugin template.
* Declared the bundled XPay AAR with single-string dependency notation; the previous map notation
  is scheduled to fail with an error in Gradle 10.

## 1.0.0

* Support for simple payment
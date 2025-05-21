## Flutter Rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# This is generated automatically by the Android Gradle plugin.
-dontwarn com.google.android.play.core.splitcompat.SplitCompatApplication
-dontwarn com.google.android.play.core.splitinstall.SplitInstallException
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManager
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManagerFactory
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest$Builder
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest
-dontwarn com.google.android.play.core.splitinstall.SplitInstallSessionState
-dontwarn com.google.android.play.core.splitinstall.SplitInstallStateUpdatedListener
-dontwarn com.google.android.play.core.tasks.OnFailureListener
-dontwarn com.google.android.play.core.tasks.OnSuccessListener
-dontwarn com.google.android.play.core.tasks.Task

## Nexi Rules
-keep class it.angelocassano.flutter_nexi.**  { *; }
-keep class it.nexi.xpay.**  { *; }

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

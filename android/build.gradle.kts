import org.jetbrains.kotlin.gradle.dsl.JvmTarget
import org.jetbrains.kotlin.gradle.dsl.KotlinAndroidProjectExtension

group = "it.angelocassano.flutter_nexi"
version = "1.0-SNAPSHOT"

plugins {
    id("com.android.library")
}

// Flutter is migrating to Built-in Kotlin (AGP >= 9 ships Kotlin support natively).
// Apply the classic Kotlin Android plugin only when the host app's AGP is still < 9,
// so this plugin keeps building on Flutter versions/toolchains that don't yet enable
// Built-in Kotlin (requires Flutter 3.47+), while being ready for when they do.
// See: https://docs.flutter.dev/release/breaking-changes/migrate-to-built-in-kotlin/for-plugin-authors
val agpMajor = com.android.Version.ANDROID_GRADLE_PLUGIN_VERSION.substringBefore('.').toInt()

if (agpMajor < 9) {
    apply(plugin = "org.jetbrains.kotlin.android")
}

rootProject.allprojects {
    repositories {
        google()
        mavenCentral()
        flatDir {
            dirs(project(":flutter_nexi").file("libs"))
        }
    }
}

android {
    namespace = "it.angelocassano.flutter_nexi"

    compileSdk = 36

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    sourceSets {
        getByName("main").java.srcDirs("src/main/kotlin")
        getByName("test").java.srcDirs("src/test/kotlin")
    }

    defaultConfig {
        minSdk = 24
    }

    dependencies {
        testImplementation("org.jetbrains.kotlin:kotlin-test")
        testImplementation("org.mockito:mockito-core:5.23.0")

        implementation("androidx.constraintlayout:constraintlayout:2.2.1")
        implementation("androidx.appcompat:appcompat:1.8.0")
        implementation("com.android.volley:volley:1.2.1")
        implementation("com.google.code.gson:gson:2.14.0")
        implementation("com.google.android.material:material:1.14.0")
        implementation("com.google.android.gms:play-services-wallet:20.0.0")
        implementation("androidx.browser:browser:1.9.0")

        add("api", mapOf("name" to "XPaySDK_v1.4.92", "ext" to "aar"))
    }

    testOptions {
        unitTests.all {
            it.useJUnitPlatform()

            it.outputs.upToDateWhen { false }

            it.testLogging {
                events("passed", "skipped", "failed", "standardOut", "standardError")
                showStandardStreams = true
            }
        }
    }
}

project.extensions.configure(KotlinAndroidProjectExtension::class.java) {
    compilerOptions {
        jvmTarget.set(JvmTarget.JVM_11)
    }
}

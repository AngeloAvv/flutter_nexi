import org.jetbrains.kotlin.gradle.dsl.JvmTarget

group = "it.angelocassano.flutter_nexi"
version = "1.0-SNAPSHOT"

plugins {
    id("com.android.library")
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
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
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
        testImplementation("org.mockito:mockito-core:5.24.0")

        implementation("androidx.constraintlayout:constraintlayout:2.2.2")
        implementation("androidx.appcompat:appcompat:1.8.0")
        implementation("com.android.volley:volley:1.2.1")
        implementation("com.google.code.gson:gson:2.14.0")
        implementation("com.google.android.material:material:1.14.0")
        implementation("com.google.android.gms:play-services-wallet:20.0.0")
        implementation("androidx.browser:browser:1.10.0")

        // Single-string notation: the map form fails with an error in Gradle 10.
        add("api", ":XPaySDK_v1.4.92@aar")
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

kotlin {
    compilerOptions {
        jvmTarget = JvmTarget.JVM_17
    }
}

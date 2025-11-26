plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

android {
    namespace = "com.example.focus_flow_project"
    compileSdk = 34
    ndkVersion = flutter.ndkVersion

    compileOptions {
        // Enables core library desugaring
        isCoreLibraryDesugaringEnabled = true
        // UPDATING to Java 11
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        // UPDATING to jvmTarget 11
        jvmTarget = "11"
    }

    defaultConfig {
        applicationId = "com.example.focus_flow_project"
        // Setting minSdk to 21 to avoid potential issues
        minSdk = flutter.minSdkVersion
        targetSdk = 34
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        multiDexEnabled = true
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation(platform("com.google.firebase:firebase-bom:32.8.1"))
    implementation("com.google.firebase:firebase-analytics")
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")
}

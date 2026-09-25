allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

// FIX FOR LEGACY DEVICE_APPS PACKAGE IN AGP 8.0+
subprojects {
    plugins.withId("com.android.library") {
        if (project.name == "device_apps") {
            val androidExtension = extensions.findByType(com.android.build.gradle.LibraryExtension::class.java)
            androidExtension?.apply {
                namespace = "fr.g123k.deviceapps"
                
                // Disables strict package attribute validation in source AndroidManifest.xml
                experimentalProperties["android.experimental.self-extracting-vc"] = false
            }
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
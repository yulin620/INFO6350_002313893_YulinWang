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

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}


// Fix cloud_firestore "BuildConfig disabled" error
subprojects {
    afterEvaluate { project ->
        if (project.plugins.hasPlugin("com.android.library") ||
            project.plugins.hasPlugin("com.android.application")
        ) {
            try {
                val androidExtension = project.extensions.getByName("android")
                val buildFeaturesMethod = androidExtension.javaClass.methods.firstOrNull {
                    it.name == "getBuildFeatures"
                }
                val buildFeatures = buildFeaturesMethod?.invoke(androidExtension)
                val setBuildConfigMethod = buildFeatures?.javaClass?.methods?.firstOrNull {
                    it.name == "setBuildConfig"
                }
                setBuildConfigMethod?.invoke(buildFeatures, true)
                println("Enabled buildConfig for ${project.name}")
            } catch (e: Exception) {
                println("Failed to enable buildConfig for ${project.name}: ${e.message}")
            }
        }
    }
}

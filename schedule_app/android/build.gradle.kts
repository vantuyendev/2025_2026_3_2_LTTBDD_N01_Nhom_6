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
    val fixSubproject = {
        val android = extensions.findByName("android")
        if (android != null) {
            try {
                val getNamespace = android.javaClass.getMethod("getNamespace")
                val currentNamespace = getNamespace.invoke(android)
                if (currentNamespace == null) {
                    val setNamespace = android.javaClass.getMethod("setNamespace", String::class.java)
                    val pkgName = "dev.isar." + project.name.replace('-', '_')
                    setNamespace.invoke(android, pkgName)
                }
            } catch (_: Exception) {
            }

            try {
                val setCompileSdkVersion = android.javaClass.getMethod("setCompileSdkVersion", Int::class.javaPrimitiveType)
                setCompileSdkVersion.invoke(android, 35)
            } catch (_: Exception) {
                try {
                    val setCompileSdkVersionStr = android.javaClass.getMethod("setCompileSdkVersion", String::class.java)
                    setCompileSdkVersionStr.invoke(android, "android-35")
                } catch (_: Exception) {
                }
            }
        }
    }

    if (state.executed) {
        fixSubproject()
    } else {
        afterEvaluate {
            fixSubproject()
        }
    }
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}



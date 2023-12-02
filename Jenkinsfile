
pipeline {
    agent any
    parameters {
        booleanParam 'CLEAN_NO_CACHE'
    }
    
    stages {
        stage('Build') {
            steps {
                script {
                    def no_cache=env.CLEAN_NO_CACHE
                    if (no_cache == 'true') {
                        sh 'docker buildx build . --builder=kube --progress=plain --tag course3-jenkins-gs-spring-petclinic:build-${BUILD_NUMBER} --output "type=local,dest=$(pwd)/." --no-cache'
                    }
                    else {
                        sh 'docker buildx build . --builder=kube --progress=plain --tag course3-jenkins-gs-spring-petclinic:build-${BUILD_NUMBER} --output "type=local,dest=$(pwd)/."'
                    }
                }
            }
        }
    }
    
    post {
        always {
            archiveArtifacts artifacts: 'output/*', followSymlinks: false
            junit 'output/surefire-reports/TEST*.xml'
            jacoco classPattern: 'output/classes', execPattern: 'output/**.exec'
        }
    }
}

pipeline {

      environment {
        imagename = 'formation2/cont-python:cont-python'
        registryCredential = 'docker'
      }

      agent any
      stages {
        stage('Clone sources') {
            steps {
                git url: 'https://github.com/HugoDux021/TP5_formation'
            }
        }
        stage('continuous integration') { // Compile and do unit testing
            // tools {
            //   gradle 'installGradle'
            //}
             steps {
                 parallel (
                 // run Gradle to execute compile and unit testing
                    pylint: {
                        sh 'gradle lint'
                    },
                    pycode: {
                        sh 'gradle pycode'
                    }
                )
             }
           }

        // stage('testcode') {
            //  tools {
            //    gradle 'installGradle'
            //  }
        //     steps {
        //         sh 'gradle test'
        //     }
        // }

        stage('Package and deploy') {
            // tools {
            //   gradle 'installGradle'
            // }
            steps {
                sh 'gradle up'
            }
        }

        stage('Build docker image') {
            steps{
                script {
                    docker.build registry + ":$BUILD_NUMBER"
                } 
            }
        }

        stage('Push Image') {
            steps{
                script {
                    docker.withRegistry( '', registryCredential ) {
                        dockerImage.push("$BUILD_NUMBER")
                    }
                }
            }
        }

        stage('Test image docker') {
            steps {
                sh 'docker run -d --name cont-python:cont-python -p 3002:3002 --rm formation2/cont-python:cont-python'
            }
        }
      }
 }

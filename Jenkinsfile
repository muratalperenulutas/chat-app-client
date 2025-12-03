pipeline {
    agent none

    stages {
        stage('Setup & Config') {
            agent any
            steps {
                sh 'chmod -R u+w $WORKSPACE'
                stash includes: 'docker-compose.yml, Dockerfile', name: 'docker-files'

                script {
                    echo "Loading .env file from Jenkins credentials..."
                    withCredentials([file(credentialsId: 'chat-client.env', variable: 'ENV_FILE_PATH')]) {
                        sh '''
                            cp "${ENV_FILE_PATH}" "./.env"
                            echo ".env file loaded successfully"
                            ls -la ./.env
                        '''
                    }
                }
                stash includes: '.env', name: 'env-file'

                script {
                    echo "Loading .json file from Jenkins credentials..."
                    withCredentials([file(credentialsId: 'dev.json', variable: 'JSON_FILE_PATH')]) {
                        sh '''
                            rm -f ./assets/config/dev.json
                            cp "${JSON_FILE_PATH}" "./assets/config/dev.json"
                            echo "dev.json file loaded successfully"
                            ls -la ./assets/config/dev.json
                        '''
                    }
                }
                stash includes: 'assets/config/dev.json', name: 'json-config'
            }
        }

        stage('Build Flutter Apps') {
            agent {
                dockerfile {
                    filename 'Dockerfile.build'
                }
            }
            steps {
                unstash 'json-config'

                sh 'flutter --version'
                sh 'flutter doctor'
                sh 'flutter clean'
                sh 'flutter pub get'
                
                //sh 'flutter analyze'
                //sh 'flutter test'

                //sh 'flutter build apk --release'

                sh 'flutter build web --release'
                
                sh 'chmod -R u+rw build/web || true'

                stash includes: 'build/web/**/*', name: 'web-build'
            }
            post {
                success {
                    //archiveArtifacts artifacts: 'build/app/outputs/flutter-apk/*.apk', fingerprint: true
                    archiveArtifacts artifacts: 'build/web/**/*', fingerprint: true
                }
            }
        }

        stage('Deploy Web Container') {
            agent any
            options {
                skipDefaultCheckout()
            }
            steps {
                unstash 'docker-files'
                unstash 'env-file'
                unstash 'web-build'

                sh 'find . -type d -exec chmod 755 {} \\; -o -type f -exec chmod 644 {} \\;'

                script {
                    sh 'docker compose up -d --build'
                }
            }
        }
    }

    post {
        always {
            script {
                echo "Pipeline execution completed"
            }
        }

        success {
            echo "Pipeline completed successfully!"
        }

        failure {
            echo "Pipeline failed!"
        }
    }
}

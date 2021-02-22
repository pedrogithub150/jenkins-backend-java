pipeline {
    agent any
    parameters {
        string(name: 'IMAGE_NAME', defaultValue:'java-mvn', description:'Docker Image Name')

        string(name: 'CONTAINER_NAME', defaultValue: 'java-mvn', description:'Docker Container Name')

        string(name: 'DOCKER_PORT', defaultValue: '3000', description:'Docker Container Host Port')
    }

    
     
       

        stage('Remove Previous Image and Container') {
            steps {
                sh 'docker rm --force "$CONTAINER_NAME"'
                sh 'docker rmi --force "$IMAGE_NAME"'

            }
        }


        stage('Create Docker Image') {
            steps {
				sh 'mvn -version'
				sh 'mvn clean install'
                checkout scm
                withMaven(jdk: 'JDK11') {
                   sh 'mvn -B -DskipTests clean package' 
                }
                sh 'docker build -t "$IMAGE_NAME" .'
            }
        }

        stage('Create Docker Container') {
            steps {
                sh 'docker run -d -p $DOCKER_PORT:8080 --name "$CONTAINER_NAME" "$IMAGE_NAME"'

            }
        }

		 stage('Clear WorkSpace') {
            steps {
                cleanWs()
            }
        }
    } 
}
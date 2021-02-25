pipeline
{
	agent any

	parameters
	{
		// Tem que se ir ao Jenkins > Configure > This project is parameterized. 
		string(name: 'DOCKER_IMAGE_NAME', defaultValue: 'default_name', description: 'Docker image name')
		string(name: 'DOCKER_CONTAINER_NAME', defaultValue: 'default_name', description: 'Docker container name')
		string(name: 'DOCKER_PORT', defaultValue: '3000', description: 'Docker port')
	}

    stages
    {
		// Faz o maven.
		stage ('Stage A - Maven')
		{
			agent
			{
				docker
				{
					image 'maven:3-alpine'
					args '-v /root/.m2:/root/.m2'
				}
			}
	
			steps
			{
				sh 'mvn -DskipTests -f book/pom.xml clean package'
			}
		}
  
		// Faz o build da imagem no docker.
        stage('Stage B - Docker build')
        {
            steps
            {
				sh "docker build -t ${DOCKER_IMAGE_NAME} ."
            }
        }
		
		// Remove a imagem caso exista e faz run.
		stage('Stage C - Docker run')
        {
            steps
            {
				sh "docker rm -f ${DOCKER_IMAGE_NAME}"
				sh "docker run -d -p ${DOCKER_PORT}:8080 --name ${DOCKER_CONTAINER_NAME} ${DOCKER_IMAGE_NAME}"
            }
        }

		// Apaga os dados do workspace.
		stage('Stage D - Clean up resources')
		{
			steps
			{
				cleanWs()
			}
		}
    }
}
    node {
	
        def IMAGE_BUILD
		def DOCKER_IMAGE='ernesen/gateway'

        stage ('Clone repository') {
            checkout scm
			IMAGE_BUILD = sh(script: 'git rev-list HEAD --count', returnStdout: true).trim()
	}
        
        
		stage ('Build image') {
			withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_HUB_USER', passwordVariable: 'DOCKER_HUB_PASSWORD']]) {
				sh "docker login -u ${DOCKER_HUB_USER} -p ${DOCKER_HUB_PASSWORD}"
				sh "docker build -t ${DOCKER_IMAGE}:v${IMAGE_BUILD} ."
				sh "docker tag ${DOCKER_IMAGE}:v${IMAGE_BUILD} ${DOCKER_IMAGE}:latest"
			}			
        }

        stage ('Push image') {
			sh "docker push ${DOCKER_IMAGE}:v${IMAGE_BUILD}"
			sh "docker push ${DOCKER_IMAGE}:latest"
        }
	    
        stage ('Deploy helm') {
			//sh "helm init --client-only --skip-refresh"
			sh "helm list"
			//sh "helm upgrade --install --set image.repository=${DOCKER_IMAGE},image.tag=${IMAGE_BUILD} hello hello"
        }
/*
		stage ('Deploy AWS terraform') {
			withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'aws-credentials', usernameVariable: 'access_key', passwordVariable: 'secret_key']]){
				//sh "cp $gcloud credentials.json"
				sh """
				cd terraform/AWS/
				terraform init -backend=true -backend-config="access_key=${access_key}" -backend-config="secret_key=${secret_key}"
				terraform plan -var "access_key=${access_key}" -var "secret_key=${secret_key}"
				terraform apply -var "access_key=${access_key}" -var "secret_key=${secret_key}" -auto-approve=true
				"""
			}
		}
*/		
		stage ('Email Notification') {
			withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'email-credentials', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD']]) {
				sh "curl --url 'smtps://smtp.gmail.com:465' --ssl-reqd \
				--mail-from 'username@gmail.com' --mail-rcpt 'ernesen@icloud.com' \
				--upload-file mail.txt --user '$USERNAME:$PASSWORD' --insecure"			
			}
		}
/*		
		stage ('SMS Notification') {
			withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'sms-credentials', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD']]) {
				sh "curl -X POST  https://rest.nexmo.com/sms/json \
				-d api_key=$USERNAME \
				-d api_secret=$PASSWORD \
				-d to=6592991210 \
				-d from=\"NEXMO\" \
				-d text=\"Hello from Nexmo running in Jenkins\""			
			}
		}
*/
    }

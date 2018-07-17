minikube addons enable ingress
minikube addons enable registry

helm search jenkins
helm init

helm install --name cd -f overrides.yaml stable/jenkins

# Check tiller is available
kubectl rollout status deployment -n kube-system tiller-deploy

printf $(kubectl get secret --namespace default cd-jenkins -o jsonpath="{.data.jenkins-admin-password}" | base64 --decode);echo

minikube service cd-jenkins
# admin/3kTXUJmJAH

# Jenkinks Create variable
# Jenkinks Create credentials

# Jenkinks Job name
IBM Event Central ICP


IBM Cloud private ICC
https://192.168.64.244:8443/console/
admin/admin


IBM Event Central ICP



# 
kubectl config get-contexts
kubectl get po
kubectl get svc
kubectl get no

helm del --purge <chart>
########################################################
# BUILD DOCKER IMAGES
  # - 1st tag latest to ensure all deployed changes
  #   are the latest
  # - 2nd tag to tag image with the a git commit SHA
  #   for revision
########################################################

# Build client production image
docker build -t nabeelhamadal/k8s-client:latest -t nabeelhamadal/k8s-client:$SHA -f ./client/Dockerfile ./client

# Build server production image
docker build -t nabeelhamadal/k8s-api:latest -t nabeelhamadal/k8s-api:$SHA -f ./api/Dockerfile ./api

# Build server worker image
docker build -t nabeelhamadal/k8s-worker:latest -t nabeelhamadal/k8s-worker:$SHA -f ./worker/Dockerfile ./worker

########################################################
# DOCKER PUSH
######################################################## 

# Push client production image
docker push nabeelhamadal/k8s-client:latest
docker push nabeelhamadal/k8s-client:$SHA

# Push server production image
docker push nabeelhamadal/k8s-api:latest
docker push nabeelhamadal/k8s-api:$SHA

# Push server worker image
docker push nabeelhamadal/k8s-worker:latest
docker push nabeelhamadal/k8s-worker:$SHA

########################################################
# APPLY ALL LOCAL K8S CHANGES
########################################################
kubectl apply -f k8s

########################################################
# SET LATEST IMAGE OF EACH DEPLOYMENT
########################################################
kubectl set image deployments/client-deployment client=nabeelhamadal/k8s-client:$SHA
kubectl set image deployments/server-deployment api=nabeelhamadal/k8s-api:$SHA
kubectl set image deployments/worker-deployment worker=nabeelhamadal/k8s-worker:$SHA
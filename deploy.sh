docker build -t lai110771/multi-client:latest -t lai110771/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lai110771/multi-server:latest -t lai110771/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lai110771/multi-worker:latest -t lai110771/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push lai110771/multi-client:latest
docker push lai110771/multi-client:$SHA

docker push lai110771/multi-server:latest
docker push lai110771/multi-server:$SHA

docker push lai110771/multi-worker:latest
docker push lai110771/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=lai110771/multi-server:$SHA
kubectl set image deployments/client-deployment client=lai110771/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=lai110771/multi-worker:$SHA
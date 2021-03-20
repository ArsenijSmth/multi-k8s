docker build -t arsenijs/multi-client:latest -t arsenijs/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t arsenijs/multi-server:latest -t arsenijs/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t arsenijs/multi-worker:latest -t arsenijs/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push arsenijs/multi-client:latest
docker push arsenijs/multi-server:latest
docker push arsenijs/multi-worker:latest

docker push arsenijs/multi-client:$SHA
docker push arsenijs/multi-server:$SHA
docker push arsenijs/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=arsenijs/multi-server:$SHA
kubectl set image deployments/client-deployment client=arsenijs/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=arsenijs/multi-worker:$SHA

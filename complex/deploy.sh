docker build -t arsh7023/multi-client:latest -t arsh7023/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t arsh7023/multi-server:latest -t arsh7023/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t arsh7023/multi-worker:latest -t arsh7023/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push arsh7023/multi-client:latest
docker push arsh7023/multi-server:latest
docker push arsh7023/multi-worker:latest

docker push arsh7023/multi-client:$SHA
docker push arsh7023/multi-server:$SHA
docker push arsh7023/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=arsh7023/multi-server:$SHA
kubectl set image deployments/client-deployment client=arsh7023/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=arsh7023/multi-worker:$SHA
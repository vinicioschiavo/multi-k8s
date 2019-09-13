docker build -t vinicioschiavo/multi-client:latest -t vinicioschiavo/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t vinicioschiavo/multi-server:latest -t vinicioschiavo/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t vinicioschiavo/multi-worker:latest -t vinicioschiavo/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push vinicioschiavo/multi-client:latest
docker push vinicioschiavo/multi-server:latest
docker push vinicioschiavo/multi-worker:latest

docker push vinicioschiavo/multi-client:$SHA
docker push vinicioschiavo/multi-server:$SHA
docker push vinicioschiavo/multi-worker:$SHA

kubectl appy -f k8s
kubectl set image deployments/server-deployment server=vinicioschiavo/multi-server:$SHA
kubectl set image deployments/client-deployment client=vinicioschiavo/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=vinicioschiavo/multi-worker:$SHA
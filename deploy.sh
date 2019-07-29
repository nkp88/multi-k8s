docker build -t apel73/multi-client:latest -t apel73/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t apel73/multi-server:latest -t apel73/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t apel73/multi-worker:latest -t apel73/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push apel73/multi-client:latest
docker push apel73/multi-server:latest
docker push apel73/multi-worker:latest

docker push apel73/multi-client:$SHA
docker push apel73/multi-server:$SHA
docker push apel73/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=apel73/multi-server:$SHA
kubectl set image deployments/client-deployment client=apel73/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=apel73/multi-worker:$SHA
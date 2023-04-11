#!/bin/bash
## Test your deployment
kubectl get pods -n myns

kubectl -n myns port-forward service/api 3000:3000 &
pid=$!
counter=0
while ! curl "http://localhost:3000/hello"
do
  sleep 1
  if [ $counter -gt 5 ]; then
    break
  fi
  counter=$(( $counter + 1 ))
done
kill $pid
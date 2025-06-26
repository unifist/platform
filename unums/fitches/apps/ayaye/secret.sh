#!/bin/bash

CLUSTER=$1
NAMESPACE=$2

read -p "Enter key: " KEY

kubectl --context $CLUSTER -n $NAMESPACE create secret generic secret --from-literal=openai.json="{\"key\":\"$KEY\"}"

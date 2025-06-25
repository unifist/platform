#!/bin/bash

CLUSTER=$1
NAMESPACE=$2

read -p "Enter token: " TOKEN
read -p "Enter guild id: " GUILD_ID

kubectl --context $CLUSTER -n $NAMESPACE create secret generic "discord.json" --from-literal=data.json="{\"token\":\"$TOKEN\", \"guild\": {\"id\": \"$GUILD_ID\"}}"

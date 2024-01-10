#!/bin/bash

helm upgrade -i openvscode verbasu/openvscode \
	--atomic --create-namespace -n openvscode \
	--version 3.15.1 --values values.yaml 

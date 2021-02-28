#!/bin/bash

echo "Copying terraform project..."
cp -a /module/crear-infraestructura/. /tf-test/module/

echo "Initializing environment..."
mkdir /root/.azure
cp /module/crear-infraestructura/.TFTesting/.azure/*.json /root/.azure

echo "Starting to Run test task..."
ssh-keygen -t rsa -b 2048 -C terraformTest -f /root/.ssh/id_rsa -N ''; rake -f ../Rakefile e2e
echo "Container test operation completed - read the logs for status"
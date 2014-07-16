#!/bin/bash

docker run -d --privileged=true --name=pptp -p 1723:1723/tcp houqp/pptp

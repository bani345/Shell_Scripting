#!/bin/bash

create_directory() {
	mkdir demo
}

if ! create_directory; then
	echo "The code is being exited as the directory already exists"
	exit 1
fi

echo "ban gai jye directory pali dafa"


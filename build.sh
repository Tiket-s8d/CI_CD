#!/bin/bash

num_runs=10

for ((i = 1; i <= num_runs; i++)); do
    echo "Running CMake commands - Attempt $i"
    cmake -S . -B ./build
    cmake --build ./build
    rm -rf ./build
done

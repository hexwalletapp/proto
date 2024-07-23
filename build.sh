#!/bin/sh

# Check if swift-protobuf is installed
if ! command -v protoc-gen-swift &> /dev/null; then
    brew install swift-protobuf
fi

# Check if protoc-gen-ts is installed
if ! command -v protoc-gen-ts &> /dev/null; then
    npm install -g protoc-gen-ts
fi

npm install @protobuf-ts/plugin --save-dev

# Define paths
PROTO_FILE=./services/superdapp.proto
SWIFT_OUT_DIR=./dist/swift
TS_OUT_DIR=./dist/typescript

# Create dist directories if they don't exist
mkdir -p $SWIFT_OUT_DIR
mkdir -p $TS_OUT_DIR

# Generate Swift files (both .pb.swift and .grpc.swift)
protoc --swift_out=$SWIFT_OUT_DIR \
       --grpc-swift_out=$SWIFT_OUT_DIR \
       $PROTO_FILE


# Generate TypeScript files
protoc --plugin=protoc-gen-ts=$(which protoc-gen-ts) \
       --ts_out=$TS_OUT_DIR \
       $PROTO_FILE
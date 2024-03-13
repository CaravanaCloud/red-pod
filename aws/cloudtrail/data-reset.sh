#!/bin/bash
set -x

TRAIL_BUCKET=${TRAIL_BUCKET:-"s3://jufaerma-ap-northeast-1"}
DATA_DIR="./.data"

aws s3 rm $TRAIL_BUCKET/* --recursive
rm -rf $DATA_DIR
echo "Data reset complete"

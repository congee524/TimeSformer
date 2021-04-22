#!/usr/bin/env bash

set -x

PARTITION=$1
JOB_NAME=$2
CONFIG=$3
GPUS=${GPUS:-8}
GPUS_PER_NODE=${GPUS_PER_NODE:-8}
CPUS_PER_TASK=${CPUS_PER_TASK:-2}
SRUN_ARGS=${SRUN_ARGS:-""}
PY_ARGS=${@:4}  # Any arguments from the forth one are captured by this

PYTHONPATH="$(dirname $0)/..":$PYTHONPATH \
srun -p ${PARTITION} \
    --job-name=${JOB_NAME} \
    --gres=gpu:${GPUS_PER_NODE} \
    --ntasks=1 \
    --ntasks-per-node=1 \
    --cpus-per-task=${CPUS_PER_TASK} \
    --kill-on-bad-exit=1 \
    ${SRUN_ARGS} \
    python tools/run_net.py \
        --cfg configs/Kinetics/TimeSformer_divST_8x32_224.yaml \
        DATA.PATH_TO_DATA_DIR data/kinetics400 \
        NUM_GPUS 8 \
        TRAIN.BATCH_SIZE 8 \

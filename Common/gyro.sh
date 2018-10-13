#!/bin/sh

# To use this script set in your paths.sh :
# DATAMODEL_PATH=<path_to_my_data_model>

# Load variables from paths.sh if it exists
test -f "$(dirname $0)/paths.sh" && source "$(dirname $0)/paths.sh"

# Set this in your environment variable, for example:
if [ ! -d "$DATAMODEL_PATH" ]; then
	echo You must define the DATAMODEL_PATH variable to the path to the xcdatamodel file
	exit 1
fi

MODEL_OUTPUT_DIR=$(dirname $0)/../atmatm/atmatm/Models/Realm
gyro --model "$DATAMODEL_PATH" --output "$MODEL_OUTPUT_DIR" -t swift4


MAPPER_OUTPUT_DIR=$(dirname $0)/../atmatm/atmatm/Models/Mapper
gyro --model "$DATAMODEL_PATH" --output "$MAPPER_OUTPUT_DIR" -t object-mapper

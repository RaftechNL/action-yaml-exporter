#!/bin/sh -l

SOURCE_FILE=$1
YAML_PROPERTIES=$2
EXPORT_TO_CI_ENV=$3
EXPORT_TO_CI_OUTPUTS=$4
EXPORT_TO_ENV_FILE=$5
ENV_FILE=$6

echo "SOURCE_FILE: $SOURCE_FILE"
echo "YAML_PROPERTIES: $YAML_PROPERTIES"
echo "EXPORT_TO_CI_ENV: $EXPORT_TO_CI_ENV"
echo "EXPORT_TO_CI_OUTPUTS: $EXPORT_TO_CI_OUTPUTS"
echo "EXPORT_TO_ENV_FILE: $EXPORT_TO_ENV_FILE"
echo "ENV_FILE: $ENV_FILE"

#YQ_PATH=$1 /usr/bin/yq 'eval(strenv(YQ_PATH))' .cicd/metadata.yaml

#echo $2

for i in $YAML_PROPERTIES
do
    echo "Now processing... $i"
    echo $i 

    # Splitting the string into key and value
    key=$(echo $i | cut -d '=' -f 1)
    value=$(echo $i | cut -d '=' -f 2)

    echo "Key: $key"
    echo "Value: $value"

    YQ_RESULT=$(YQ_PATH=$value /usr/bin/yq 'eval(strenv(YQ_PATH))' "${SOURCE_FILE}" )
    echo $YQ_RESULT

    if [ "$EXPORT_TO_CI_ENV" = "true" ]; then
        echo "Exporting to CI env"
        echo "$key=$YQ_RESULT" >> $GITHUB_ENV
    fi

    if [ "$EXPORT_TO_CI_OUTPUTS" = "true" ]; then
        echo "Exporting to CI outputs"
        echo "$key=$YQ_RESULT" >> $GITHUB_OUTPUT
    fi

    if [ "$EXPORT_TO_ENV_FILE" = "true" ]; then
        echo "Exporting to env file"
        echo "$key=$YQ_RESULT" >> $ENV_FILE
    fi

done


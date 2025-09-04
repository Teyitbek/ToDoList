#!/bin/sh
#  GoogleServicePLIST.sh

# Name of the resource we're selectively copying
ENVIRONMENT_CONFIGS_INFO_PLIST=EnvironmentConfigs.plist

# Function to check if file exists and copy
check_and_copy() {
    local env=$1
    local file_path=${PROJECT_DIR}/iOS/EnvironmentConfigs/${env}/${ENVIRONMENT_CONFIGS_INFO_PLIST}

    if [ ! -f $file_path ]
    then
        echo "No ${env} ${ENVIRONMENT_CONFIGS_INFO_PLIST} found. Please ensure it's in the proper directory."
        exit 1
    fi

    echo "Using ${file_path}"
    cp "${file_path}" "${PLIST_DESTINATION}"
}

# Get a reference to the destination location for the GoogleService-Info.plist
PLIST_DESTINATION=${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app
echo "Will copy ${CONFIGURATION} ${ENVIRONMENT_CONFIGS_INFO_PLIST} to final destination: ${PLIST_DESTINATION}"

# Check and copy the appropriate GoogleService-Info.plist based on the build configuration
case "${CONFIGURATION}" in
    "Debug(Development)"|"Release(Development)")
        check_and_copy "Development" ;;
    "Debug(Staging)"|"Release(Staging)")
        check_and_copy "Staging" ;;
    "Debug(Production)"|"Release(Production)")
        check_and_copy "Production" ;;
esac


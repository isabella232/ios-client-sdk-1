#!/bin/sh

# This script embeds (and codesigns) a framework within an iOS app binary, but only when the configuration is Device.
# It must be called from, or copied into an Xcode Run Script build phase with following setup:
# Input Files:
#     - Path to framework within project folder (source path) but this need to update when the framework location changed
# Output Files (will handle in script):
#     - Desired path to framework within ${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH} (destination path)
#     - For example: ${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}/bluejeans.framework


if [[ -z ${SCRIPT_INPUT_FILE_0} ]]; then
    echo "This Xcode run script build phase must be configured with input files"
    exit 1
fi
echo "PLATFORM_NAME ${PLATFORM_NAME}"

if [[ $PLATFORM_NAME == 'iphoneos' ]]; then
    FRAMEWORK_APP_PATH="${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
    echo "FRAMEWORK_APP_PATH $FRAMEWORK_APP_PATH"
    
    for (( i=0; i<${SCRIPT_INPUT_FILE_COUNT}; i++ ))
    do
        tmp="SCRIPT_INPUT_FILE_$i"
        FILE=${!tmp}

        echo "file name: $FILE"

        # (##*/) will extract the file name with extension
        # (%%.*) will remove the extension
        FRAMEWORK_EXECUTABLE_NAME=${FILE##*/}
        FRAMEWORK_EXECUTABLE_PATH="$FRAMEWORK_APP_PATH/$FRAMEWORK_EXECUTABLE_NAME"
        #${SCRIPT_INPUT_FILE_0##*/}
        
        #This is where the framework will be copied. Below command will only work for ios- architecture
        CP_FROM=$FILE
        #${SCRIPT_INPUT_FILE_0}

        #This is where the framework will be pasted
        CP_TO=$FRAMEWORK_APP_PATH"/"
        
        #Copy the framework
        mkdir -p $FRAMEWORK_APP_PATH
        cp -Rv $CP_FROM $CP_TO

            #Code sign
        CODE_SIGN_IDENTITY_FOR_ITEMS="${EXPANDED_CODE_SIGN_IDENTITY_NAME}"
        if [ "${CODE_SIGN_IDENTITY_FOR_ITEMS}" = "" ] ; then
            CODE_SIGN_IDENTITY_FOR_ITEMS="${CODE_SIGN_IDENTITY}"
        fi
            codesign --force --verbose --sign "${CODE_SIGN_IDENTITY_FOR_ITEMS}" "${FRAMEWORK_EXECUTABLE_PATH}"
    
    done
    echo "Embedded framework successfully"
else
    echo "Skip for simulator"
fi

FRAMEWORK_NAME="JackpotRising"

lipo -create -output "${FRAMEWORK_NAME}" "Release-iphonesimulator/${FRAMEWORK_NAME}.framework/${FRAMEWORK_NAME}" "Release-iphoneos/${FRAMEWORK_NAME}.framework/${FRAMEWORK_NAME}"

cp -R Release-iphoneos/${FRAMEWORK_NAME}.framework ./${FRAMEWORK_NAME}.framework

mv ${FRAMEWORK_NAME} ./${FRAMEWORK_NAME}.framework/${FRAMEWORK_NAME}

cp -r "Release-iphonesimulator/${FRAMEWORK_NAME}.framework/Modules/${FRAMEWORK_NAME}.swiftmodule/" "./${FRAMEWORK_NAME}.framework/Modules/${FRAMEWORK_NAME}.swiftmodule/"
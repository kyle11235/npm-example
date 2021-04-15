BUILD_NAME=cli-npm-build
BUILD_NUMBER=4

jfrog rt npmci --build-name=$BUILD_NAME --build-number=$BUILD_NUMBER
jfrog rt npmp --build-name=$BUILD_NAME --build-number=$BUILD_NUMBER
jfrog rt bp $BUILD_NAME $BUILD_NUMBER
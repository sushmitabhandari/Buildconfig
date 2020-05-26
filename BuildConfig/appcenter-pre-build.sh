
echo "hello"
export API_URL="dhwjhd/ww"
if [ -z "${API_URL}" ]
then
    echo "You need define the API_URL variable in App Center"
    exit
fi

APP_CONSTANT_FILE=./BuildConfig/AppConstant.cs

if [ -e "$APP_CONSTANT_FILE" ]
then
    echo "Updating ApiUrl to $API_URL in AppConstant.cs"
    sed -i '' 's#ApiUrl = "[-A-Za-z0-9:_./]*"#ApiUrl = "'$API_URL'"#' $APP_CONSTANT_FILE

    echo "File content:"
    cat $APP_CONSTANT_FILE
fi


#For Package file
echo "##[warning][Pre-Build Action] - Lets do some Pre build transformations..."

# Declare local script variables
SCRIPT_ERROR=0
export APP_DISPLAY_NAME="lastest"
export APP_ICON_FOLDER="Assets.xcassets/AppIcon.alpha.appiconset"
export PACKAGE_NAME="com.ds.dh"
export APP_ICON="@dddghtdwdwq/djj"
 echo "$APP_ICON"
# Define the files to manipulate
INFO_PLIST_FILE=./iOS/Info.plist
ANDROID_MAINACTIVITY_FILE=./Droid/MainActivity.cs
ANDROID_MANIFEST_FILE=./Droid/Properties/AndroidManifest.xml
echo "##[warning][Pre-Build Action] - Checking if all files and environment variables are available..."

if [ -z "${APP_DISPLAY_NAME}" ]
then
    echo "##[error][Pre-Build Action] - APP_DISPLAY_NAME variable needs to be defined in App Center!!!"
    let "SCRIPT_ERROR += 1"
    else
    echo "##[warning][Pre-Build Action] - APP_DISPLAY_NAME variable - oK!"
fi

if [ -e "${INFO_PLIST_FILE}" ]
then
    echo "##[warning][Pre-Build Action] - Info.plist file found - oK!"
else
    echo "##[error][Pre-Build Action] - Info.plist file not found!"
    let "SCRIPT_ERROR += 1"
fi

if [ -e "${ANDROID_MAINACTIVITY_FILE}" ]
then
    echo "##[warning][Pre-Build Action] - MainActivity file found - oK!"
else
    echo "##[error][Pre-Build Action] - MainActivity file not found!"
    let "SCRIPT_ERROR += 1"
fi

if [ ${SCRIPT_ERROR} -gt 0 ]
then
    echo "##[error][Pre-Build Action] - There are ${SCRIPT_ERROR} errors."
    echo "##[error][Pre-Build Action] - Fix them and try again..."
    exit 1 # this will kill the build
    # exit # this will exit this script, but continues building
else
        echo "Continiing"
fi

echo "##[warning][Pre-Build Action] - There are ${SCRIPT_ERROR} errors."
echo "##[warning][Pre-Build Action] - Now everything is checked, lets change the app display name on iOS and Android..."

######################## Changes on Android
if [ -e "${ANDROID_MAINACTIVITY_FILE}" ]
then
    echo "##[command][Pre-Build Action] - Changing the App display name on Android to: ${APP_DISPLAY_NAME} "
    sed -i '' 's/package="[^"]*"/package="'$PACKAGE_NAME'"/' $ANDROID_MANIFEST_FILE
    sed -i '' "s/Label = \"[-a-zA-Z0-9_ ]*\"/Label = \"${APP_DISPLAY_NAME}\"/" ${ANDROID_MAINACTIVITY_FILE}
   ## sed -i '' 's/Icon = \"[^"]*\"/Icon = "'${APP_ICON}'"/' ${ANDROID_MAINACTIVITY_FILE}
        


    echo "##[section][Pre-Build Action] - MainActivity.cs File content:"
    cat ${ANDROID_MAINACTIVITY_FILE}
    echo "##[section][Pre-Build Action] - MainActivity.cs EOF"
fi

##Package Name
if [ -e "${ANDROID_MANIFEST_FILE}" ]
then
    echo "Updating package name to $PACKAGE_NAME in AndroidManifest.xml"
       sed -i '' 's/package="[^"]*"/package="'$PACKAGE_NAME'"/' $ANDROID_MANIFEST_FILE
       ##sed -i 's\:icon:$APP_ICON' $ANDROID_MANIFEST_FILE
      ## sed -i "" "s|icon/icon|@mipmawclaf/outjj|" /Droid/Properties/AndroidManifest.xml
    sed -i '' 's#icon = "[-A-Za-z0-9:_./]*"#icon = "'$APP_ICON'"#' $ANDROID_MANIFEST_FILE
       echo "File content:"
       cat $ANDROID_MANIFEST_FILE
fi



######################## Changes on iOS
if [ -e "$INFO_PLIST_FILE" ]
then
    echo "##[command][Pre-Build Action] - Changing the App display name on iOS to: $APP_DISPLAY_NAME "
    plutil -replace CFBundleDisplayName -string "$APP_DISPLAY_NAME" $INFO_PLIST_FILE
    plutil -replace XSAppIconAssets -string "$APP_ICON_FOLDER" $INFO_PLIST_FILE

    echo "##[section][Pre-Build Action] - Info.plist File content:"
    cat $INFO_PLIST_FILE
    echo "##[section][Pre-Build Action] - Info.plist EOF"
fi
######################Change version
if [ -z "${APP_VERSION}" ]
then
    echo "You need define the APP_VERSION variable in App Center"
    exit
fi

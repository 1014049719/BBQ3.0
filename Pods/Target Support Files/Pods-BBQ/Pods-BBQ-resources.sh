#!/bin/sh
set -e

mkdir -p "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"

RESOURCES_TO_COPY=${PODS_ROOT}/resources-to-copy-${TARGETNAME}.txt
> "$RESOURCES_TO_COPY"

XCASSET_FILES=()

realpath() {
  DIRECTORY="$(cd "${1%/*}" && pwd)"
  FILENAME="${1##*/}"
  echo "$DIRECTORY/$FILENAME"
}

install_resource()
{
  case $1 in
    *.storyboard)
      echo "ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .storyboard`.storyboardc ${PODS_ROOT}/$1 --sdk ${SDKROOT}"
      ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .storyboard`.storyboardc" "${PODS_ROOT}/$1" --sdk "${SDKROOT}"
      ;;
    *.xib)
      echo "ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .xib`.nib ${PODS_ROOT}/$1 --sdk ${SDKROOT}"
      ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .xib`.nib" "${PODS_ROOT}/$1" --sdk "${SDKROOT}"
      ;;
    *.framework)
      echo "mkdir -p ${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      mkdir -p "${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      echo "rsync -av ${PODS_ROOT}/$1 ${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      rsync -av "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      ;;
    *.xcdatamodel)
      echo "xcrun momc \"${PODS_ROOT}/$1\" \"${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1"`.mom\""
      xcrun momc "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcdatamodel`.mom"
      ;;
    *.xcdatamodeld)
      echo "xcrun momc \"${PODS_ROOT}/$1\" \"${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcdatamodeld`.momd\""
      xcrun momc "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcdatamodeld`.momd"
      ;;
    *.xcmappingmodel)
      echo "xcrun mapc \"${PODS_ROOT}/$1\" \"${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcmappingmodel`.cdm\""
      xcrun mapc "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcmappingmodel`.cdm"
      ;;
    *.xcassets)
      ABSOLUTE_XCASSET_FILE=$(realpath "${PODS_ROOT}/$1")
      XCASSET_FILES+=("$ABSOLUTE_XCASSET_FILE")
      ;;
    /*)
      echo "$1"
      echo "$1" >> "$RESOURCES_TO_COPY"
      ;;
    *)
      echo "${PODS_ROOT}/$1"
      echo "${PODS_ROOT}/$1" >> "$RESOURCES_TO_COPY"
      ;;
  esac
}
if [[ "$CONFIGURATION" == "Debug" ]]; then
  install_resource "DateTools/DateTools/DateTools.bundle"
  install_resource "EGOTableViewPullRefreshAndLoadMore/EGOTableViewPullRefreshAndLoadMore/Resources/blackArrow.png"
  install_resource "EGOTableViewPullRefreshAndLoadMore/EGOTableViewPullRefreshAndLoadMore/Resources/blackArrow@2x.png"
  install_resource "EGOTableViewPullRefreshAndLoadMore/EGOTableViewPullRefreshAndLoadMore/Resources/blackArrowLoadMore.png"
  install_resource "EGOTableViewPullRefreshAndLoadMore/EGOTableViewPullRefreshAndLoadMore/Resources/blackArrowLoadMore@2x.png"
  install_resource "EGOTableViewPullRefreshAndLoadMore/EGOTableViewPullRefreshAndLoadMore/Resources/blueArrow.png"
  install_resource "EGOTableViewPullRefreshAndLoadMore/EGOTableViewPullRefreshAndLoadMore/Resources/blueArrow@2x.png"
  install_resource "EGOTableViewPullRefreshAndLoadMore/EGOTableViewPullRefreshAndLoadMore/Resources/blueArrowLoadMore.png"
  install_resource "EGOTableViewPullRefreshAndLoadMore/EGOTableViewPullRefreshAndLoadMore/Resources/blueArrowLoadMore@2x.png"
  install_resource "EGOTableViewPullRefreshAndLoadMore/EGOTableViewPullRefreshAndLoadMore/Resources/grayArrow.png"
  install_resource "EGOTableViewPullRefreshAndLoadMore/EGOTableViewPullRefreshAndLoadMore/Resources/grayArrow@2x.png"
  install_resource "EGOTableViewPullRefreshAndLoadMore/EGOTableViewPullRefreshAndLoadMore/Resources/grayArrowLoadMore.png"
  install_resource "EGOTableViewPullRefreshAndLoadMore/EGOTableViewPullRefreshAndLoadMore/Resources/grayArrowLoadMore@2x.png"
  install_resource "EGOTableViewPullRefreshAndLoadMore/EGOTableViewPullRefreshAndLoadMore/Resources/whiteArrow.png"
  install_resource "EGOTableViewPullRefreshAndLoadMore/EGOTableViewPullRefreshAndLoadMore/Resources/whiteArrow@2x.png"
  install_resource "EGOTableViewPullRefreshAndLoadMore/EGOTableViewPullRefreshAndLoadMore/Resources/whiteArrowLoadMore.png"
  install_resource "EGOTableViewPullRefreshAndLoadMore/EGOTableViewPullRefreshAndLoadMore/Resources/whiteArrowLoadMore@2x.png"
  install_resource "IDMPhotoBrowser/Classes/IDMPhotoBrowser.bundle"
  install_resource "IDMPhotoBrowser/Classes/IDMPBLocalizations.bundle"
  install_resource "MJRefresh/MJRefresh/MJRefresh.bundle"
  install_resource "Pingpp/lib/Channels/Alipay/AlipaySDK.bundle"
  install_resource "Pingpp/lib/Pingpp.bundle"
  install_resource "UMengSocial/umeng_ios_social_sdk_4.2.3_arm64_custom/UMSocial_Sdk_4.2.3/UMSocialSDKResourcesNew.bundle"
  install_resource "UMengSocial/umeng_ios_social_sdk_4.2.3_arm64_custom/UMSocial_Sdk_Extra_Frameworks/TencentOpenAPI/TencentOpenApi_IOS_Bundle.bundle"
  install_resource "UMengSocial/umeng_ios_social_sdk_4.2.3_arm64_custom/UMSocial_Sdk_4.2.3/SocialSDKXib/UMSCommentDetailController.xib"
  install_resource "UMengSocial/umeng_ios_social_sdk_4.2.3_arm64_custom/UMSocial_Sdk_4.2.3/SocialSDKXib/UMSCommentInputController.xib"
  install_resource "UMengSocial/umeng_ios_social_sdk_4.2.3_arm64_custom/UMSocial_Sdk_4.2.3/SocialSDKXib/UMSCommentInputControlleriPad.xib"
  install_resource "UMengSocial/umeng_ios_social_sdk_4.2.3_arm64_custom/UMSocial_Sdk_4.2.3/SocialSDKXib/UMShareEditViewController.xib"
  install_resource "UMengSocial/umeng_ios_social_sdk_4.2.3_arm64_custom/UMSocial_Sdk_4.2.3/SocialSDKXib/UMShareEditViewControlleriPad.xib"
  install_resource "UMengSocial/umeng_ios_social_sdk_4.2.3_arm64_custom/UMSocial_Sdk_4.2.3/SocialSDKXib/UMSLoginViewController.xib"
  install_resource "UMengSocial/umeng_ios_social_sdk_4.2.3_arm64_custom/UMSocial_Sdk_4.2.3/SocialSDKXib/UMSnsAccountViewController.xib"
  install_resource "UMengSocial/umeng_ios_social_sdk_4.2.3_arm64_custom/UMSocial_Sdk_4.2.3/SocialSDKXib/UMSShareListController.xib"
  install_resource "UMengSocial/umeng_ios_social_sdk_4.2.3_arm64_custom/UMSocial_Sdk_4.2.3/en.lproj"
  install_resource "UMengSocial/umeng_ios_social_sdk_4.2.3_arm64_custom/UMSocial_Sdk_4.2.3/zh-Hans.lproj"
  install_resource "VKInputToolbar/UIInputToolbarSample/Resources/buttonbg.png"
  install_resource "VKInputToolbar/UIInputToolbarSample/Resources/buttonbg@2x.png"
  install_resource "VKInputToolbar/UIInputToolbarSample/Resources/textbg.png"
  install_resource "VKInputToolbar/UIInputToolbarSample/Resources/textbg@2x.png"
  install_resource "VKInputToolbar/UIInputToolbarSample/Resources/textbg_7@2x.png"
  install_resource "VKInputToolbar/UIInputToolbarSample/Resources/toolbarbg.png"
  install_resource "VKInputToolbar/UIInputToolbarSample/Resources/toolbarbg@2x.png"
  install_resource "${BUILT_PRODUCTS_DIR}/MHBlurTutorials.bundle"
  install_resource "${BUILT_PRODUCTS_DIR}/QBImagePicker.bundle"
  install_resource "${BUILT_PRODUCTS_DIR}/RETableViewManager.bundle"
fi
if [[ "$CONFIGURATION" == "Release" ]]; then
  install_resource "DateTools/DateTools/DateTools.bundle"
  install_resource "EGOTableViewPullRefreshAndLoadMore/EGOTableViewPullRefreshAndLoadMore/Resources/blackArrow.png"
  install_resource "EGOTableViewPullRefreshAndLoadMore/EGOTableViewPullRefreshAndLoadMore/Resources/blackArrow@2x.png"
  install_resource "EGOTableViewPullRefreshAndLoadMore/EGOTableViewPullRefreshAndLoadMore/Resources/blackArrowLoadMore.png"
  install_resource "EGOTableViewPullRefreshAndLoadMore/EGOTableViewPullRefreshAndLoadMore/Resources/blackArrowLoadMore@2x.png"
  install_resource "EGOTableViewPullRefreshAndLoadMore/EGOTableViewPullRefreshAndLoadMore/Resources/blueArrow.png"
  install_resource "EGOTableViewPullRefreshAndLoadMore/EGOTableViewPullRefreshAndLoadMore/Resources/blueArrow@2x.png"
  install_resource "EGOTableViewPullRefreshAndLoadMore/EGOTableViewPullRefreshAndLoadMore/Resources/blueArrowLoadMore.png"
  install_resource "EGOTableViewPullRefreshAndLoadMore/EGOTableViewPullRefreshAndLoadMore/Resources/blueArrowLoadMore@2x.png"
  install_resource "EGOTableViewPullRefreshAndLoadMore/EGOTableViewPullRefreshAndLoadMore/Resources/grayArrow.png"
  install_resource "EGOTableViewPullRefreshAndLoadMore/EGOTableViewPullRefreshAndLoadMore/Resources/grayArrow@2x.png"
  install_resource "EGOTableViewPullRefreshAndLoadMore/EGOTableViewPullRefreshAndLoadMore/Resources/grayArrowLoadMore.png"
  install_resource "EGOTableViewPullRefreshAndLoadMore/EGOTableViewPullRefreshAndLoadMore/Resources/grayArrowLoadMore@2x.png"
  install_resource "EGOTableViewPullRefreshAndLoadMore/EGOTableViewPullRefreshAndLoadMore/Resources/whiteArrow.png"
  install_resource "EGOTableViewPullRefreshAndLoadMore/EGOTableViewPullRefreshAndLoadMore/Resources/whiteArrow@2x.png"
  install_resource "EGOTableViewPullRefreshAndLoadMore/EGOTableViewPullRefreshAndLoadMore/Resources/whiteArrowLoadMore.png"
  install_resource "EGOTableViewPullRefreshAndLoadMore/EGOTableViewPullRefreshAndLoadMore/Resources/whiteArrowLoadMore@2x.png"
  install_resource "IDMPhotoBrowser/Classes/IDMPhotoBrowser.bundle"
  install_resource "IDMPhotoBrowser/Classes/IDMPBLocalizations.bundle"
  install_resource "MJRefresh/MJRefresh/MJRefresh.bundle"
  install_resource "Pingpp/lib/Channels/Alipay/AlipaySDK.bundle"
  install_resource "Pingpp/lib/Pingpp.bundle"
  install_resource "UMengSocial/umeng_ios_social_sdk_4.2.3_arm64_custom/UMSocial_Sdk_4.2.3/UMSocialSDKResourcesNew.bundle"
  install_resource "UMengSocial/umeng_ios_social_sdk_4.2.3_arm64_custom/UMSocial_Sdk_Extra_Frameworks/TencentOpenAPI/TencentOpenApi_IOS_Bundle.bundle"
  install_resource "UMengSocial/umeng_ios_social_sdk_4.2.3_arm64_custom/UMSocial_Sdk_4.2.3/SocialSDKXib/UMSCommentDetailController.xib"
  install_resource "UMengSocial/umeng_ios_social_sdk_4.2.3_arm64_custom/UMSocial_Sdk_4.2.3/SocialSDKXib/UMSCommentInputController.xib"
  install_resource "UMengSocial/umeng_ios_social_sdk_4.2.3_arm64_custom/UMSocial_Sdk_4.2.3/SocialSDKXib/UMSCommentInputControlleriPad.xib"
  install_resource "UMengSocial/umeng_ios_social_sdk_4.2.3_arm64_custom/UMSocial_Sdk_4.2.3/SocialSDKXib/UMShareEditViewController.xib"
  install_resource "UMengSocial/umeng_ios_social_sdk_4.2.3_arm64_custom/UMSocial_Sdk_4.2.3/SocialSDKXib/UMShareEditViewControlleriPad.xib"
  install_resource "UMengSocial/umeng_ios_social_sdk_4.2.3_arm64_custom/UMSocial_Sdk_4.2.3/SocialSDKXib/UMSLoginViewController.xib"
  install_resource "UMengSocial/umeng_ios_social_sdk_4.2.3_arm64_custom/UMSocial_Sdk_4.2.3/SocialSDKXib/UMSnsAccountViewController.xib"
  install_resource "UMengSocial/umeng_ios_social_sdk_4.2.3_arm64_custom/UMSocial_Sdk_4.2.3/SocialSDKXib/UMSShareListController.xib"
  install_resource "UMengSocial/umeng_ios_social_sdk_4.2.3_arm64_custom/UMSocial_Sdk_4.2.3/en.lproj"
  install_resource "UMengSocial/umeng_ios_social_sdk_4.2.3_arm64_custom/UMSocial_Sdk_4.2.3/zh-Hans.lproj"
  install_resource "VKInputToolbar/UIInputToolbarSample/Resources/buttonbg.png"
  install_resource "VKInputToolbar/UIInputToolbarSample/Resources/buttonbg@2x.png"
  install_resource "VKInputToolbar/UIInputToolbarSample/Resources/textbg.png"
  install_resource "VKInputToolbar/UIInputToolbarSample/Resources/textbg@2x.png"
  install_resource "VKInputToolbar/UIInputToolbarSample/Resources/textbg_7@2x.png"
  install_resource "VKInputToolbar/UIInputToolbarSample/Resources/toolbarbg.png"
  install_resource "VKInputToolbar/UIInputToolbarSample/Resources/toolbarbg@2x.png"
  install_resource "${BUILT_PRODUCTS_DIR}/MHBlurTutorials.bundle"
  install_resource "${BUILT_PRODUCTS_DIR}/QBImagePicker.bundle"
  install_resource "${BUILT_PRODUCTS_DIR}/RETableViewManager.bundle"
fi

mkdir -p "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
if [[ "${ACTION}" == "install" ]]; then
  mkdir -p "${INSTALL_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
  rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${INSTALL_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
fi
rm -f "$RESOURCES_TO_COPY"

if [[ -n "${WRAPPER_EXTENSION}" ]] && [ "`xcrun --find actool`" ] && [ -n "$XCASSET_FILES" ]
then
  case "${TARGETED_DEVICE_FAMILY}" in
    1,2)
      TARGET_DEVICE_ARGS="--target-device ipad --target-device iphone"
      ;;
    1)
      TARGET_DEVICE_ARGS="--target-device iphone"
      ;;
    2)
      TARGET_DEVICE_ARGS="--target-device ipad"
      ;;
    *)
      TARGET_DEVICE_ARGS="--target-device mac"
      ;;
  esac

  # Find all other xcassets (this unfortunately includes those of path pods and other targets).
  OTHER_XCASSETS=$(find "$PWD" -iname "*.xcassets" -type d)
  while read line; do
    if [[ $line != "`realpath $PODS_ROOT`*" ]]; then
      XCASSET_FILES+=("$line")
    fi
  done <<<"$OTHER_XCASSETS"

  printf "%s\0" "${XCASSET_FILES[@]}" | xargs -0 xcrun actool --output-format human-readable-text --notices --warnings --platform "${PLATFORM_NAME}" --minimum-deployment-target "${IPHONEOS_DEPLOYMENT_TARGET}" ${TARGET_DEVICE_ARGS} --compress-pngs --compile "${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
fi

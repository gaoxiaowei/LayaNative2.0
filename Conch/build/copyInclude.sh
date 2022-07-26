#!/bin/sh
echo ${PRODUCT_NAME}
DES_PATH=${SRCROOT}
echo $DES_PATH
cp -r ${SRCROOT}/conchRuntime/conchRuntime.h $DES_PATH/../../../include/${PRODUCT_NAME}
cp -r ${SRCROOT}/conchRuntime/conchConfig.h $DES_PATH/../../../include/${PRODUCT_NAME}

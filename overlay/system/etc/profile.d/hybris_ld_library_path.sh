#!/bin/sh

# Avoid adding value twice if nested.
case "$HYBRIS_LD_LIBRARY_PATH" in
    *com.android.vndk.v33*)
        return
    ;;
esac

export HYBRIS_LD_LIBRARY_PATH=/system/lib64:/apex/com.android.i18n/lib64:/apex/com.android.vndk.v33/lib64:/apex/com.android.vndk.v31/lib64:/vendor/lib64:/vendor/lib64/hw

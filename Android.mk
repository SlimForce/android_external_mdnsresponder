LOCAL_PATH := $(call my-dir)

##########################

commonSources := \
    mDNSShared/dnssd_clientlib.c  \
    mDNSShared/dnssd_clientstub.c \
    mDNSShared/dnssd_ipc.c

commonLibs := libcutils liblog

commonFlags := -W -Wall -D__ANDROID__ -D_GNU_SOURCE -DHAVE_IPV6 \
    -DNOT_HAVE_SA_LEN -DUSES_NETLINK -DTARGET_OS_LINUX -fno-strict-aliasing \
    -DHAVE_LINUX -DMDNS_UDS_SERVERPATH=\"/dev/socket/mdnsd\" -DMDNS_DEBUGMSGS=0

include $(CLEAR_VARS)
LOCAL_SRC_FILES := $(commonSources)
LOCAL_MODULE := libmdnssd
LOCAL_MODULE_TAGS := optional
LOCAL_CFLAGS := $(commonFlags)
LOCAL_SYSTEM_SHARED_LIBRARIES := libc
LOCAL_SHARED_LIBRARIES := $(commonLibs)
include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_SRC_FILES := $(commonSources)
LOCAL_MODULE := libmdnssd
LOCAL_MODULE_TAGS := optional
LOCAL_CFLAGS := $(commonFlags)
LOCAL_STATIC_LIBRARIES := $(commonLibs)
include $(BUILD_STATIC_LIBRARY)

############################

include $(CLEAR_VARS)
LOCAL_SRC_FILES :=  Clients/dns-sd.c \
                    Clients/ClientCommon.c

LOCAL_MODULE := dnssd
LOCAL_MODULE_TAGS := optional

LOCAL_C_INCLUDES := external/mdnsresponder/mDNSShared

LOCAL_CFLAGS := -W -Wall -D__ANDROID__ -D_GNU_SOURCE -DHAVE_IPV6 -DNOT_HAVE_SA_LEN -DUSES_NETLINK -DTARGET_OS_LINUX -fno-strict-aliasing -DHAVE_LINUX -DMDNS_UDS_SERVERPATH=\"/dev/socket/mdnsd\" -DMDNS_DEBUGMSGS=0

LOCAL_SYSTEM_SHARED_LIBRARIES := libc
LOCAL_SHARED_LIBRARIES := libmdnssd libcutils liblog

include $(BUILD_EXECUTABLE)

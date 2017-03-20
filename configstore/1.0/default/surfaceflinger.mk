
LOCAL_SRC_FILES += SurfaceFlingerConfigs.cpp

ifneq ($(VSYNC_EVENT_PHASE_OFFSET_NS),)
    LOCAL_CFLAGS += -DVSYNC_EVENT_PHASE_OFFSET_NS=$(VSYNC_EVENT_PHASE_OFFSET_NS)
endif

ifneq ($(SF_VSYNC_EVENT_PHASE_OFFSET_NS),)
    LOCAL_CFLAGS += -DSF_VSYNC_EVENT_PHASE_OFFSET_NS=$(SF_VSYNC_EVENT_PHASE_OFFSET_NS)
endif

ifeq ($(NUM_FRAMEBUFFER_SURFACE_BUFFERS),3)
    LOCAL_CFLAGS += -DUSE_TRIPLE_FRAMEBUFFER
endif

ifeq ($(TARGET_BOARD_PLATFORM),omap4)
    LOCAL_CFLAGS += -DUSE_CONTEXT_PRIORITY=1
endif

ifeq ($(TARGET_BOARD_PLATFORM),s5pc110)
    LOCAL_CFLAGS += -DUSE_CONTEXT_PRIORITY=1
endif

ifeq ($(TARGET_HAS_WIDE_COLOR_DISPLAY),true)
    LOCAL_CFLAGS += -DHAS_WIDE_COLOR_DISPLAY
endif

ifeq ($(TARGET_HAS_HDR_DISPLAY),true)
    LOCAL_CFLAGS += -DHAS_HDR_DISPLAY
endif

ifneq ($(PRESENT_TIME_OFFSET_FROM_VSYNC_NS),)
    LOCAL_CFLAGS += -DPRESENT_TIME_OFFSET_FROM_VSYNC_NS=$(PRESENT_TIME_OFFSET_FROM_VSYNC_NS)
else
    LOCAL_CFLAGS += -DPRESENT_TIME_OFFSET_FROM_VSYNC_NS=0
endif

ifeq ($(TARGET_FORCE_HWC_FOR_VIRTUAL_DISPLAYS),true)
    LOCAL_CFLAGS += -DFORCE_HWC_COPY_FOR_VIRTUAL_DISPLAYS
endif

ifneq ($(MAX_VIRTUAL_DISPLAY_DIMENSION),)
    LOCAL_CFLAGS += -DMAX_VIRTUAL_DISPLAY_DIMENSION=$(MAX_VIRTUAL_DISPLAY_DIMENSION)
endif

ifeq ($(TARGET_RUNNING_WITHOUT_SYNC_FRAMEWORK),true)
    LOCAL_CFLAGS += -DRUNNING_WITHOUT_SYNC_FRAMEWORK
endif

ifneq ($(USE_VR_FLINGER),)
    LOCAL_CFLAGS += -DUSE_VR_FLINGER
endif

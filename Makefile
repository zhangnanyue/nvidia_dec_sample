################################################################################
#
# Copyright 2017-2019 NVIDIA Corporation.  All rights reserved.
#
# Please refer to the NVIDIA end user license agreement (EULA) associated
# with this source code for terms and conditions that govern your use of
# this software. Any use, reproduction, disclosure, or distribution of
# this software and related documentation outside the terms of the EULA
# is strictly prohibited.
#
################################################################################

DECODE_APPS := AppDec 

ENCODE_APPS := 

TRANSCODE_APPS := 

APPS := $(addprefix ./,$(DECODE_APPS))

.PHONY: build $(APPS)

build: $(APPS)

$(APPS):
	$(MAKE) -C $@

CLEAN := $(addsuffix .clean,$(APPS))

.PHONY: clean $(CLEAN)

clean: $(CLEAN)

$(CLEAN): %.clean:
	$(MAKE) -C $* clean

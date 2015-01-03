#!/bin/sh

erl -emu_args -name skel@localhost \
	-pa deps/*/ebin  \
	-pa apps/*/ebin  \
	-boot start_sasl \
	-s skel_app start
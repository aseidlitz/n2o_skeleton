erl -emu_args -name skel@localhost ^
	-pa deps/cowboy/ebin ^
	-pa deps/cowlib/ebin ^
	-pa deps/erlydtl/ebin ^
	-pa deps/gproc/ebin ^
	-pa deps/n2o/ebin ^
	-pa deps/ranch/ebin ^
	-pa apps/skel/ebin ^
	-boot start_sasl ^
	-s skel_app start



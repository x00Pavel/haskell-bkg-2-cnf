PROJ_NAME=flp21-fun
BUILD_DIR=build
OPTS=-Wall
LOGIN=xyadlo00
TEST_DEST_O=extra/${PROJ_NAME}

.PHONY: make test clean run

make:
	mkdir -p ${BUILD_DIR}
	ghc ${OPTS} src/* -o ${PROJ_NAME} -hidir ${BUILD_DIR} -odir ${BUILD_DIR}

testbuild:
	ghc ${OPTS} src/* -o ${TEST_DEST_O} -hidir ${BUILD_DIR} -odir ${BUILD_DIR}

test:
	cd extra/ && pytest ./ -sv

run: make
	./${PROJ_NAME} test/test01.in -i

clean:
	rm -rf ${BUILD_DIR} `find ./ -name "*${PROJ_NAME}"` `find ./ -name "*py*cache*"`

zip:
	zip -r flp-fun-$(LOGIN).zip ./* -x .git*

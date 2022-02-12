PROJ_NAME=flp21-fun
BUILD_DIR=build
OPTS=-Wall
LOGIN=xyadlo00

make:
	mkdir -p ${BUILD_DIR}
	ghc ${OPTS} src/* -o ${PROJ_NAME} -hidir ${BUILD_DIR} -odir ${BUILD_DIR}

run: make
	./${PROJ_NAME}

clean:
	rm -rf ${BUILD_DIR} ${PROJ_NAME}

zip:
	zip -r flp-fun-$(LOGIN).zip ./* -x .git*
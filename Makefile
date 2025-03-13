PLATFORM ?= linux/amd64
GIT_TAG ?= latest

REGISTRY_PREFIX ?= anyflow
NAME := staffonly

# Makefile lint recommends that have to use the PHONY target when It is possible to not fixed the target.
.PHONY: default
default: build_image run_image


print_environment:
	@echo ${PURPLE}"================================================================================================="$
	@echo "PLATFORM : ${PLATFORM}"
	@echo "NAME : ${NAME}"
	@echo "GIT_TAG : ${GIT_TAG}"
	@echo "================================================================================================="${COLOR_OFF}

handle_image: print_environment
	docker buildx build \
	${BUILD_IMAGE_OPTION} \
	--platform ${PLATFORM} \
	--tag ${REGISTRY_PREFIX}/${NAME}:${GIT_TAG} \
	--file ./Dockerfile \
	.

# Need GIT_TAG
build_image: BUILD_IMAGE_OPTION=--load
build_image: handle_image

# Need GIT_TAG
push_image: BUILD_IMAGE_OPTION=--push
push_image: handle_image

run_image:
	docker pull ${REGISTRY_PREFIX}/${NAME}:${GIT_TAG}
	docker run --rm -d \
	-t ${REGISTRY_PREFIX}/${NAME}:${GIT_TAG}

run_in_k8s:
	@POD_NAME=$$(kubectl get pods -n service | grep '^staffonly' | awk '{print $$1}' | head -n 1); \
	if [ -z "$$POD_NAME" ]; then \
		echo "No pod found with prefix 'staffonly' in namespace 'service'"; \
		exit 1; \
	else \
		echo "Executing zsh in pod: $$POD_NAME"; \
		kubectl exec -it -n service $$POD_NAME -- zsh; \
	fi
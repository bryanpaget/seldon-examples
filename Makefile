IMAGE_NAME=seldonio/sklearn-iris-jsondata
IMAGE_VERSION=0.2

build_image: train
	s2i build -E environment . seldonio/seldon-core-s2i-python37-ubi8:1.7.0-dev ${IMAGE_NAME}:${IMAGE_VERSION}

push_image:
	docker push $(IMAGE_NAME):$(IMAGE_VERSION)

kind_load:
	kind load -v 3 docker-image ${IMAGE_NAME}:${IMAGE_VERSION}

.PHONY: train
train:
	python train_iris.py

.PHONY: clean
clean:
	rm -rf IrisClassifier.sav

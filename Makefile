DOCKER_TAG?=latest
DOCKER_REPO=renier/slack-notify

default:
	docker build -t $(DOCKER_REPO):$(DOCKER_TAG) .

push:
	docker push $(DOCKER_REPO):$(DOCKER_TAG)

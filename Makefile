## The Makefile includes instructions on environment setup and lint tests

install:
	# This instruction creates an environment with all the requirements and dependencies needed
	conda env create --file dashboard.yml
	# Activate environment
	conda activate dash_avocado
	# install eksctl
	curl --silent --location "https://github.com/weaveworks/eksctl/releases/download/latest_release/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
    sudo mv /tmp/eksctl /bin
	chmod +x /bin/eksctl
	# install kubectl
	curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
	curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
    echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
	sudo install -o root -g root -m 0755 kubectl /bin/kubectl
	chmod +x /bin/kubectl
	# install hadolint
	wget -O /bin/hadolint https://github.com/hadolint/hadolint/releases/download/v1.16.3/hadolint-Linux-x86_64 &&\
	chmod +x /bin/hadolint

test:
	# Additional, optional, tests could go here
	#python -m pytest -vv --cov=myrepolib tests/*.py
	#python -m pytest --nbval notebook.ipynb

lint:
	hadolint Dockerfile
	pylint --load-plugins pylint_flask --disable=R,C,W1203,W1202 my_app/app.py

run-dashboard:
	# Initiate dashboard locally
	conda run -n dash_avocado python my_app/app.py


create-cluster:
	./shell_scripts/create_cluster.sh

delete-cluster:
	./shell_scripts/delete_cluster.sh

cleanup-kubernetes:
	./shell_scripts/delete_kubernetes_stuff.sh

update_app:
	./shell_scripts/update_application.sh

rollback:
	./shell_scripts/rollback_deployment.sh

k8s-cleanup-resources:
	./bin/k8s_cleanup_resources.sh


all: install lint

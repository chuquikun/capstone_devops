## The Makefile includes instructions on environment setup and lint tests

set_env:
	# This instruction creates an environment with all the requirements and dependencies needed
	conda env create --file dashboard.yml
	
	# install eksctl
	curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_linux_amd64.tar.gz" | tar xz -C /tmp
	mv /tmp/eksctl /bin
	chmod +x /bin/eksctl
	
	# install kubectl
	curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
	install -o root -g root -m 0755 kubectl /bin/kubectl
	chmod +x /bin/kubectl
	
	# install hadolint
	wget -O /bin/hadolint https://github.com/hadolint/hadolint/releases/download/v1.16.3/hadolint-Linux-x86_64 &&\
	chmod +x /bin/hadolint

install_kube_deps:

	# install eksctl
	curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_linux_amd64.tar.gz" | tar xz -C /tmp
	mv /tmp/eksctl /bin
	chmod +x /bin/eksctl
	
	# install kubectl
	curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.26.2/2023-03-17/bin/linux/arm64/kubectl
	chmod +x ./kubectl
	mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin
	echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc
	./kubectl version --short --client




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

deploy_app:
	./shell_scripts/app_deployment.sh

update_app:
	./shell_scripts/update_application.sh

rollback:
	./shell_scripts/rollback_deployment.sh

k8s-cleanup-resources:
	./bin/k8s_cleanup_resources.sh


all: install lint

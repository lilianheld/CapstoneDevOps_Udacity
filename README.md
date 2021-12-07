## Circle CI Status
[![lilianheld](https://circleci.com/gh/lilianheld/CapstoneDevOps_Udacity.svg?style=svg)](https://app.circleci.com/pipelines/github/lilianheld/CapstoneDevOps_Udacity)

## Project Overview

The goal of this project is to establish a Continous Integration Continous Deployment Pipeline using CircleCi for a flask application that is returning the predicted prices for houses based on some input values. 

You are given a pre-trained, `sklearn` model that has been trained to predict housing prices in Boston according to several features, such as average rooms in a home and data about highway access, teacher-to-pupil ratios, and so on. You can read more about the data, which was initially taken from Kaggle, on [the data source site](https://www.kaggle.com/c/boston-housing).

### Project Tasks

The project's goal was to create a CICD Pipeline using [kubernetes](https://kubernetes.io/), which is an open-source system for automating the management of containerized applications. The Pipeline includes the following steps:
1. CONTINOUS INTEGRATION
* build-and-lint: 
    - installs all dependencies from requirements.txt file
    - lints the Dockerfile using hadolint
* push-image:
    - creates a docker image based on the DOCKERFILE
    - push the created docker image to AWS Elastic Container Registry (ECR)
2. CONTINOUS DEPLOYMENT (Blue-Green-Deployment via Updating the LoadBalancer)
* update_deployment_spec:
    - updates the deployment.yaml specification for the kubernetes deployment to use the previously uploaded image
    - updates the service.yaml specification for the loadbalancer to point to the newly created pods (selector is the version=imagetag)
* create_deployment: create new deployment with two newly created pods executing the latest container image
* update_service: update the load balancer service to lead traffic to the newly created pods
* smoke_test: curl the external ClusterIP to assure that the pods are running and responing on port 8000
3. CLEANUP
* get_currentVersion: this job is run at the beginning of the pipeline to get the currently running software version
* delete_old_image: delete image on ECR with tag=currentVersion
* delete_old_deployment: delete previous deployments and the corresponding pods 


---

## Prerequistites
In order to enable a deployment to an EKS cluster via the CircleCi Pipeline, the EKS cluster needs to be created beforehand. 
### Setup EKS cluster on AWS
* Create an EKS cluster using `eksctl` - this will create a cloudformation stack in the background with all the necessary AWS Ressources
```bash
eksctl create cluster --name capstone --region us-east-2
# create namespace to bundle all ressourcen in one location in cluster
kubectl create namespace bluegreen
# if you want to interact with the cluster from your local environment, it might come handy to set the namespace in the current context via
kubectl config set-context --current --namespace=bluegreen
```


### Setup Environment to execute flaskapp locally

* Create a virtualenv with Python 3.7 and activate it. Refer to this link for help on specifying the Python version in the virtualenv. 
```bash
python3 -m pip install --user virtualenv
# You should have Python 3.7 available in your host. 
# Check the Python path using `which python3`
# Use a command similar to this one:
python3 -m virtualenv --python=<path-to-Python3.7> .devops
source .devops/bin/activate
```
* Run `make install` to install the necessary dependencies

### Running `app.py`

1. Standalone:  `python app.py`
2. Run in Docker:  `./run_docker.sh`
3. Run in Kubernetes:  `./run_kubernetes.sh`

### Retrieving predicitions

1. Run the flask app following one of the above instructions
2. Run: `./make_predictions.sh` to retrieve a prediction for the inout parameters, specified in the make_predictions script
### Kubernetes Steps

* Setup and Configure Docker locally
* Setup and Configure Kubernetes locally
* Create Flask app in Container
* Run via kubectl

### Project Files and Folders - TO BE REVIEWED
* .circleci/config.yml:     contains the definition of steps that are run within the circleci pipeline - install dependencies & linting
* model_data:               contains all files related to the pretrained ML model
* output_txt_files:         contain outputs after executing the run_docker and run_kubernetes scripts
* app.py:                   main file to start the flask application
* Dockerfile:               instructions to build a docker image of flask app
* make_predictions.sh:      run predictions using the running flask app
* Makefile:                 lint the Dockerfile
* pod-spec.yaml:            defines the pod setup for the flask app running on a kubernetes cluster (which image to use, required secrets to pull image from private docker hub                               repo, ...)
* requirements.txt:         libraries required in order to run the flask app
* resize.sh:                increase disk space in cloud9 environment (required in order to being able to install kubernetes & minikube)
* run_docker.sh:            run flask app in docker container
* run_kubernetes.sh:        run flask app in kubernetes cluster
* upload_docker.sh:            upload docker image to private github repo
## Circle CI Status
[![lilianheld](https://circleci.com/gh/lilianheld/CapstoneDevOps_Udacity.svg?style=svg)](https://app.circleci.com/pipelines/github/lilianheld/CapstoneDevOps_Udacity)

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

## Project Overview - TO BE REVIEWED

In this project, you will apply the skills you have acquired in this course to operationalize a Machine Learning Microservice API. 

You are given a pre-trained, `sklearn` model that has been trained to predict housing prices in Boston according to several features, such as average rooms in a home and data about highway access, teacher-to-pupil ratios, and so on. You can read more about the data, which was initially taken from Kaggle, on [the data source site](https://www.kaggle.com/c/boston-housing). This project tests your ability to operationalize a Python flask app—in a provided file, `app.py`—that serves out predictions (inference) about housing prices through API calls. This project could be extended to any pre-trained machine learning model, such as those for image recognition and data labeling.

### Project Tasks - TO BE REVIEWED

Your project goal is to operationalize this working, machine learning microservice using [kubernetes](https://kubernetes.io/), which is an open-source system for automating the management of containerized applications. In this project you will:
* Test your project code using linting
* Complete a Dockerfile to containerize this application
* Deploy your containerized application using Docker and make a prediction
* Improve the log statements in the source code for this application
* Configure Kubernetes and create a Kubernetes cluster
* Deploy a container using Kubernetes and make a prediction
* Upload a complete Github repo with CircleCI to indicate that your code has been tested

You can find a detailed [project rubric, here](https://review.udacity.com/#!/rubrics/2576/view).

**The final implementation of the project will showcase your abilities to operationalize production microservices.**

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


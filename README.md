# devops_interview

This is a hands-on assessment of Infrastructure-as-Code (IaC), CI/CD, and public cloud providers. You must use AWS as the development platform, you may use `aws cloudformation`, or `terraform` command-line interface tools. Please do not spend more than 2 hours on this task. You're not expected to setup your own personal cloud account, but there should be enough configuration details so that deploying to a real cloud environment will theoretically work. Be prepared to justify your design.

## Setup:
1. Clone this repo into your own Github account
2. Setup a [free CircleCI accout](https://circleci.com/docs/2.0/first-steps/) and hook up your repo

## Background:
A simple Flask webserver that displays "Hello World from Frontrow!" runs on a Virtual Machine on the cloud.


## Requirements:
- Complete `./circle/config.yml` file that installs CLI tools as needed, configures auth, performs basic sanity tests, and deploys resources
- Deploy this application through [AWS Elastic Beanstalk](https://aws.amazon.com/elasticbeanstalk/) to see "Hello World from Frontrow!" on a public URL
- Configure the repo to automatically trigger deploys on Github merge
- Basic Documentation (README.md) and architecture diagram
- Utilizing AWS Lambda, create a lambda function using [Serverless](https://www.serverless.com/) that listens for requests to the "/quotes" endpoint and serves results via the browser or CURL


# README

![GillianRickerd](https://circleci.com/gh/GillianRickerd/devops_interview.svg?style=svg)


Application is deployed in 2 ways, both of which are done automatically through CircleCI

![Architecture diagram](/architecture-diagram.png)

## CircleCI
There is currently one workflow for one environment

Tests will run on any branch, the deploy step will only run on `main`

### Current workflow
#### Install

Installs dependencies for python application and serverless framework
#### Test

Runs tests; currently this is linting for python code and terraform

**TODO:** add python test step here when there are python unit tests

**TODO:** add serverless config validation here (the config is setup so `sls wsgi serve` fails and deploy will fail if there are errors but it’d be nice to know before the pipeline gets to the deploy step)

#### Deploy
1. Deploys the application using serverless framework to AWS Lambda
2. Deploys the application using terraform to Elastic Beanstalk


## Serverless framework
This automatically creates the AWS Lambda and corresponding API Gateway given the configurations. Configurations live in `./webserver/serverless.yml`

### Running locally
`serverless wsgi serve` — runs application with serverless locally (AWS not needed for this)

`serverless deploy` — deploys application from your local environment to the configured AWS account


### Terraform
Terraform creates all of the necessary infrastructure for the Elastic Beanstalk version of the app. Configuration files live in `./terraform`

Run the following to verify changes, fix formatting, and deploy changes.

`terraform init` — initializes backend, installs providers, etc.

`terraform validate` - confirms the terraform configurations are corrrect without accessing any remove services (state, APIs, etc.)

`terraform fmt` — auto formats terraform files

`terraform plan` — shows output of what will be changed on the apply step; *always run this to make sure there are no conflicts with the state, errors in the changes, etc.*

`terraform apply` — pushes changes to AWS


## AWS setup
Keys for the IAM user need to be set in environment variables in CI (and locally if doing any deploys from local machine)

**TODO:** update the IAM user to have only the bare necessities for permissions instead of admin access
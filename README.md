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

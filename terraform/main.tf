# create s3 bucket for storing zip file of required files for Elastic Beanstalk
resource "aws_s3_bucket" "app_zip_storage" {
  bucket = "gillian-devops-${var.env}"
}

# create zip of files for app deploy
data "archive_file" "python_app_files" {
  type        = "zip"
  output_path = "/tmp/python-app-files.zip"
  source_dir  = "${path.module}/../webserver/"
  excludes = [
    ".serverless",
    "__pycache__",
    "node_modules",
    "venv",
  ]
}

# put zip file from tmp into the s3 bucket
resource "aws_s3_bucket_object" "app_files_object" {
  bucket = aws_s3_bucket.app_zip_storage.id
  key    = "python-app-files.zip"
  source = data.archive_file.python_app_files.output_path
}

# create elastic beanstalk application
resource "aws_elastic_beanstalk_application" "elasticapp" {
  name = "elastic_beanstalk_python_app-${var.env}"
}

# create elastic beanstalk environment
resource "aws_elastic_beanstalk_environment" "elastic_beanstalk_env" {
  name                = "elastic-beanstalk-python-app-env-${var.env}"
  application         = "elastic_beanstalk_python_app-${var.env}"
  solution_stack_name = "64bit Amazon Linux 2 v3.4.0 running Python 3.8"

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "aws-elasticbeanstalk-ec2-role"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "t2.micro"
  }
}

# create elastic beanstalk new version of app to be deployed
resource "aws_elastic_beanstalk_application_version" "eb_app_version" {
  name        = "eb_version-${var.env}"
  application = "elastic_beanstalk_python_app-${var.env}"
  description = "python app version for ${var.env}"
  bucket      = aws_s3_bucket.app_zip_storage.id
  key         = aws_s3_bucket_object.app_files_object.id
}
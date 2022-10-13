output "app_version" {
  value = aws_elastic_beanstalk_application_version.eb_app_version.name
}
output "env_name" {
  value = aws_elastic_beanstalk_environment.elastic_beanstalk_env.name
}
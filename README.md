# AWS-DevOps-Pipeline-Nginx-project

This project demonstrates a complete CI/CD pipeline setup for an Nginx application using AWS DevOps tools. It integrates AWS CodeCommit, CodeBuild, CodeDeploy, and CodePipeline to automate the deployment process. The pipeline includes stages for source, build, deploy, manual approval, and production, with detailed steps and configurations ensuring robust deployment while handling IAM permissions and YAML configuration challenges.

AWS CodeCommit:

Create a repository, generate IAM credentials, clone the repo, and push initial code.
AWS CodeBuild:

Configure the build project, create a buildspec.yml file, and start the build. Artifacts are uploaded to S3.
Set up CloudWatch and SNS notifications for build phase changes.
AWS CodeDeploy:

Set up service roles for EC2 and S3, create an application and deployment group, and install the CodeDeploy agent on EC2 instances.
Create nginx.sh, then push them to CodeCommit.

Configure deployment settings and handle application lifecycle events.
AWS CodePipeline:

Configure the pipeline with source, build, and deploy stages.
Add manual approval and production stages.
Trigger the pipeline by pushing code changes and monitor the deployment process.
Challenges and Solutions:

Resolved IAM permission issues and YAML configuration errors to ensure successful deployments.
Key Files:

index.html: Landing page for the Nginx app.
buildspec.yml: Defines build commands and artifact storage.
appspec.yml: Specifies deployment instructions and lifecycle hooks.
install_nginx.sh: Script to install Nginx.
start_nginx.sh: Script to start the Nginx service.
Manual Approval and Production Stages:

Create a new EC2 instance with a "prod" tag, set up a deployment group for production, and add a manual approval stage in CodePipeline.
Check in changed code to trigger the pipeline and monitor the process.
This project demonstrates efficient deployment practices and robust pipeline configurations using AWS DevOps tools, ensuring smooth management and deployment of changes.

AWS DevOps Project: 
Complete CI/CD Pipeline for automated deploying og Nginx Application
(all files and snapshots are available in the repo)

In this project I have showcased the setup and deployment of an Nginx application using AWS DevOps tools such as:
AWS CodeCommit,
AWS CodeBuild, 
AWS CodeDeploy,
AWS CodePipeline
It also includes the steps to add manual approval and production stages to ensure a robust deployment pipeline. 
Below is a detailed guide, including the hardships and troubleshooting encountered during the project.

Step 1: Version Control with AWS CodeCommit

Create a CodeCommit Repository

Open AWS CodeCommit and create an empty repository.
Configure IAM User

Assign an IAM user with CodeCommit permissions.
Generate security credentials (git credentials).
Clone the Repository

Clone the CodeCommit repository to your local machine:

git clone https://git-codecommit.<region>.amazonaws.com/v1/repos/<repository_name>
Add Initial Files

Add necessary files such as index.html, buildspec.yml, appspec.yml, install_nginx.sh, and start_nginx.sh.
bash
Copy code
git add .
git commit -m "Initial commit"
git push origin master
Configure Repository Settings

Set up notifications and triggers using Amazon SNS.
Step 2: Build Process with AWS CodeBuild
Create a Build Project

Open AWS CodeBuild and create a new build project.
Specify the source as the CodeCommit repository.
Service Role

Create a service role with permissions for CodeBuild.
Build Specification File

Create a buildspec.yml file:

version: 0.2

phases:
  install:
    commands:
      - echo Installing NGINX
      - sudo apt-get update
      - sudo apt-get install nginx -y
  build:
    commands:
      - echo Build started on $(date)
      - cp index.html /usr/share/nginx/html
  post_build:
    commands:
      - echo Configuring NGINX

artifacts:
  files:
    - '**/*'
Start the Build

Trigger the build and verify the build details and artifacts.
Notification Setup

Create CloudWatch rules for build phase change notifications and target SNS topics for notifications.
Step 3: Deploy with AWS CodeDeploy
Create a Service Role

Create a service role for CodeDeploy with permissions for EC2 and S3 access.
Launch EC2 Instances

Create an EC2 instance and associate it with an IAM instance profile.
Use the following user data script to install the CodeDeploy agent:

#!/bin/bash
yum update -y
yum install -y ruby
cd /home/ec2-user
wget https://aws-codedeploy-<region>.s3.<region>.amazonaws.com/latest/install
chmod +x ./install
./install auto
service codedeploy-agent start
service codedeploy-agent status
Create an Application and Deployment Group

Open AWS CodeDeploy and create a new application.
Create a deployment group and configure it to target the EC2 instance.
AppSpec File

Create an appspec.yml file for deployment instructions:

version: 0.0
os: linux
files:
  - source: /
    destination: /usr/share/nginx/html
hooks:
  AfterInstall:
    - location: scripts/install_nginx.sh
      timeout: 300
      runas: root
  ApplicationStart:
    - location: scripts/start_nginx.sh
      timeout: 300
      runas: root
Scripts for Deployment

Create install_nginx.sh and start_nginx.sh scripts and commit them to the repository:

# install_nginx.sh
#!/bin/bash
sudo dnf update -y
sudo dnf install nginx -y
chmod +x scripts/install_nginx.sh

# start_nginx.sh
#!/bin/bash
sudo systemctl start nginx
sudo systemctl enable nginx
Verification:

Verify deployment events, logs, and application access.

Step 4: Continuous Integration and Deployment with AWS CodePipeline
Create a Pipeline

Open AWS CodePipeline and create a new pipeline.
Add stages for Source, Build, and Deploy.
Manual Approval and Production Stage

Add a manual approval stage before production deployment.
Configure a production deployment stage.
Trigger Pipeline

Commit changes to the repository to trigger the pipeline.
Monitor the pipeline process and verify successful deployment.
Additional Configurations:

Set up notifications for pipeline events using SNS.
Create and configure IAM roles and policies for all services involved.
Hardships and Troubleshooting
Build Failures Due to Incorrect buildspec.yml Configuration

Encountered errors with YAML syntax and incorrect paths.
Resolved by validating the YAML syntax and ensuring correct file paths.
Deployment Failures Due to IAM Role Misconfigurations

Faced issues with insufficient permissions for EC2 and S3.
Resolved by creating and assigning correct IAM roles and policies.
CodeDeploy Agent Installation Issues

Initial attempts to install the CodeDeploy agent failed due to outdated package repositories.
Resolved by updating the package list and ensuring the correct region-specific URLs were used.
Manual Approval and Production Stage Configuration

Faced challenges in correctly setting up manual approval and production stages in CodePipeline.
Resolved by carefully following AWS documentation and ensuring all stages were correctly configured.
Conclusion
Despite facing several challenges, including YAML configuration issues and IAM role misconfigurations, the project was successfully completed. The deployment pipeline is now fully automated, with added stages for manual approval and production deployment, ensuring a robust and reliable CI/CD process for the Nginx application.

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Project Files
index.html

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DevOps/Cloud Engineer Resume Profile</title>
    <h1>GREAT SUCCESS: Deployed to production env CD</h1>
    <h2>Added 2 more stages to code Pipeline</h2>
    <h3>Manual approval and Prod env</h3>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
            color: #333;
        }
        .container {
            width: 80%;
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        h1 {
            text-align: center;
            color: #333;
        }
        .contact-info {
            margin-top: 20px;
        }
        .contact-info p {
            margin: 5px 0;
        }
        .contact-info a {
            color: #0073e6;
            text-decoration: none;
        }
        .contact-info a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>DevOps/Cloud Engineer</h1>
        <div class="contact-info">
            <p><strong>Name:</strong> Vivek Saskar</p>
            <p><strong>Email:</strong> <a href="mailto:viveksaskar@gmail.com.com">viveksaskar@gmail.com</a></p>
            <p><strong>Phone:</strong> +91 8888345895</p>
            <p><strong>LinkedIn:</strong> <a href="www.linkedin.com/in/vivek-saskar" target="#">linkedin.com/in/viveksaskar</a></p>
            <p><strong>GitHub:</strong> <a href="https://github.com/" target="#">github.com/</a></p>
        </div>
    </div>
</body>
</html>
buildspec.yml

----------------------------------------------------------------------------------------------------

version: 0.2

phases:
  install:
    commands:
      - echo Installing NGINX
      - sudo apt-get update
      - sudo apt-get install nginx -y
  build:
    commands:
      - echo Build started on $(date)
      - cp index.html /usr/share/nginx/html
  post_build:
    commands:
      - echo Configuring NGINX

artifacts:
  files:
    - '**/*'
appspec.yml

----------------------------------------------------------------------------------------------------

version: 0.0
os: linux
files:
  - source: /
    destination: /usr/share/nginx/html
hooks:
  AfterInstall:
    - location: scripts/install_nginx.sh
      timeout: 300
      runas: root
  ApplicationStart:
    - location: scripts/start_nginx.sh
      timeout: 300
      runas: root

----------------------------------------------------------------------------------------------------

install_nginx.sh

#!/bin/bash
sudo dnf

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
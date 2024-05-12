# Terraforming Jenkins Server on Azure VM

This project centers on deploying a Jenkins server on an Azure virtual machine using Terraform, an infrastructure as code tool. By leveraging Terraform's capabilities, users can automate the setup process, ensuring consistency and reliability across deployments. Azure VMs provide a flexible and scalable environment for hosting Jenkins, allowing for seamless integration with CI/CD pipelines and other DevOps workflows.

Before you start<br>
make sure to install terraform on your machine, and clone this repository.

<br>i will test it to create 3 jenkins jobs :
- jobs 1 : watch github repository master branch, fetch from master branch and deploy on a Docker Container
- jobs 2 : watch github repository dev branch, fetch from the dev, and deploy docker container
- jobs 3 : if the QA team approves of dev branch deployment on Docker Container, merge the dev and master branch and run newly merged content

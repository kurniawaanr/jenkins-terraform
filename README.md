# Automate Jenkins Server on Azure VM with Terraform

the ideas is to create Jenkins Master on Azure VM with Terraform.
<br>
this will make Jenkins Deployment easy to do, just do a command with terraform apply and a VM will launched and bootsraping jenkins installation. i'm using separated resource file to make it easy to manage and maintain resource.

<br>i will test it to create 3 jenkins jobs :
- jobs 1 : watch github repository master branch, fetch from master branch and deploy on a Docker Container
- jobs 2 : watch github repository dev branch, fetch from the dev, and deploy docker container
- jobs 3 : if the QA team approves of dev branch deployment on Docker Container, merge the dev and master branch and run newly merged content

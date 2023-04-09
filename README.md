<br/>
<p align="center">
  <a href="https://github.com/rrddevops/bootcamp2">
    <img src="https://amlanscloud.com/static/9def0d99a7abafd287ee1546d83c3fd4/d6be1/ekspipeline.png" alt="Logo">
  </a>

  <h3 align="center">Terraform EKS Jenkins pipeline app</h3>

  <p align="center">
    Projeto completo para criação de ambiente AWS com Jenkins e cluster EKS.
    <br/>
    <a href="https://github.com/rrddevops/bootcamp2"><strong>Explore the docs »</strong></a>
    <br/>
</p>

## Table Of Contents

* [About the Project](#about-the-project)
* [Built With](#built-with)
* [Getting Started](#getting-started)
  * [Prerequisites](#prerequisites)
  * [Installation](#installation)
* [Authors](#authors)
* [Acknowledgements](#acknowledgements)

## About The Project

![Screen Shot](https://i.ytimg.com/vi/Hz_zWe64uyY/hqdefault.jpg)

### Prerequisites

Ter uma conta na AWS<br/>
Ter uma conta no Dockerhub<br/>
Install terraform<br/>
Install aws CLI<br/>
Criar credencial AWS para executar o terraform<br/>

Clone repo to github: <br/>
git add .<br/>
git commit -m 'first commit'<br/>
git push origin main<br/>

Criar developer token no github;<br/>
Adicionar no jenkins credentials para push do repositório;<br/>

Como executar<br/>

## Built With

Terraform create:<br/>
Deploy EKS <br/>
Deploy Jenkins

Conect your jenkins IP output ec2: <br/>
ssh -i "tf-key-pair.pem" ec2-user@ip<br/>
sudo cat /var/lib/jenkins/secrets/initialAdminPassword<br/>


### Installation

terraform init<br/>
terraform plan<br/>
terraform plan<br/>

Adicionar plugins no Jenkins:<br/>
Add Plugins<br/>
	Git<br/>
	Docker<br/>
  CloudBees AWS Credentials Plugin<br/>
	Pipeline: AWS StepsVersion<br/>

Jenkins credentials:<br/>
github<br/>
aws
dockerhub<br/>

## Getting Started

Conf github webhook:<br/>
Enable jenkins pipeline - build triggers enable github hook trigger
Enable webhook github -> http://ip:8080/github-webhook/


### Creating A Pull Request

## Authors

* **Rodrigo Davila** - *devops engineer* - [Rodrigo Davila](https://github.com/rrddevops) - **

## Acknowledgements

* [Linkedin](https://www.linkedin.com/in/rodrigordavila/)

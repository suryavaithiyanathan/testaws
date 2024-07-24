# 2i10-suse
Repo for SUSE based SAP deployments

# README
This repository contains infrastructure as code for the SAP ABAP Central Systems (Prod and Non-prod), SAP SWD+Router (non-prod) running on AWS.
## Getting Started
  You can easily create your own configuration for an SAP application in `terraform/configuration/applications` folder by creating a new application and adding the required modules into your config
  Use `ARP-GEH` as a reference for ABAP distributed system build in MCK account. (Non-Prod system)
  
  Use `sap-router-jea` as a reference for standalone SAP Router system build in MCK account. (Non-prod system).
  
## Contribution guidelines
* Always make changes on a short lived branch - relating to a SNOW ticket/JIRA User Story when possible
* Always create pull request and seek approval before merge via a peer review
* When provisioning new infrastructure please include tests to confirm provisioning has worked as expected
* Always leave code in a better state than you found it if possible
* Use a clean code approach (descriptive naming for readability and reduce need for unnecessary comments)
* Unnecessary comments increase maintenance
* run the following command on the module root before pushing to the short lived branch:
  ```
  terraform fmt --recursive
  ```
## Organising the code
* The following file structure should be followed as closely as possible
* The structure selected is optimal for short live feature branching in git
* The structure contains multiple terraform configurations for different applications and modules inside them
* Create and Update README.MD files for the modules inside the configuration
  * terraform
    * configurations
      * applications
        * sap _- configurations for SAP application deployment_
          * arp-geh
            * inputs _- contains all the tfvars files_
            * backend.tf _- contains the backend configuration for the tfstate_
            * central_sap_management_state.tf _- contains the logic that allows terraform to read the resources created in other pipelines and centralized in the Central SAP 2I10 PRD Account (e.g. Binaries Bucket, Certificates Management, KMS Keys for the binaries, ...)_
            * Jenkinsfile _- Jenkins Pipeline Definition_
            * main.tf _- main module that centralizes the calls to generic modules that will deploy the EWM application_
            * outputs.tf _- contains all the resources that you want to expose outside of this module (It's empty for now and is a good practice to limit as much as possible exposing resource visibility to the outside)_
            * providers.tf _- contains the terraform AWS provider configuration_
            * variables.tf _- contains the declaration of the variables that are being used in the ERP IaC_
            * datasync_efs _- contains the efs provision for datasync. Also contains security group rules and Ingress/Egress rules for thoses SG
## Implemented applications
Currently the following applications were implemented: 
  * SAP ERP _- GEA/NEA in the MCK Account and FEA in the PRD Account have been deployed.
### Improvements
* Infrastructure
  * Network Resources _-Currently existing Network configuration rely on the PCP Provided Resources infrastructure (Hosted DNS Zone, VPCs, Subnets, ...) which was provisioned through terraform by Airbus Network Teams. Ideally, Airbus Network Teams should share their state with us and allow us read their data sources to refer to the network infrastructure (rather than hardcoding it through variables)_ 
  * AMI IDs _-Currently AMI IDs are hardcoded instead of reading the last available AMI ID shared by the PCP Central Account into our AWS Account. We need to implement paragraph "In terraform with a data source" from https://confluence.airbus.corp/pages/viewpage.action?pageId=70851355_ 
  * AMI Lifecycle _-Currently there's no mechanism as part of the run to manage automatic AMI upgrade. As per platform security teams, AMI upgrade should be planned at least twice a year._
  * OS Patch Management _-Currently there's no inhouse Patch Management mechanism. The same mechanism that was applied lately on Celonis should be applied in here where an ssm document for automatic patching runs (each saturday) and reboots the OS in sequence before gracefully shutting down. Note that PCP has implemented an automatic patching mechanism which I don't recommend relying on as their choose the patching scheduling on your behalf and do not necessarily have knowledge of the application to do proper reboots with the sequence (e.g. DB then ASCS and PAS then AAS for the start sequence)_
* Application
  * Security Groups _-SGs need to be reviewed_
  * Backup _-Make use of the AWS S3 Backint Agent and schedule in HANA Studio the Backup jobs (refer to the operating mode that was shared with AWS SAP Product Management)_
  * Applicative Monitoring _-Interconnect the application with PSM and Focused Run_
  * DBA Tooling _-Allow connectivity to the application through HANA Studio and a cloud based HANA Cockpit Infrastructure. These tools can also be good use cases for VDI._
  * Batch Jobs Scheduling and Execution _-The Batch Job Scheduling and Execution needs to be addressed for SAP Jobs through Redwood or Control-M or investigate an AWS based solution (without license costs or infra to manage)_
  * Emails _-Interconnect the SAP Application with Airbus SMTP Relays to allow the SAP Application send and receive Emails (refer to https://confluence.airbus.corp/pages/viewpage.action?pageId=81564600)_
  * SAP Application Resilience _-Implement HA & DR (at infrastructure and application levels (SUSE Pacemaker + Overlay IP))_
# 2i10-suse
Repository for distributed system installation (ASCS and PAS) on separate hosts.

Standlaone SAP Router installation.
=======
This repo contains :

SAP infrastructure for GEH (in non-prod environment - SAP and HANA both in private subnet)
SAP infrastructure for GEA (in non-prod environment - SAP in private subnet and HANA in local subnet)

* ASCS + Hana DB + PAS

Performs also the automated installation of 
* ECC 6.0 EHP 8
* Hana DB 2.0

SAP Router infra - JEA standalone router
* build
* configuration




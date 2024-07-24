# README
This repository contains infrastructure as code for the generic module for creating a DNS Record in Route 53.
## Getting Started
  You can easily create your own configuration for an SAP application in `terraform/configuration/applications` folder by creating a new application and adding the required modules into your config
  Please use `extended-warehouse-management` as a reference
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
### Usage:

 - Add this module to your terraform configuration and provide the variables:

 ```json
module a_records {
  source = "../../../../../../modules/aws/compute/dns-records"

  enabled = var.enabled

  zone_id      = data.aws_route53_zone.dns_zone.zone_id
  zone_name    = var.private_zone_name
  record_type  = "A"
  record_ttl   = "300"
  record_names = local.hostnames
  records      = module.instance.private_ip
}
```

## Organising the code
* The following file structure should be followed as closely as possible
* The structure selected is optimal for short live feature branching in git
* The structure contains multiple terraform configurations for different applications and modules inside them
* Create and Update README.MD files for the modules inside the configuration
  * terraform
    * modules _- contains the generic modules that can be reused anywhere in the modules that are in the configuration folder_
      * aws _- contains the generic modules that are specific for AWS, in case another CSP is retained a different folder needs to be created in the arborescence and same logic should be applied_
        * compute _- contains the generic modules that are specialized in the compute_
            * dns-records _- contains the module that will handle the deployment of a DNS record in AWS Route 53 independently from its configuration_
                * route53.tf _- contains the provisioning of the DNS Record_
                * outputs.tf _- outputs the FQDN associated to the DNS Record._
                * variables.tf _- contains the declaration of the variables that are being used in this module_
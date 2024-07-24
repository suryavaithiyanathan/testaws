# README
This repository contains infrastructure as code for the generic module for deploying a Network Load Balancer on AWS.
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
module nlb {
  source  = "../../../../../../modules/aws/compute/nlb"
  enabled = true

  internal                         = true
  enable_cross_zone_load_balancing = true

  lb_configuration = [{
    listener_protocol   = "TCP"
    listener_port       = "3299"
    inbound_subnets     = var.private_subnet_ids
    target_protocol     = "TCP",
    target_port         = "3299",
    target_vpc_id       = var.vpc_id
    target_instance_ids = module.instance.instance_id
    target_subnets      = var.private_subnet_ids
    }
  ]
  enable_deletion_protection = var.enable_nlb_deletion_protection[var.environment]
  tags = merge(
    module.tags.values,
  map("Name", "${module.tags.values["ApplicationName"]}-nlb"))
}
```
- Make sure you populate the enable_alb_deletion_protection variable in module's `variables.tf`
 ```json
variable enable_nlb_deletion_protection {
  default = {
    mck = false,
    val = false,
    prd = true
  }
}
```
  * This will allow you to drive via the map, on which environment you want to enable the deletion protection.

## Organising the code
* The following file structure should be followed as closely as possible
* The structure selected is optimal for short live feature branching in git
* The structure contains multiple terraform configurations for different applications and modules inside them
* Create and Update README.MD files for the modules inside the configuration
  * terraform
    * modules _- contains the generic modules that can be reused anywhere in the modules that are in the configuration folder_
      * aws _- contains the generic modules that are specific for AWS, in case another CSP is retained a different folder needs to be created in the arborescence and same logic should be applied_
        * compute _- contains the generic modules that are specialized in the compute_
            * alb _- contains the module that will handle the deployment of a NLB on AWS independently from its configuration_
                * nlb-attachments.tf _- contains the NLB attachment logic_
                * nlb-listeners.tf _- contains the NLB Listeners logic_
                * nlb-target-groups.tf _- contains the NLB Target Group configuration_
                * nlb.tf _- contains the provisioning of the NLB itself_
                * outputs.tf _- outputs the nlb_target_group_arn, nlb_name and the nlb_dns_name._
                * variables.tf _- contains the declaration of the variables that are being used in this module_
### Improvements
* Inject the NLB Logs into the Elasticsearch domain for log analysis together with the VPC Flow Logs.
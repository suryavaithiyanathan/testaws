# README
This repository contains infrastructure as code for the generic module for generating CSRs and their related private keys programatically directly on Terraform using the TLS Provider. This module also automatically uploads the generated CSR in a given S3 Bucket for centralization purposes.
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
module certificate_management {
  source = "../../../../../modules/aws/security/certificates-management"

  algorithm                           = var.algorithm
  rsa_bits                            = var.rsa_bits
  organization                        = var.organization
  organizational_unit                 = var.organizational_unit
  locality                            = var.locality
  province                            = var.province
  country                             = var.country
  dns_names                           = module.rhel_sr_host.nlb_dns_name
  certificates_management_bucket_name = local.certificate_management_bucket_name
  kms_key_id                          = local.central_sap_management_key_arn

  aspire_code      = lower(local.aspire_code)
  environment      = lower(var.environment_type)
  application_name = format("%s%s", lower(local.application_name), lower(local.suffix))
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
        * security _- contains the generic modules that are specialized in the Security field_
            * certificates-management _- contains the module that will handle the generation of the CSRs and associated private keys through the use of the terraform TLS Provider_
                * certificate_request.tf _- generates a CSR cyphered with the generated private key. The CSR is also uploaded on a given AWS S3 Bucket_
                * private_key.tf _- generates a private key that will be associated to the CSR_
                * outputs.tf _- outputs the Cloudwatch Log Group Name_
                * variables.tf _- contains the declaration of the variables that are being used in this module_
### Improvements
* Integration with Nexus Certificates Authority to request for Signed Certificates Programatically
* Update of the SAP Provisioning Module to automate the import of the signed certificates when received from the Nexus CA API (S3 Bucket Event ?)
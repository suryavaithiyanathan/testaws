# README
This repository contains infrastructure as code for the generic module for Tagging the Resources deployed in AWS.
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
 module tags {
  source                = "../../../../../../modules/aws/common/tagging"
  environment           = var.environment
  aspire_code           = var.aspire_code
  application_name      = var.application_name
  sid                   = var.sid
  application_component = "hana"
}
```

- And update the file `tag-mapping.tf` by adding the entries corresponding to your application.
  * As a reminder this file which is a centralized tag map for all the resources deployed in AWS :

```json
variable application_owner {
  default = {
    ewm                       = "Laurent Triboulet",
    focused-run               = "Frédéric Fedou",
    sap-router        = "David Macvicar",
    central-sap-webdispatcher = "David Macvicar",
    elasticsearch = "David Macvicar"
  }
}
variable sdl {
  default = {
    ewm                       = "Xavier Couloumies",
    focused-run               = "Xavier Couloumies",
    sap-router        = "Xavier Couloumies",
    central-sap-webdispatcher = "Xavier Couloumies",
    elasticsearch = "David Macvicar"
  }
}
variable landscape {
  default = {
    ewm                       = "XWE",
    focused-run               = "XFO",
     sap-router        = "CSR",
    central-sap-webdispatcher = "CSW",
    elasticsearch = "ELK"
  }
}
...
```

## Organising the code
* The following file structure should be followed as closely as possible
* The structure selected is optimal for short live feature branching in git
* The structure contains multiple terraform configurations for different applications and modules inside them
* Create and Update README.MD files for the modules inside the configuration
  * terraform
    * modules _- contains the generic modules that can be reused anywhere in the modules that are in the configuration folder_
      * aws _- contains the generic modules that are specific for AWS, in case another CSP is retained a different folder needs to be created in the arborescence and same logic should be applied_
        * common _- contains the generic modules that are not specialized in a specific field (compute, storage, db, ...)_
            * tagging _- contains the module that will handle the tagging strategy for all the resources created through terraform in a normalize unified and codified manner_
                * main.tf _- contains the tag map that was agreed during the design phase of the SAP M2C_
                * output.tf _- outputs the normalized tag map_
                * tag-mapping.tf _- contains the mapping table that needs to be maintained one for all the applications deployed into AWS (Aspire Codes, SLAs, SDLs, ...)_
                * variables.tf _- contains the declaration of the variables that are being used in this module_
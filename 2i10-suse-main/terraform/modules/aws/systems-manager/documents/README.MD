# README
This repository contains infrastructure as code for the generic module for deploying an SSM Document (Command or Automation) on AWS.
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
module execute_pas_installation {
  source = "../../../../../../modules/aws/systems-manager/documents"

  command_name    = "${var.aspire_code}-${var.application_name}-execute-pas-installation"
  automation_type = "Command"
  path_to_yaml    = file("${path.module}/scripts/module-automations/pas/commands/sap-pas-execute-installation.yaml")

  tags = module.tags.values
}
```
* or:
```json
module install_pas {
  source = "../../../../../../modules/aws/systems-manager/documents"

  command_name    = "${var.aspire_code}-${var.application_name}-install-pas-master-document"
  automation_type = "Automation"
  path_to_yaml = templatefile("${path.module}/scripts/module-automations/pas/sap-pas-installation.yaml", {
    MasterPasswordParameterName        = module.system_user_password.parameter.name,
    DNSPrivateZoneName                 = var.private_zone_name,
    InstallationMediaBucket            = var.binaries_folder == "" ? var.binaries_bucket_name : "${var.binaries_bucket_name}/${var.binaries_folder}",
    CloudWatchLogGroupName             = module.sap_setup_logs_group.name,
    EfsFileSystemId                    = var.efs_sapmnt,
    DbInstanceId                       = length(var.hana_instance_ids) > 0 ? tostring(var.hana_instance_ids[0]) : "",
    AscsInstanceId                     = tostring(var.ascs_instance_id),
    PrepareLogsDocumentName            = module.prepare_logs.document.name,
    SetHostnameDocumentName            = module.set_hostname.document.name,
    InstallPackagesDocumentName        = module.install_packages.document.name,
    SetParametersDocumentName          = module.set_pas_parameters.document.name,
    AddDbToHostDocumentName            = module.add_to_hosts.document.name,
    MountDisksDocumentName             = module.mount_disks.document.name,
    InstallAwsDataProviderDocumentName = module.install_aws_data_provider.document.name,
    DownloadSoftwareDocumentName       = module.download_pas_software.document.name,
    ExecuteInstallationDocumentName    = module.execute_pas_installation.document.name,
    PasProductId                       = var.pas_product,
    DbProductId                        = var.db_product
  })

  tags = module.tags.values
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
        * systems-manager _- contains the generic modules that are specialized for AWS SSM_
            * documents _- contains the module that will handle the deployment of an AWS SSM Document (Command or Automation) on AWS_
                * document.tf _- deploys the SSM Command or Automation on AWS_
                * outputs.tf _- outputs the SSM Document Object_
                * variables.tf _- contains the declaration of the variables that are being used in this module_
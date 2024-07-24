locals {
  inputs = {
    #environment           = lower(var.environment)
    env_stage             = lower(var.env_stage)
    aws_region_code       = lower(var.aws_region_code)
    service_level          = lower(var.service_level)
    aspire_code           = lower(var.aspire_code)
    application_name      = lower(var.application_name)
    application_component = lower(var.application_component)
    sid                   = lower(var.sid)
    #finopsPolicy           = lower(var.finopsPolicy[var.application_name])    
    #instance_no           = lower(var.instance_no)
    #landscape             = lower(var.landscape[var.application_name])
    delimiter             = var.delimiter
  }

  outputs = {
    #Name                 = local.inputs["application_component"] == "sap-router" || local.inputs["application_component"] == "web-dispatcher" || length(local.inputs["application_component"]) == 0 ? "${local.inputs["application_name"]}${local.inputs["delimiter"]}${local.inputs["sid"]}${local.inputs["delimiter"]}${local.inputs["environment"]}" : "${local.inputs["application_name"]}${local.inputs["delimiter"]}${local.inputs["sid"]}${local.inputs["delimiter"]}${local.inputs["application_component"]}${local.inputs["delimiter"]}${local.inputs["environment"]}"
    Name                 = local.inputs["application_component"] == "sap-router" || local.inputs["application_component"] == "rwd" || local.inputs["application_component"] == "web-dispatcher" || length(local.inputs["application_component"]) == 0 ? "${local.inputs["aws_region_code"]}${local.inputs["delimiter"]}${local.inputs["application_name"]}${local.inputs["delimiter"]}${local.inputs["sid"]}${local.inputs["delimiter"]}${local.inputs["env_stage"]}" : "${local.inputs["aws_region_code"]}${local.inputs["delimiter"]}${local.inputs["application_name"]}${local.inputs["delimiter"]}${local.inputs["sid"]}${local.inputs["delimiter"]}${local.inputs["application_component"]}${local.inputs["delimiter"]}${local.inputs["env_stage"]}"
    AspireCode           = local.inputs["aspire_code"]
    Sid                  = local.inputs["sid"]
    ComponentFunction = local.inputs["application_component"]
    ServiceLevel         = local.inputs["service_level"]
    #SapEnvironment          = local.inputs["environment"]
    #FinopsPolicy          = local.inputs["finopsPolicy"]
    #ApplicationName      = local.inputs["application_name"]
    #InstanceNumber          = local.inputs["instance_no"]
    #Landscape            = local.inputs["landscape"]
    
  }
}
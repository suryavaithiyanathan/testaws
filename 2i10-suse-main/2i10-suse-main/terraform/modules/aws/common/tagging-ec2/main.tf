locals {
  inputs = {
    environment           = lower(var.environment)
    env_stage             = lower(var.env_stage)
    aws_region_code       = lower(var.aws_region_code)
    aspire_code           = lower(var.aspire_code)
    application_name      = lower(var.application_name)
    application_component = lower(var.application_component)
    finopsPolicy           = lower(var.finopsPolicy[var.application_name])
    sid                   = lower(var.sid)
    instance_no           = lower(var.instance_no)
    landscape             = lower(var.landscape[var.application_name])
    delimiter             = var.delimiter
  }

  outputs = {
    #Name                 = local.inputs["application_component"] == "sap-router" || local.inputs["application_component"] == "web-dispatcher" || length(local.inputs["application_component"]) == 0 ? "${local.inputs["application_name"]}${local.inputs["delimiter"]}${local.inputs["sid"]}${local.inputs["delimiter"]}${local.inputs["environment"]}" : "${local.inputs["application_name"]}${local.inputs["delimiter"]}${local.inputs["sid"]}${local.inputs["delimiter"]}${local.inputs["application_component"]}${local.inputs["delimiter"]}${local.inputs["environment"]}"
    Name                 = "ec2${local.inputs["delimiter"]}${local.inputs["aws_region_code"]}${local.inputs["delimiter"]}${local.inputs["aspire_code"]}${local.inputs["delimiter"]}${local.inputs["sid"]}${local.inputs["delimiter"]}${local.inputs["env_stage"]}${local.inputs["delimiter"]}${local.inputs["application_component"]}"
    SapEnvironment          = local.inputs["environment"]
    AspireCode           = local.inputs["aspire_code"]
    ApplicationName      = local.inputs["application_name"]
    ComponentFunction = local.inputs["application_component"]
    FinopsPolicy          = local.inputs["finopsPolicy"]
    Sid                  = local.inputs["sid"]
    InstanceNumber          = local.inputs["instance_no"]
    Landscape            = local.inputs["landscape"]
    
  }
}
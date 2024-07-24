locals {
  inputs = {
    environment           = lower(var.environment)
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
    Name                 = local.inputs["application_component"] == "sap-router" || local.inputs["application_component"] == "web-dispatcher" || length(local.inputs["application_component"]) == 0 ? "${local.inputs["application_name"]}${local.inputs["delimiter"]}${local.inputs["sid"]}${local.inputs["delimiter"]}${local.inputs["environment"]}" : "${local.inputs["application_name"]}${local.inputs["delimiter"]}${local.inputs["sid"]}${local.inputs["delimiter"]}${local.inputs["application_component"]}${local.inputs["delimiter"]}${local.inputs["environment"]}"
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
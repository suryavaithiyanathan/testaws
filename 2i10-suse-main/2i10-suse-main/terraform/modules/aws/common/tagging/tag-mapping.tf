
variable landscape {
  default = {
    ewm                       = "XWE",
    focused-run               = "XFO",
    central-sap-router        = "CSR",
    central-sap-webdispatcher = "CSW",
    elasticsearch             = "ELK",
    erp                       = "xEA",
    bw                        = "xBA",
    s4h                       = "x11",
    crm                       = "N/A",
    rwd                       = "rwd",
    flp                       = "N/A"
  }
}


variable finopsPolicy{
  default = {
    ewm                       = "N/A",
    focused-run               = "N/A",
    central-sap-router        = "N/A",
    central-sap-webdispatcher = "N/A",
    elasticsearch             = "N/A",
    erp                       = "N/A",
    bw                        = "xBA",
    s4h                       = "x11",
    crm                       = "N/A",
    rwd                       = "rwd",
    flp                       = "N/A"
  }
}


variable delimiter {
  default     = "-"
  description = "Delimiter to be used"
}
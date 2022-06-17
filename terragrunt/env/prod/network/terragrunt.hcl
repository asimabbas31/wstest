include {
  path = find_in_parent_folders()
}



terraform {
    source = "git::git@github.com:modules-terragrun/deployment-api//terragrunt/modules/network"
  
    extra_arguments "common_vars" {
    commands = get_terraform_commands_that_need_vars()

    arguments = [
      "-var-file=../../common.tfvars"
    ]
  }

}

dependency "vpc" {
  config_path = "../vpc"
}
inputs = {
  vpcid = dependency.vpc.outputs.vpcid
  cidr_block = "10.9.0.0/16" 
}

dependencies {
  paths = [
    "../vpc",
    ]
}

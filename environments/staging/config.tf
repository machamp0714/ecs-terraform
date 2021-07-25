terraform {
  backend "remote" {
    organization = "machamp"

    workspaces {
      name = "sample-workspace"
    }
  }
}

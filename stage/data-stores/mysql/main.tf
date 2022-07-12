provider "aws" {
    profile = "prod"
}

module "database" {
    source = "../../../modules/data-store/mysql/"

    database-name = "stage-db"
    env = "stage"
  
}
provider "aws" {
    profile = "prod"
}

module "webserver_cluster" {
    source = "../../../modules/services/webserver-cluster"
    
    cluster_name = "webservers-stage"
    db_remote_state_bucket = var.bucket#"terraform-hive-mind"
    db_remote_state_key = "stage/data-store/mysql/terraform.tfstate"
    instance_type = "t2.micro"
    min_size = 2
    max_size = 4
    env = "stage"
}

resource "aws_security_group_rule" "allow_testing_inbound" {
    type = "ingress"
    security_group_id = module.webserver_cluster.alb_security_group_id

    from_port = 12345
    to_port = 12345
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  
}
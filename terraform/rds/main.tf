provider "aws" {
  region = var.region
}

data "aws_vpc" "my-vpc" {
  id = var.vpc_id
}

resource "aws_db_parameter_group" "param_group" {
  name   = "rds-param-group"
  family = "postgres15"

  parameter {
    name  = "log_connections"
    value = "1"
  }
}

resource "aws_db_instance" "postgres" {
  identifier             = "rds"
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  engine                 = "postgres"
  engine_version         = "15.4"
  username               = "edu"
  password               = var.db_password
  db_name                = "metabase"
  db_subnet_group_name   = "rds-subnet-group"
  vpc_security_group_ids = var.sg_id
  parameter_group_name   = "rds-param-group"
  publicly_accessible    = true
  skip_final_snapshot    = true
}

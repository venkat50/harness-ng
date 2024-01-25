provider "aws" {
  region = var.region
}

data "aws_vpc" "my-vpc" {
  id = var.vpc_id
}

resource "aws_subnet" "one-a" {
  vpc_id = data.aws_vpc.my-vpc.id
  availability_zone = "us-east-1a"
  cidr_block = "192.168.129.0/24"
  tags = {
    Name = "Demo"
  }

}

resource "aws_subnet" "one-b" {
  vpc_id = data.aws_vpc.my-vpc.id
  availability_zone = "us-east-1b"
  cidr_block = "192.168.130.0/24"
  tags = {
    Name = "Demo"
  }

}

resource "aws_db_subnet_group" "subnet_group" {
  name       = "rds"
  subnet_ids = [aws_subnet.one-a.id, aws_subnet.one-b.id]

  tags = {
    Name = "Demo"
  }
}
resource "aws_security_group" "sg" {
  name   = "rds"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Demo"
  }
}

resource "aws_db_parameter_group" "param_group" {
  name   = "rds"
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
  db_subnet_group_name   = aws_db_subnet_group.subnet_group.name
  vpc_security_group_ids = [aws_security_group.sg.id]
  parameter_group_name   = aws_db_parameter_group.param_group.name
  publicly_accessible    = true
  skip_final_snapshot    = true
}

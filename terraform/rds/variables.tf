variable "region" {
  default     = "us-east-1"
  description = "AWS region"
}

variable "db_password" {
  description = "RDS root user password"
  sensitive = true

}

variable "vpc_id" {
 sensitive = true

}

variable "sg_id" {

sensitive = true

}

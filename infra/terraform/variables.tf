variable "region" {
  description = "Région AWS"
  type        = string
  default     = "eu-west-3"
}

variable "vpc_id" {
  description = "ID du VPC dans lequel créer le security group"
  type        = string
  default     = "vpc-0ebcdb39f7a526ef9"
}

variable "subnet_cidr" {
  description = "Bloc CIDR du subnet (libre dans le VPC 172.31.0.0/16)"
  type        = string
  default     = "172.31.100.0/24"
}

variable "subnet_name" {
  description = "Nom (tag Name) du subnet"
  type        = string
  default     = "claire-davs-subnet"
}

variable "sg_name" {
  description = "Nom du security group"
  type        = string
  default     = "davs-sg"
}

variable "key_name" {
  description = "Nom de la key pair AWS à créer"
  type        = string
  default     = "claire-davs-key"
}

variable "port" {
  description = "Port autorisé en entrée"
  type        = number
  default     = 443
}

variable "ami" {
  description = "ID de l'AMI de l'instance"
  type        = string
}

variable "instance_type" {
  description = "Type de l'instance EC2"
  type        = string
  default     = "t2.micro"
}

variable "instance_name" {
  description = "Nom (tag Name) de l'instance"
  type        = string
  default     = "claire-davs-instance"
}

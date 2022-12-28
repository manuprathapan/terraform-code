variable "resourceprefix" {
  type        = string
  description = "enter a value that will be prefixed with resource names."
  default     = "dev"
}

variable "vpccidrrange" {
  type        = string
  description = "enter the vpc cidr range"
  default     = "10.0.0.0/16"
}

variable "privatesubnetonerange" {
  type        = string
  description = "enter the cidr range for private subnet one"
  default     = "10.0.1.0/24"
}

variable "privatesubnettworange" {
  type        = string
  description = "enter the cidr range for private subnet two"
  default     = "10.0.2.0/24"
}

variable "publicsubnetonerange" {
  type        = string
  description = "enter the cidr range for public subnet one"
  default     = "10.0.3.0/24"
}

variable "publicsubnettworange" {
  type        = string
  description = "enter the cidr range for public subnet two"
  default     = "10.0.4.0/24"
}
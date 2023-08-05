# Define a Terraform variable to store the host IP address or CIDR block
variable "host_ip" {
  type    = string
  default = "0.0.0.0/0"  # Set the default value to "0.0.0.0/0" if no value is provided
}

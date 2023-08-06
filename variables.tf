# Define a Terraform variable to store the host IP address or CIDR block
variable "host_ip" {
  type    = string
  default = "34.239.187.126/32" # Set the default value to "54.226.218.101/32" if no value is provided
}

# Define a Terraform variable to store the user data for cloud-init script
variable "user_data" {
  type    = string
  default = "IyEvYmluL2Jhc2gKCnN1ZG8geXVtIHVwZGF0ZSAteQpzdWRvIHl1bSB1cGdyYWRlIC15CnN1ZG8geXVtIGluc3RhbGwgaHR0cGQgLXkKc3VkbyBzeXN0ZW1jdGwgZW5hYmxlIGh0dHBkCnN1ZG8gc3lzdGVtY3RsIHN0YXJ0IGh0dHBkCg=="
}

# Define a Terraform variable to store the availability zones as a list of strings
variable "azs" {
  type    = list(any)
  default = ["us-east-1a", "us-east-1b"]
}
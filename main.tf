# Create an AWS security group for the Auto Scaling Group instances
resource "aws_security_group" "asg-sg" {
  name = "week-21-asg-sg"

  # Ingress rule to allow SSH access from the specified host IP
  ingress {
    cidr_blocks = [
      var.host_ip
    ]
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
  }

  # Ingress rule to allow HTTP access from anywhere
  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
  }

  # Egress rule to allow all traffic from instances to the Internet
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an AWS key pair for SSH access to instances
resource "aws_key_pair" "key_pair" {
  key_name   = "week-21-kp"
  public_key = file("~/.ssh/id_rsa.pub")
}

# Create an AWS launch template for the Auto Scaling Group instances
resource "aws_launch_template" "my-lt" {
  name = "week-21-lt"

  image_id = "ami-09538990a0c4fe9be"

  instance_initiated_shutdown_behavior = "terminate"

  instance_type = "t2.micro"

  # Use the previously created AWS key pair for SSH access
  key_name = aws_key_pair.key_pair.key_name

  # Attach the previously created security group to the instances
  security_group_names = [aws_security_group.asg-sg.name]

  # Provide user data from a base64-encoded file for instance customization
  user_data = var.user_data
}

# Create an AWS Auto Scaling Group with instances using the launch template
resource "aws_autoscaling_group" "week-21-asg" {
  name               = "week-21-asg"
  availability_zones = var.azs
  desired_capacity   = 3
  max_size           = 5
  min_size           = 2

  # Use the previously created launch template for instance configuration
  launch_template {
    id      = aws_launch_template.my-lt.id
    version = "$Latest" # Use the latest version of the launch template
  }
}
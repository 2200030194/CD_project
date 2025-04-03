provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_instance" "node_app" {
  ami           = "ami-034488765f896f58f" # Use latest Amazon Linux 2 AMI
  instance_type = "t2.micro"
  key_name      = "CD Skill1" # Replace with your AWS key name

  tags = {
    Name = "NodeAppServer"
  }

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y docker
              service docker start
              docker pull 2200030194/my-node-app:latest
              docker run -d -p 3000:3000 2200030194/my-node-app:latest
              EOF
}
resource "aws_security_group" "node_sg" {
  name        = "node_app_sg"
  description = "Allow Node.js app access"

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Open port 3000 to the internet
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


output "server_ip" {
  value = aws_instance.node_app.public_ip
}

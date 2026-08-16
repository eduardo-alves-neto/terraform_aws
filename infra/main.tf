provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "sg" {
  name        = "sg"
  description = "Security group for my instance"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}


resource "aws_key_pair" "my_key" {
  key_name   = "my_key"
  public_key = file("/home/eduardo/.ssh/id_ed25519.pub")
}


resource "aws_instance" "servidor" {
  ami                    = "ami-0bdc7d025135d7b49"
  instance_type          = "t3.micro"
  user_data              = file("user_data.sh")
  vpc_security_group_ids = [aws_security_group.sg.id]
  key_name               = aws_key_pair.my_key.key_name
}


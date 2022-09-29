provider "aws" {
region = "us-east-2"  
}

resource "aws_eip" "lb" {
  instance = aws_instance.web.id
 tags = {
    Name = "EIP for Websever Built by Terraform"
    Owner = "Saidi Abdulramoni"
}
}

resource "aws_instance" "websever" {
ami = "ami-0f924dc71d44d23e2" 
instance_type = "t2.micro"
vpc_security_group_ids = [ aws_security_group.web.id]
user_data = file("user_data.sh")

tags = {
    Name = "Websever Built by Terraform"
    Owner = "Saidi Abdulramoni"
}
}

resource "aws_security_group" "web" {
    name = "Webserver-SG-Terraform"
    description = "SG for my webserver"

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

     egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
  



tags = {
    Name = "Websever SG by Terraform"
    Owner = "Saidi Abdulramoni"
}
}
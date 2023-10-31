resource "aws_security_group" "soat-http-sg" {
  name        = "web-security-group"
  description = "Permite acesso a porta 8080"
  vpc_id      = aws_vpc.soat-vpc.id

  ingress {
    description      = "http"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

}
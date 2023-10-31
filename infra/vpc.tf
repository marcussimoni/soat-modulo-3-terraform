resource "aws_vpc" "soat-vpc" {

 cidr_block = "10.0.0.0/16"

 tags = {
   Name = "soat-vpc"
 }
}

resource "aws_subnet" "soat-public-subnet-1" {
  vpc_id = aws_vpc.soat-vpc.id
  cidr_block = "10.0.0.0/20"
  tags = {
    Name = "soat-public-subnet-1"
  }
}

resource "aws_subnet" "soat-public-subnet-2" {
  vpc_id = aws_vpc.soat-vpc.id
  cidr_block = "10.0.16.0/20"
  tags = {
    Name = "soat-public-subnet-2"
  }
}

resource "aws_subnet" "soat-public-subnet-3" {
  vpc_id = aws_vpc.soat-vpc.id
  cidr_block = "10.0.32.0/20"
  tags = {
    Name = "soat-public-subnet-3"
  }
}

resource "aws_internet_gateway" "soat-igw" {
  
    vpc_id = aws_vpc.soat-vpc.id

    tags = {
        Name = "soat-igw"
    }

}

resource "aws_route_table" "soat-route-table" {
  vpc_id = aws_vpc.soat-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.soat-igw.id
  }

  tags = {
    Name = "Soat public route table"
  }
}

resource "aws_route_table_association" "soat-route-table-1" {
  subnet_id = aws_subnet.soat-public-subnet-1.id
  route_table_id = aws_route_table.soat-route-table.id
}

resource "aws_route_table_association" "soat-route-table-2" {
  subnet_id = aws_subnet.soat-public-subnet-2.id
  route_table_id = aws_route_table.soat-route-table.id
}

resource "aws_route_table_association" "soat-route-table-3" {
  subnet_id = aws_subnet.soat-public-subnet-3.id
  route_table_id = aws_route_table.soat-route-table.id
}

resource "aws_db_subnet_group" "soat-subnet-group" {
  name       = "my-db-subnet-group"
  subnet_ids = [aws_subnet.soat-public-subnet-1.id, aws_subnet.soat-public-subnet-2.id, aws_subnet.soat-public-subnet-3.id]
}
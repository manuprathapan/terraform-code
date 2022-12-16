resource "aws_vpc" "dev-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "dev-vpc"
  }
}

resource "aws_subnet" "private-subnet-one" {
  vpc_id     = aws_vpc.dev-vpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    "Name" = "dev-private-subnet-one"
  }
}

resource "aws_subnet" "private-subnet-two" {
  vpc_id     = aws_vpc.dev-vpc.id
  cidr_block = "10.0.2.0/24"
  tags = {
    "Name" = "dev-private-subnet-two"
  }
}

resource "aws_subnet" "dev-public-subnet-one" {
  vpc_id     = aws_vpc.dev-vpc.id
  cidr_block = "10.0.3.0/24"
  tags = {
    "Name" = "dev-public-subnet-one"
  }
}

resource "aws_subnet" "dev-public-subnet-two" {
  vpc_id     = aws_vpc.dev-vpc.id
  cidr_block = "10.0.4.0/24"
  tags = {
    "Name" = "dev-public-subnet-two"
  }
}

resource "aws_internet_gateway" "internet-gateway" {
  vpc_id = aws_vpc.dev-vpc.id
  tags = {
    "Name" = "dev-internet-gateway"
  }
}

resource "aws_eip" "dev-eip" {
  tags = {
    "Name" = "dev-eip"
  }
}

resource "aws_nat_gateway" "nat-gateway-one" {
  allocation_id = aws_eip.dev-eip.id
  subnet_id     = aws_subnet.dev-public-subnet-one.id
  tags = {
    "Name" = "dev-nat-gateway-one"
  }
}

resource "aws_nat_gateway" "nat-gateway-two" {
  allocation_id = aws_eip.dev-eip.id
  subnet_id     = aws_subnet.dev-public-subnet-two.id
  tags = {
    "Name" = "dev-nat-gateway-two"
  }
}

resource "aws_route_table" "dev-public-rt" {
  vpc_id = aws_vpc.dev-vpc.id

  route {
    cidr_block = "10.0.0.0/16"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gateway.id
  }

  tags = {
    Name = "dev-public-rt"
  }
}

resource "aws_route_table" "dev-private-rt" {
  vpc_id = aws_vpc.dev-vpc.id

  route {
    cidr_block = "10.0.0.0/16"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gateway-one.id
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gateway-two.id
  }

  tags = {
    Name = "dev-private-rt"
  }
}
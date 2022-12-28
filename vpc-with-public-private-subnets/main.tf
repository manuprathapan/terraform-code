resource "aws_vpc" "vpc" {
  cidr_block = var.vpccidrrange
  tags = {
    "Name" = "${var.resourceprefix}-vpc"
  }
}

resource "aws_subnet" "private-subnet-one" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.privatesubnetonerange
  tags = {
    "Name" = "${var.resourceprefix}-private-subnet-one"
  }
}

resource "aws_subnet" "private-subnet-two" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.privatesubnettworange
  tags = {
    "Name" = "${var.resourceprefix}-private-subnet-two"
  }
}

resource "aws_subnet" "public-subnet-one" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.publicsubnetonerange
  tags = {
    "Name" = "${var.resourceprefix}-public-subnet-one"
  }
}

resource "aws_subnet" "public-subnet-two" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.publicsubnettworange
  tags = {
    "Name" = "${var.resourceprefix}-public-subnet-two"
  }
}

resource "aws_internet_gateway" "internet-gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    "Name" = "${var.resourceprefix}-internet-gateway"
  }
}

resource "aws_eip" "eip" {
  tags = {
    "Name" = "${var.resourceprefix}-eip"
  }
}

resource "aws_nat_gateway" "nat-gateway-one" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public-subnet-one.id
  tags = {
    "Name" = "${var.resourceprefix}-nat-gateway-one"
  }
}

# resource "aws_nat_gateway" "nat-gateway-two" {
#   allocation_id = aws_eip.eip.id
#   subnet_id     = aws_subnet.public-subnet-two.id
#   tags = {
#     "Name" = "dev-nat-gateway-two"
#   }
# }

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.vpccidrrange
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gateway.id
  }

  tags = {
    Name = "${var.resourceprefix}-public-rt"
  }
}

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.vpccidrrange
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gateway-one.id
  }

  # route {
  #   cidr_block = "0.0.0.0/0"
  #   gateway_id = aws_nat_gateway.nat-gateway-two.id
  # }

  tags = {
    Name = "${var.resourceprefix}-private-rt"
  }
}
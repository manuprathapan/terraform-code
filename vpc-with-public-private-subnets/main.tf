resource "aws_vpc" "development-vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      "Name" = "development-vpc"
    }
}

resource "aws_subnet" "private-subnet-one" {
    vpc_id = aws_vpc.development-vpc.id
    cidr_block = "10.0.1.0/24"
    tags = {
      "Name" = "development-private-subnet-one"
    }
}

resource "aws_subnet" "private-subnet-two" {
    vpc_id = aws_vpc.development-vpc.id
    cidr_block = "10.0.2.0/24"
    tags = {
      "Name" = "development-private-subnet-two"
    }
}

resource "aws_subnet" "development-public-subnet-one" {
    vpc_id = aws_vpc.development-vpc.id
    cidr_block = "10.0.3.0/24"
    tags = {
      "Name" = "development-public-subnet-one"
    }
}

resource "aws_subnet" "development-public-subnet-two" {
    vpc_id = aws_vpc.development-vpc.id
    cidr_block = "10.0.4.0/24"
    tags = {
      "Name" = "development-public-subnet-two"
    }
}
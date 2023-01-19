resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "my-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "my-vpc-igw"
  }
}

resource "aws_subnet" "public_subnets" {
  count                   = length(var.subnets_cidr)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = element(var.subnets_cidr, count.index)
  map_public_ip_on_launch = "true"
  availability_zone       = element(var.azs, count.index)
}

resource "aws_route_table" "public_subnet_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "a" {
  count          = length(var.subnets_cidr)
  subnet_id      = element(aws_subnet.public_subnets.*.id, count.index)
  route_table_id = aws_route_table.public_subnet_rt.id
}

resource "random_string" "random" {
  length = 4
  special = false
  upper = false
  lower = true
  numeric = true
}

resource "aws_vpc" "example" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "mondoo-aws-example-${random_string.random.id}"
  }
}

resource "aws_subnet" "example" {
  vpc_id            = aws_vpc.example.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "mondoo-aws-example-${random_string.random.id}"
  }
}

data "aws_ami" "amzn-linux-2023-ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "aws_instance" "example" {
  ami           = data.aws_ami.amzn-linux-2023-ami.id
  instance_type = "c6a.2xlarge"
  subnet_id     = aws_subnet.example.id
  associate_public_ip_address = false

  cpu_options {
    core_count       = 2
    threads_per_core = 2
  }

  tags = {
    Name = "mondoo-aws-example-${random_string.random.id}"
  }
}

output "random_id" {
  value = random_string.random.id
}
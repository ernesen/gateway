# Configure the AWS Provider
provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  #region     = "${var.region}"
  region     = "ap-southeast-1"
}

resource "aws_vpc" "main" {
  cidr_block       = "190.160.0.0/16"
  instance_tenancy = "default"

  tags {
    Name = "main-Sinagpore"
	Location = "Singapore"
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "190.160.0.0/24"

  tags {
    Name = "Subnet1"
  }
}

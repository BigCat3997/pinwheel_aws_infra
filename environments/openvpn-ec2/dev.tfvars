aws_region = "us-east-1"

tags = {
  Project = "openvpn-ec2"
  Env     = "prd"
}

vpc_name       = "openvpn-vpc"
vpc_cidr_block = "10.90.0.0/16"

public_subnets = [
  {
    name = "public-a"
    cidr = "10.90.1.0/24"
    az   = "us-east-1a"
  }
]

internet_gateway_name = "openvpn-igw"

public_route_tables = [
  {
    name = "public-rt"
  }
]

public_rtb_assoc = [
  {
    key              = "public-a"
    subnet_name      = "public-a"
    route_table_name = "public-rt"
  }
]

key_pair_name = "openvpn-key"

vpn_instance_name = "openvpn-server"
vpn_instance_type = "t3.medium"
vpn_subnet_name   = "public-a"

vpn_server_port  = 443
vpn_network      = "10.8.0.0"
vpn_network_mask = "255.255.255.0"

vpn_client_ingress_cidrs = ["0.0.0.0/0"]

admin_ssh_ingress_cidrs = ["0.0.0.0/0"]

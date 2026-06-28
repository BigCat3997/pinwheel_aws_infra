tags = { Environment = "dev" }

create_vpc     = true
vpc_name       = "bc-vpc-rookie-dev-0"
vpc_cidr_block = "10.0.0.0/24"

private_subnets = [
  {
    name = "bc-subnet-rookie_app_private-dev-0"
    cidr = "10.0.0.96/27"
    az   = "us-east-1a"
  },
  {
    name = "bc-subnet-rookie_app_private-dev-1"
    cidr = "10.0.0.128/27"
    az   = "us-east-1b"
  }
]

public_subnets = [
  {
    name = "bc-subnet-rookie_app_public-dev-0"
    cidr = "10.0.0.0/27"
    az   = "us-east-1a"
  },
  {
    name = "bc-subnet-rookie_app_public-dev-1"
    cidr = "10.0.0.32/27"
    az   = "us-east-1b"
  },
  {
    name = "bc-subnet-rookie_bastion_public-dev-0"
    cidr = "10.0.0.64/27"
    az   = "us-east-1a"
  }
]

nsg_definitions = [
  {
    name = "bc-sg-rookie_bastion-dev-0"
    security_rules = [
      {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow SSH"
      }
    ]
    egress_rules = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow all egress"
      }
    ]
  },
  {
    name = "bc-sg-app_ec2-dev-0"
    security_rules = [
      {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow HTTP"
      },
      {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow SSH"
      }
    ]
    egress_rules = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow all egress"
      }
    ]
  },
  {
    name = "bc-sg-rookie_web-dev-0"
    security_rules = [
      {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow HTTP"
      },
      {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow HTTPS"
      },
      {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["10.0.0.64/27"]
        description = "Allow SSH"
      },
    ]
    egress_rules = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow all egress"
      }
    ]
  },
  {
    name = "bc-sg-rookie_nlb-dev-0"
    security_rules = [
      {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow HTTP"
      },
      {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow SSH"
      }
    ]
    egress_rules = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow all egress"
      }
    ]
  },
]

nat_gateways = [
  {
    name        = "bc-nat-rookie-dev-0"
    subnet_name = "bc-subnet-rookie_app_public-dev-0"
    eip_name    = "bc-eip-rookie_nat-dev-0"
  },
  {
    name        = "bc-nat-rookie-dev-1"
    subnet_name = "bc-subnet-rookie_app_public-dev-1"
    eip_name    = "bc-eip-rookie_nat-dev-1"
  }
]

internet_gateway_name = "bc-igw-rookie-dev-0"

public_route_tables = [
  { name = "bc-rt-rookie_public-dev-0" },
  { name = "bc-rt-rookie_public-dev-1" },
  { name = "bc-rt-rookie_bastion_public-dev-0" }
]

private_route_tables = [
  { name = "bc-rt-rookie_private-dev-0", nat_gw_name = "bc-nat-rookie-dev-0" },
  { name = "bc-rt-rookie_private-dev-1", nat_gw_name = "bc-nat-rookie-dev-1" }
]

public_rtb_subnet_assocs = [
  { key = "bc-assoc-public-dev-0", subnet_name = "bc-subnet-rookie_app_public-dev-0", route_table_name = "bc-rt-rookie_public-dev-0" },
  { key = "bc-assoc-public-dev-1", subnet_name = "bc-subnet-rookie_app_public-dev-1", route_table_name = "bc-rt-rookie_public-dev-1" },
  { key = "bc-assoc-public-dev-2", subnet_name = "bc-subnet-rookie_bastion_public-dev-0", route_table_name = "bc-rt-rookie_bastion_public-dev-0" }
]

private_rtb_subnet_assocs = [
  { key = "bc-assoc-private-dev-0", subnet_name = "bc-subnet-rookie_app_private-dev-0", route_table_name = "bc-rt-rookie_private-dev-0" },
  { key = "bc-assoc-private-dev-1", subnet_name = "bc-subnet-rookie_app_private-dev-1", route_table_name = "bc-rt-rookie_private-dev-1" }
]

app_ec2_create_key_pair              = true
app_ec2_key_pair_name                = "bc-kp-app_ec2-dev-0"
app_ec2_name                         = "bc-ec2-app-dev-0"
app_ec2_ami_id                       = "ami-0d8d3b1122e36c000"
app_ec2_instance_type                = "t3.medium"
app_ec2_security_group_names         = ["bc-sg-app_ec2-dev-0"]
app_ec2_associate_public_ip          = false
app_ec2_subnet_name                  = "bc-subnet-rookie_app_private-dev-0"
app_ec2_user_data                    = null
app_ec2_volume_size                  = 50
app_ec2_volume_type                  = "gp3"
app_ec2_volume_encrypted             = true
app_ec2_volume_delete_on_termination = true

lt_ec2_key_pair_name    = "bc-kp-lt_ec2-dev-0"
lt_name_prefix          = "asg-lt-"
lt_ami_id               = "ami-0d8d3b1122e36c000"
lt_instance_type        = "t3.medium"
lt_security_group_names = ["bc-sg-rookie_web-dev-0"]
lt_user_data            = null
lt_volume_type          = "gp3"
lt_volume_size          = 50
lt_volume_encrypted     = true
lt_name                 = "asg-lt"

asg_name                      = "bc-asg-rookie-dev-0"
asg_instance_name             = "bc-ec2-rookie_app-dev-0"
asg_subnet_names              = ["bc-subnet-rookie_app_private-dev-0", "bc-subnet-rookie_app_private-dev-1"]
asg_desired_capacity          = 2
asg_min_size                  = 1
asg_max_size                  = 2
asg_health_check_type         = "EC2"
asg_health_check_grace_period = 300
asg_wait_for_capacity_timeout = "0"

nlb_name                 = "bc-nlb-rookie-dev-0"
nlb_enable_public_access = false
nlb_target_type          = "instance"
nlb_target_group_name    = "nlb-tg"
nlb_target_port          = 80
nlb_target_protocol      = "TCP"
nlb_target_ips           = ["10.0.0.100", "10.0.0.132"]
nlb_listener_port        = 80
nlb_listener_protocol    = "TCP"

alb_name              = "bc-alb-rookie-dev-0"
alb_target_group_name = "alb-tg"
alb_target_port       = 80
alb_target_protocol   = "HTTP"
alb_listener_port     = 80
alb_listener_protocol = "HTTP"

bastion_create_key_pair = true
bastion_key_pair_name   = "bc-kp-bastion-dev-0"

bastion_name                         = "bc-ec2-bastion-dev-0"
bastion_ami_id                       = "ami-0d8d3b1122e36c000"
bastion_instance_type                = "t3.medium"
bastion_subnet_name                  = "bc-subnet-rookie_bastion_public-dev-0"
bastion_security_group_names         = ["bc-sg-rookie_bastion-dev-0"]
bastion_associate_public_ip          = true
bastion_ssh_user                     = "ec2-user"
bastion_user_data                    = null
bastion_volume_size                  = 50
bastion_volume_type                  = "gp3"
bastion_volume_encrypted             = true
bastion_volume_delete_on_termination = true
bastion_create_external_volume       = true

kms_key_name    = "bc-kms-keypair-secrets-dev-0"
kms_description = "KMS key for encrypting SSH key pair secrets"

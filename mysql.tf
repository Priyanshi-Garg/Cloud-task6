provider "aws" {
  region     = "ap-south-1"
  profile    = "mypriyanshi"
}

resource "aws_security_group" "sg" {
  name        = "mysql-sg"

  # Allowing traffic only for MySQL and that too from same VPC only.
  ingress {
    description = "Allow All"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  # Allowing all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "mysql-sg"
  }
}

resource "aws_db_instance" "mysql-db" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7.30"
  instance_class       = "db.t2.micro"
  vpc_security_group_ids = [aws_security_group.sg.id]
  identifier           = "mysqldb"
  name                 = "mysqldb"
  username             = "priyanshi"
  password             = "priyanshi123"
  parameter_group_name = "default.mysql5.7"
  publicly_accessible = true
  skip_final_snapshot = true
}
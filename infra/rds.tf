module "rds" {

  source  = "terraform-aws-modules/rds/aws"
  version = "6.1.1"

  identifier = "terraform-soat-3"

  engine                = "postgres"
  engine_version        = "14"
  instance_class        = "db.t3.micro"
  allocated_storage     = 20
  max_allocated_storage = 100
  multi_az              = false

  publicly_accessible = false

  db_name              = "postgres"
  username             = "postgres"
  password             = "postgres"
  port                 = "5432"
  family               = "postgres14"
  major_engine_version = "14"

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  create_db_subnet_group = true
  subnet_ids             = [aws_subnet.soat-public-subnet-1.id, aws_subnet.soat-public-subnet-2.id]
  vpc_security_group_ids = [aws_security_group.soat-http-sg.id, aws_security_group.soat-postgres-sg.id]

  deletion_protection          = false
  performance_insights_enabled = false
  skip_final_snapshot = true
  manage_master_user_password = false

}


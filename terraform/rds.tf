resource "aws_db_subnet_group" "flask_db_subnets" {
  name       = "flask-db-subnet-group"
  subnet_ids = var.subnet_ids
}

resource "aws_db_instance" "postgres" {
  identifier             = "flask-db"
  engine                 = "postgres"
  engine_version         = "17.6"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  name                   = var.db_name
  username               = var.db_user
  password               = var.db_pass
  skip_final_snapshot    = true
  publicly_accessible    = false
  db_subnet_group_name   = aws_db_subnet_group.flask_db_subnets.name
}
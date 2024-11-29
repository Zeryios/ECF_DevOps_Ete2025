# Configurer le fournisseur AWS
provider "aws" {
  region = "eu-west-3"
}

# Définir une instance EC2
resource "aws_instance" "VM_EC2" {
  ami           = "ami-0cb0b94275d5b4aec" # AMI amazone linux pour la région us-west-2
  instance_type = "t2.micro"

  tags = {
    Name = "VM_EC2"
  }
}

# Définir un bucket S3
resource "aws_s3_bucket" "stockage_bucket" {
  bucket = "stockage-terraform-bucket-123456789"
}

# Définir une règle de versionnage pour le bucket S3
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.stockage_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

output "instance_id" {
  value = aws_instance.VM_EC2.id
}

output "bucket_name" {
  value = aws_s3_bucket.stockage_bucket.bucket
}

resource "aws_db_instance" "mysql_instance" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  db_name                 = "Vm_EC2_DB"
  username             = "admin"
  password             = "examplepassword123"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
}

output "rds_endpoint" {
  value = aws_db_instance.mysql_instance.endpoint
}

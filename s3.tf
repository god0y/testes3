resource "aws_s3_bucket" "this" {
  bucket = "testejefersonbucket"
  acl    = "private"
}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id
  policy = <<EOF
{
"Version": "2012-10-17",
"Statement": [
 {
"Effect": "Allow",
 "Principal": {
 "AWS": "${aws_iam_role.ecs_task_execution_role.arn}"
 },
 "Action": [
 "s3:PutObject",
 "s3:GetObject"],
 "Resource": "${aws_s3_bucket.this.arn}/*"
 }
]
}
 EOF
}

resource "aws_s3_bucket_lifecycle_configuration" "bucket-config" {
  bucket = aws_s3_bucket.this.id
  rule {

    id     = "archivalsssss"

    status = "Enabled"
    transition {
      days          = 365
      storage_class = "GLACIER"
    }
  }
}

resource "aws_iam_role" "ecs_task_execution_role" {
#  / name               = "ecs-${var.repo_name}-${var.environment}"
  name               = "aws_s3_bucket.this.id"

  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "ecs-tasks.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF

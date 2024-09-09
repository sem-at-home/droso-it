terraform {
  backend "s3" {
    bucket = "opentofu-state-372790240845"
    key    = "droso-it"
    region = "eu-west-1"
  }
}

provider "aws" {
  region = "eu-west-1"
}

resource "aws_s3_bucket" "this" {
  bucket = "droso-it-website-bucket"
  tags = {
    Name        = "Droso IT Website"
    Environment = "Production"
  }
}

resource "aws_s3_bucket_website_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.this.id
  key    = "index.html"
  source = "index.html"
}
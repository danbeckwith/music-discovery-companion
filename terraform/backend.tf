terraform {
  backend "s3" {
    bucket = "music-discovery-companion-terraform"
    key = "default/tf/terraform.tfstate"
    region = "eu-west-1" 
  }
}

//bucket = "my-terraform-bucket"
//dynamodb_table = "TerraformStatelock"
//key = "terraform.tfstate"
//profile = "terraform"
//region = "eu-central-1"


//terraform {
//  backend "s3" {
//    bucket="development-hn-tfstate"
//    key="terraform/tfstate/${data.aws_caller_identity.selected.account_id}/${var.project}.tfstate"
//    region="ap-southeast-1"
//  }
//}
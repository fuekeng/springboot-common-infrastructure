variable "environment" {
  default = "dev"
}

variable "project" {
    default = "eks"
  
}

variable "SOURCE_GMAIL_ID"{
  description = "Source GMAIl Id"
  default = "fuekengbilly@gmail.com"
}
variable "SOURCE_AUTH_PASSWORD"{
  description = "Source Auth Password"
  default ="eumqeqwngvyyrbqg"
}
variable "DESTINATION_GMAIL_ID"{
  description = ""
  default ="fuekengbilly@gmail.com@gmail.com"
}

variable "domain_name" {
  default = "billsoft237.com"
}

variable "allow_ip" {
  default = ["0.0.0.0/0"]
}
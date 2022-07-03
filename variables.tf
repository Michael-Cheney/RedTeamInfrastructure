variable "region" {
    default = "ap-southeast-2"
    description = "AWS Region"
}

variable "Key_name" {
    default = "ssh"
    description = "SSH Key"
}

variable "ClientID" {
    default = "ClientID"
    description = "Unique Client ID to differentiate resources"
}

variable "Zone_id" {
    default = "Z02859512H3DJHOOHN2T7"
    description = "Zone ID"
}

variable "Private_key" {
    default = "C:\\temp\\ssh.pem"
    description = "Private key file location"
}

variable "Root_domain" {
    default = "rumboman.com"
    description = "Root Domain"
}
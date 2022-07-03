output "A_Connect_to_instance_with" {
  value = "ssh -i ${var.Private_key} ubuntu@${aws_instance.DNS_exfil_Server.public_ip}"
  description = "Test the description field"
}
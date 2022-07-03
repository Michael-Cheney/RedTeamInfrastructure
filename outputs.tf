output "A_Connect_to_instance_with" {
  value = "ssh -i ${var.Private_key} kali@${aws_instance.Kali_Sliver_C2_Server.public_ip}"
  description = "Test the description field"
}
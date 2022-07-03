resource "aws_instance" "Kali_Sliver_C2_Server" {
    ami             = "ami-0e549bae2ca666772"
    instance_type   = "t2.medium"
    key_name = var.Key_name
    security_groups = ["${var.ClientID}_Kali_Sliver_C2_Server_SG"]

    root_block_device {
        volume_size = 30
        volume_type = "gp2"
    }

    provisioner "file" {
        source = "ansible/setup.yaml"
        destination = "/home/kali/setup.yaml"
    }

    connection {
        host = aws_instance.Kali_Sliver_C2_Server.public_ip
        type = "ssh"
        user = "kali"
        private_key = file(var.Private_key)
    }
    provisioner "remote-exec" {
        inline = [
            "sleep 60",
            "sudo apt update",
            "sudo apt install ansible -y",
            "ansible-playbook setup.yaml",
        ]
    }

    tags                          = {
        Name        = "${var.ClientID}_Kali_Sliver_C2_Server"
        ClientID    = var.ClientID
    }
}

resource "aws_security_group" "Kali_Sliver_C2_Server_SG" {
    name = "${var.ClientID}_Kali_Sliver_C2_Server_SG"
    tags                          = {
        Name        = "${var.ClientID}_Kali_Sliver_C2_Server_SG"
        ClientID    = var.ClientID
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 8888
        to_port = 8888
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        protocol = "-1"
        to_port = 0
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_route53_record" "dnsexfil" {
    zone_id = var.Zone_id
    name    = "${var.ClientID}-kali.${var.Root_domain}"
    type    = "A"
    ttl     = "300"
    records = [aws_instance.Kali_Sliver_C2_Server.public_ip]
    depends_on                  = [
      aws_instance.Kali_Sliver_C2_Server
    ]
}
output "address"{
    value="${aws_instance.web.public_dns}"
 }

output "ip" {
    value = "${aws_eip.ip.public_ip}"
}

provider "aws"{
    region="${var.aws_region}"
    access_key="${var.access_key}"
    secret_key="${var.secret_key}"
}
 
resource "aws_security_group" "default"{
    name="terraform-sg"
    description="Created by terraform"
 
    ingress{
        from_port = 22
        to_port = 22
        protocol= "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress{
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port   = "0"
        to_port     = "0"
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

 
}
resource "aws_instance" "web"{
 
    connection={
        user="ubuntu"
        key_file="${var.key_path}"
    }
    instance_type="t2.medium"
    ami="${lookup(var.aws_amis, var.aws_region)}"
    key_name = "${var.key_name}"
    security_groups= ["${aws_security_group.default.name}"]
    tags{
        Name="Terraform-EC2-test"
    }
    provisioner "remote-exec"{
 
        inline=[
	    "ping -c 10 8.8.8.8",
            "sudo apt-get -y update",
            "sudo apt-get -y install tomcat7 tomcat7-admin",
            "sudo rm -f /etc/tomcat7/tomcat-users.xml",
            "sudo wget https://raw.githubusercontent.com/roybhaskar9/terraform/master/tomcat-users.xml -P /etc/tomcat7/",
            "sudo service tomcat7 restart"
	    "wget https://github.com/roybhaskar9/terraform/raw/master/sample.war -O /tmp/sample.war"
            "wget --http-user=admin --http-password=admin 'http://localhost:8080/manager/text/deploy?war=file:/tmp/sample.war&path=/sampleapp' -O -"	
        ]
     }
}
resource "aws_eip" "ip" {
    instance = "${aws_instance.web.id}"
    depends_on = ["aws_instance.web"]
}

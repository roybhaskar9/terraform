# terraform 

terraform plan

terraform apply

terraform output ip

#If Chef needs to be called within terraform

resource "aws_instance" "web" {

    ...
    
    provisioner "chef"  {
    
        environment = "_default"
        
        run_list = ["cookbook::recipe"]
        
        node_name = "webserver1"
        
        server_url = "https://chef.company.com/organizations/org1"
        
        validation_client_name = "chef-validator"
        
        validation_key = "${file("../chef-validator.pem")}"
        
        version = "12.4.1"
        
    }
    
}

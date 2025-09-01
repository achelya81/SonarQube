packer {
  required_plugins {
    amazon = {
      version = "1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "SonarQube-image"
  instance_type = "t2.micro"
  region        = "us-east-1"
  source_ami = "ami-0bbdd8c17ed981ef9"
  ssh_username = "ubuntu"
  ssh_keypair_name = "sonarqube-key"
  ssh_private_key_file = "~/.ssh/id_ed25519"
}

build {
  name    = "sonarqube-packer"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]

  provisioner "shell" {
    script = "sonarqube.sh"
  }
}


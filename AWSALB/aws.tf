resource "aws_instance" "aws" {
  count = var.enable_aws_env ? var.aws_instance_count : 0

  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t2.micro"
  
  
  subnet_id              = module.vpc.public_subnets[count.index % length(module.vpc.public_subnets)]
  vpc_security_group_ids = [module.app_security_group.this_security_group_id]
  user_data = templatefile("${path.module}/init-script.sh", {
    file_content = "Tags: >name ${local.Tag_name}, owner ${local.Tag_owner}< - #${count.index} OK!"
  })

  tags = {
    Name = "${local.Tag_name}-${count.index}"
    Owner = "${local.Tag_owner}-${count.index}"
  }
}

resource "aws_lb_target_group" "aws" {
  name     = "aws-tg-${random_pet.app.id}-lb"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id

  health_check {
    port     = 80
    protocol = "HTTP"
    timeout  = 5
    interval = 10
  }
}

resource "aws_lb_target_group_attachment" "aws" {
  count            = length(aws_instance.aws)
  target_group_arn = aws_lb_target_group.aws.arn
  target_id        = aws_instance.aws[count.index].id
  port             = 80
}

locals {
    Tag_name = var.Tag_name
    Tag_owner = var.Tag_owner

}
output "lb_dns_name" {
  value = aws_lb.app.dns_name
}

output "instance_id0" {  
  value = "${aws_instance.aws.0.id}"
}

output "instance_id1" {
  value = "${aws_instance.aws.1.id}"
}
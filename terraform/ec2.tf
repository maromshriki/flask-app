resource "aws_launch_template" "flask_lt" {
  name_prefix   = "flask-"
  image_id      = "ami-12345678" # Amazon Linux 2
  instance_type = var.ec2_instance_type
  key_name      = "YOUR_KEY_PAIR"

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_profile.name
  }

  vpc_security_group_ids = [aws_security_group.flask_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install docker -y
              systemctl start docker
              systemctl enable docker
              aws ecr get-login-password --region ${var.aws_region} | docker login --username AWS --password-stdin ${aws_ecr_repository.flask_app.repository_url}
              docker pull ${aws_ecr_repository.flask_app.repository_url}:latest
              docker run -d -p 5000:5000 --name flask --env-file /home/ec2-user/flask-app/secret/flask.env ${aws_ecr_repository.flask_app.repository_url}:latest
              EOF
}

resource "aws_autoscaling_group" "flask_asg" {
  desired_capacity     = 1
  max_size             = 2
  min_size             = 1
  vpc_zone_identifier  = var.subnet_ids
  launch_template {
    id      = aws_launch_template.flask_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Role"
    value               = "flask-server"
    propagate_at_launch = true
  }
}
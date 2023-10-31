# resource "aws_ecs_task_definition" "soat-api-backend" {
#   family                   = "soat-api-backend"
#   requires_compatibilities = ["FARGATE"]
#   network_mode             = "awsvpc"
#   cpu                      = 1024
#   memory                   = 2048
#   execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
#   runtime_platform {
#     cpu_architecture = "ARM64"
#     operating_system_family = "LINUX"
#   }
#   container_definitions = jsonencode([
#     {
#       name  = "soat-api-backend"
#       image = "msimoni/soat-modulo-3:latest"
#       cpu : 1024
#       memory = 2048
#       portMappings = [
#         {
#           containerPort = 8080
#           protocol      = "tcp"
#           hostPort      = 8080
#         }
#       ]
#       environment = [
#         {
#             name = "SPRING_PROFILES_ACTIVE"
#             value = "h2"
#         }
#       ]
#       logConfiguration = {
#             logDriver = "awslogs"
#             options = {
#                 awslogs-create-group = "true"
#                 awslogs-group = "/ecs/api-backend"
#                 awslogs-region = "us-east-1"
#                 awslogs-stream-prefix = "ecs"
#             }
#             secretOptions = []
#         }
#     }
#   ])
# }

# resource "aws_iam_role" "ecs_task_execution_role" {
#     name = "soat-ecs-role"
#     assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
# }

# resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
#   role       = aws_iam_role.ecs_task_execution_role.name
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
# }

# resource "aws_ecs_service" "soat-api-backend-service" {
#   name            = "soat-api-backend-service"
#   cluster         = aws_ecs_cluster.soat-cluster.id
#   task_definition = aws_ecs_task_definition.soat-api-backend.arn
#   desired_count   = 1
#   launch_type     = "FARGATE"

#   network_configuration {
#     security_groups = [aws_security_group.soat-http-sg.id]
#     subnets         = [aws_subnet.soat-public-subnet-1.id,aws_subnet.soat-public-subnet-2.id]
#     assign_public_ip = true
#   }

#   load_balancer {
#     target_group_arn = aws_lb_target_group.soat-target-group.id
#     container_name   = "soat-api-backend"
#     container_port   = 8080
#   }

#   depends_on = [aws_lb_listener.http-listener]

# }

# resource "aws_ecs_cluster" "soat-cluster" {
#   name = "soat-cluster"
# }

#  resource "aws_efs_file_system" "efs" {
#   creation_token = "${local.env.environment}-efs"



#   tags = {
#     Name = "${local.env.environment}-efs"
#     Terraform = "true"
#     workspace = terraform.workspace
#   }
# }

# resource "aws_efs_backup_policy" "efs_policy" {
#   file_system_id = aws_efs_file_system.efs.id

#   backup_policy {
#     status = "ENABLED"
#   }

#   depends_on = [ aws_efs_file_system.efs ]
# }
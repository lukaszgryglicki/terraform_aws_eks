variable "API_DB_PASSWORD" {}

resource "aws_db_subnet_group" "api_devstats" {
  name        = "dev-analytics-api-devstats-${var.tag_env}"
  subnet_ids  = ["${module.base_vpc.private_subnets}"]
}

resource "aws_rds_cluster_parameter_group" "api_devstats" {
  name   = "dev-analytics-api-devstats-${var.tag_env}"
  family = "aurora-postgresql10"
  description = "dev-analytics-api-devstats-${var.tag_env}"
}

resource "aws_security_group" "api_devstats_db" {
  name   = "dev-analytics-api-devstats-db-${var.tag_env}"
  vpc_id = "${module.base_vpc.vpc_id}"
}

resource "aws_security_group_rule" "api_devstats_db_allow_broad_internal" {
  security_group_id = "${aws_security_group.api_devstats_db.id}"

  type            = "ingress"
  from_port       = 5432
  to_port         = 5432
  protocol        = "tcp"

  cidr_blocks = ["${var.vpc_cidr_private}"]
}

resource "aws_security_group_rule" "api_devstats_db_allow_broad_egress" {
  security_group_id = "${aws_security_group.api_devstats_db.id}"

  type            = "egress"
  from_port       = 0
  to_port         = 0
  protocol        = "-1"

  cidr_blocks = [
    "0.0.0.0/0"
  ]
}

resource "aws_iam_role" "api_devstats_db" {
  name               = "api_devstats_db"
  assume_role_policy = "${data.aws_iam_policy_document.rds_enhanced_monitoring.json}"
}

resource "aws_iam_role_policy_attachment" "api_devstats_db_enhanced_monitoring" {
  role       = "${aws_iam_role.api_devstats_db.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

data "aws_iam_policy_document" "rds_enhanced_monitoring" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["monitoring.rds.amazonaws.com"]
    }
  }
}

resource "aws_rds_cluster" "api_devstats" {
  cluster_identifier              = "dev-analytics-api-devstats-${var.tag_env}"
  master_username                 = "sa"
  master_password                 = "${var.API_DB_PASSWORD}"

  db_subnet_group_name            = "${aws_db_subnet_group.api_devstats.name}"
  vpc_security_group_ids          = ["${aws_security_group.api_devstats_db.id}"]

  engine                          = "aurora-postgresql"
  engine_version                  = "10.4"

  db_cluster_parameter_group_name = "${aws_rds_cluster_parameter_group.api_devstats.name}"

  apply_immediately  = true

  preferred_maintenance_window = "Mon:00:00-Mon:03:00"
  preferred_backup_window      = "03:00-06:00"

  final_snapshot_identifier       = "dev-analytics-api-devstats-aurora-final"
  skip_final_snapshot             = false

  storage_encrypted               = true
}

resource "aws_rds_cluster_instance" "members" {
  count              = "1"

  identifier         = "dev-analytics-api-devstats-${var.tag_env}-${count.index}"
  cluster_identifier = "${aws_rds_cluster.api_devstats.id}"
  instance_class     = "db.r4.large"
  engine             = "aurora-postgresql"
  engine_version     = "10.4"

  monitoring_interval           = "10"
  monitoring_role_arn           = "${aws_iam_role.api_devstats_db.arn}"
  performance_insights_enabled  = true

}

output "api_devstats_db_subnet_group_id" {
  value = "${aws_db_subnet_group.api_devstats.id}"
}

output "api_devstats_db_endpoint" {
  value = "${aws_rds_cluster.api_devstats.endpoint}"
}

output "api_devstats_db_endpoint_reader" {
  value = "${aws_rds_cluster.api_devstats.reader_endpoint}"
}

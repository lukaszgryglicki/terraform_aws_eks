# dev-analytics-terraform-stash: terraform console > module.base_vpc.vpc_id "vpc-0b926afff46cf3457"
# current vpc: "vpc-0552ea0e8c5d4587e"

resource "aws_vpc_peering_connection" "vpc_peer" {
  peer_vpc_id   = "vpc-0b926afff46cf3457"
  vpc_id        = "${aws_vpc.demo.id}"
}

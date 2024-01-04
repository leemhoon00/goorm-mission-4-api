resource "aws_route53_record" "server" {
  zone_id = var.zone_id
  name    = "api"
  type    = "A"

  alias {
    name                   = aws_lb.server.dns_name
    zone_id                = aws_lb.server.zone_id
    evaluate_target_health = true
  }
}

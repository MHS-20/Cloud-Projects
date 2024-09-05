module "load_balancer_service" {
  source = "../terraform-modules/kubernetes/Lb"

  service_name     = "mytube-lb"
  service_type     = "LoadBalancer"
  selector_app     = "mytube"
  selector_service = "video-streaming"
  port             = 80
  target_port      = 4002
}

output "load_balancer_service_name" {
  value = module.load_balancer_service.service_name
}
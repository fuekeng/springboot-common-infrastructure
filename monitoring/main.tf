resource "helm_release" "prometheus" {
  create_namespace = true
  name       = "prometheus"
  namespace  = "monitoring"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"
  version    = "25.27.0" # Version stable actuelle de la stack Prometheus (v25.x)!
  
  values = [templatefile("${var.environment}/values_prom.yaml", {
    DESTINATION_GMAIL_ID   = var.DESTINATION_GMAIL_ID
    SOURCE_AUTH_PASSWORD   = var.SOURCE_AUTH_PASSWORD
    SOURCE_GMAIL_ID        = var.SOURCE_GMAIL_ID
  })]
}

resource "helm_release" "grafana" {
  create_namespace = true
  name       = "grafana"
  namespace  = "monitoring"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  version    = "8.5.0" # Version stable de Grafana (Chart v8.x) compatible Kubernetes 1.26+!
  
  values = [
    file("${var.environment}/values_grafana.yaml")
  ]
  set {
    name  = "adminPassword"
    value = "admin"
  }
}


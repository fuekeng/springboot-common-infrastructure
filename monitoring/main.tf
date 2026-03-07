resource "helm_release" "prometheus" {
  create_namespace = true
  name       = "prometheus"
  namespace  = "monitoring"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"
  version    = "25.27.0"

  values = [templatefile("${var.environment}/values_prom.yaml", {
    DESTINATION_GMAIL_ID = var.DESTINATION_GMAIL_ID
    SOURCE_AUTH_PASSWORD = var.SOURCE_AUTH_PASSWORD
    SOURCE_GMAIL_ID      = var.SOURCE_GMAIL_ID
  })]

  set {
    name  = "server.prefixURL"
    value = "/prometheus"
  }

  set {
    name  = "server.baseURL"
    value = "http://localhost/prometheus"
  }
}

resource "helm_release" "grafana" {
  create_namespace = true
  name       = "grafana"
  namespace  = "monitoring"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  version    = "8.5.0"

  values = [
    file("${var.environment}/values_grafana.yaml")
  ]

  set {
    name  = "adminPassword"
    value = "admin"
  }

  set {
    name  = "grafana\\.ini.server.root_url"
    value = "%(protocol)s://%(domain)s/grafana/"
  }

  set {
    name  = "grafana\\.ini.server.serve_from_sub_path"
    value = "true"
  }
}
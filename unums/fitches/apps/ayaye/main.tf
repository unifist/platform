resource "kubernetes_namespace" "namespace" {
  metadata {
    name = "ayaye"
  }
}

resource "kubernetes_config_map_v1" "config" {
  metadata {
    namespace = kubernetes_namespace.namespace.metadata[0].name
    name      = "config"
  }

  data = {
    "unum.json" = jsonencode({
        "name"     = "fitches"
        "location" = "do"
    })
  }
}

resource "kubernetes_manifest" "argo_project" {
  manifest = yamldecode(file("${path.module}/project.yaml"))

  depends_on = [kubernetes_namespace.namespace]
}

resource "kubernetes_manifest"  "argo_application" {
  manifest = yamldecode(file("${path.module}/application.yaml"))

  depends_on = [kubernetes_manifest.argo_project]
}

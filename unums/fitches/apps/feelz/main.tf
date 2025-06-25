resource "kubernetes_namespace" "namespace" {
  metadata {
    name = "feelz"
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

data "digitalocean_database_cluster" "cluster" {
  name = "do-fitches-unum"
}

resource "digitalocean_database_user" "user" {
  cluster_id = data.digitalocean_database_cluster.cluster.id
  name       = "feelz"
}

resource "kubernetes_secret" "secret" {
  metadata {
    namespace = kubernetes_namespace.namespace.metadata[0].name
    name      = "secret"
  }

  type = "generic"

  data = {
    "mysql.json" = jsonencode({
        "host" =     data.digitalocean_database_cluster.cluster.private_host
        "port" =     data.digitalocean_database_cluster.cluster.port
        "user" =     digitalocean_database_user.user.name
        "password" = digitalocean_database_user.user.password
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

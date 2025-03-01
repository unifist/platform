resource "digitalocean_kubernetes_cluster" "cluster" {
  name   = "do-dev-unum"
  region = "nyc3"
  # Grab the latest version slug from `doctl kubernetes options versions`
  version = "1.31.5-do.0"

  node_pool {
    name       = "worker-pool"
    size       = "s-2vcpu-2gb"
    node_count = 1
  }

  provisioner "local-exec" {
    when    = create
    command = "make context"
  }
}

resource "digitalocean_database_cluster" "mysql" {
  name       = "do-dev-unum"
  engine     = "mysql"
  version    = "8"
  size       = "db-s-1vcpu-1gb"
  region     = "nyc3"
  node_count = 1
}

resource "digitalocean_database_firewall" "cluster" {
  cluster_id = digitalocean_database_cluster.mysql.id

  rule {
    type  = "k8s"
    value = digitalocean_kubernetes_cluster.cluster.id
  }
}

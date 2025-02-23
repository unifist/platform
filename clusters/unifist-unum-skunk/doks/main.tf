resource "digitalocean_kubernetes_cluster" "cluster" {
  name   = "unifist-unum-skunk"
  region = "nyc3"
  # Grab the latest version slug from `doctl kubernetes options versions`
  version = "1.31.5-do.0"

  node_pool {
    name       = "worker-pool"
    size       = "s-2vcpu-2gb"
    node_count = 3
  }
}

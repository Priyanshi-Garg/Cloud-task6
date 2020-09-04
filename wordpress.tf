provider "kubernetes" {
  config_context_cluster   = "minikube"
}

resource "kubernetes_service" "service" {
  metadata {
    name = "service-nodeport"
  }
  spec {
    selector = {
      app = "wp"
    }
    session_affinity = "ClientIP"
    port {
      port        = 80
      target_port = 80
      node_port = 30000
    }

    type = "NodePort"
  }
}

resource "kubernetes_deployment" "wp-deploy" {
  metadata {
    name = "wp-deploy"
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "wp"
      }
    }

    template {
      metadata {
        labels = {
          app = "wp"
        }
      }

      spec {
        container {
          image = "wordpress"
          name  = "wp-con"
        }
      }
    }
  }
}
resource "random_password" "admin_password" {
  length      = 32
  upper       = true
  min_upper   = 2
  lower       = true
  min_lower   = 2
  number      = true
  min_numeric = 2
  special     = false
  min_special = 0
}

resource "random_password" "rabbit_password" {
  length      = 32
  upper       = true
  min_upper   = 2
  lower       = true
  min_lower   = 2
  number      = true
  min_numeric = 2
  special     = false
  min_special = 0
}

resource "random_string" "secret_cookie" {
  length      = 64
  upper       = true
  min_upper   = 9
  lower       = true
  min_lower   = 9
  number      = true
  min_numeric = 9
  special     = false
  min_special = 0
}

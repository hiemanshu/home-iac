data "local_file" "laptop_key" {
  filename = "./laptop.key.pub"
}

data "local_file" "mac_key" {
  filename = "./mac.key.pub"
}

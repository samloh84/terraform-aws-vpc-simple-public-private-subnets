data "http" "checkip" {
  url = "https://ipv4.icanhazip.com"
}

locals {
  local_ip = "${chomp(data.http.checkip.response_body)}/32"
}
resource "aws_kms_key" "client_secret" {
    description = "For encrypting and decrypting the Client Secret"
}

data "aws_kms_secrets" "client_secret" {
    secret {
        name = "client_secret"
        payload = var.client_secret

        context = {
            fonky = "bonky"
        }
    }
}
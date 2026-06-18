resource "aws_key_pair" "terraform" {
  key_name   = "your aws key name"
  public_key = file(pathexpand("your file path to your public key"))
}

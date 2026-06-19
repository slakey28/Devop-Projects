resource "aws_key_pair" "terraform" {
  key_name   = "your aws key name"
  public_key = file(pathexpand("~/.ssh/id_ed25519.pub"))
}

let
  tinkaton = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK33suoTyitaAGopoHbVZPa6Vnx5vlLmgKGeECY6CM2i";

  brooklyn = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINSrqkXtluHRGoNSDuwpPj2pZXlNZFxPFqsmwxjP1X0P";
in
{
  "networking.wg-quick.interfaces.wg0.privateKey.age".publicKeys = [
    tinkaton
    brooklyn
  ];
}

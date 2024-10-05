# Better defaults for OpenSSH
{ lib, ... }:
{
  environment.etc."ssh/sshd_config.d/102-srvos.conf".text = ''
    # Only allow system-level authorized_keys to avoid injections.
    # nix-darwin uses AuthorizedKeysCommand to set system-level keys
    # https://github.com/LnL7/nix-darwin/blob/f61d5f2051a387a15817007220e9fb3bbead57b3/modules/programs/ssh/default.nix#L158
    AuthorizedKeysFile none

    X11Forwarding no
    KbdInteractiveAuthentication no
    PasswordAuthentication no
    UseDns no
    # unbind gnupg sockets if they exists
    StreamLocalBindUnlink yes

    # Use key exchange algorithms recommended by `nixpkgs#ssh-audit`
    KexAlgorithms curve25519-sha256,curve25519-sha256@libssh.org,diffie-hellman-group16-sha512,diffie-hellman-group18-sha512,sntrup761x25519-sha512@openssh.com
  '';
}

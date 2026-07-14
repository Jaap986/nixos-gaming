{ pkgs, extraArgs ? {}, ... }:

let
  userName = "gamer";
  githubUserName = "Jaap986";
in
{
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = [ userName ];
    };
  };

  systemd.services.github-authorized-keys = {
    description = "Fetch SSH authorized keys from GitHub";
    wantedBy = [ "multi-user.target" ];
    wants = [
      "NetworkManager-wait-online.service"
      "network-online.target"
    ];
    after = [
      "NetworkManager-wait-online.service"
      "network-online.target"
    ];
    serviceConfig = {
      Type = "oneshot";
      RuntimeDirectory = "github-authorized-keys";
      StateDirectory = "ssh";
    };
    path = with pkgs; [ coreutils curl openssh ];
    script = ''
      set -euo pipefail

      install -d -m 0755 /etc/ssh/authorized_keys.d
      curl --fail --silent --show-error --location \
        --retry 24 --retry-delay 5 --retry-all-errors \
        --connect-timeout 10 \
        --output /run/github-authorized-keys/${userName}.keys \
        https://github.com/${githubUserName}.keys
      ssh-keygen -l -f /run/github-authorized-keys/${userName}.keys >/dev/null
      install -m 0644 /run/github-authorized-keys/${userName}.keys \
        /etc/ssh/authorized_keys.d/${userName}
    '';
  };
}

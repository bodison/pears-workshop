{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

{
  # https://devenv.sh/basics/
  env.GREET = "pears workshop devenv";

  # https://devenv.sh/packages/
  packages = [
    pkgs.git
    pkgs.nodejs_23
    # pkgs.libgccjit # includes libatmic
    # pkgs.libatomic_ops
  ];

  # https://devenv.sh/languages/
  # languages.rust.enable = true;

  # https://devenv.sh/processes/
  # processes.cargo-watch.exec = "cargo-watch";

  # https://devenv.sh/services/
  # services.postgres.enable = true;

  # https://devenv.sh/scripts/
  scripts.hello.exec = ''
    ${pkgs.cowsay}/bin/cowsay Hello from $GREET
  '';

  enterShell = ''
    hello
    git --version
    git clone https://github.com/holepunchto/pear && cd pear && npm ci
  '';
  # npx pear

  # export PATH=~/.config/pear/bin:$PATH
  # ln -s ~/.config/pear/current/by-arch/linux-x64/bin ~/.config/pear/

  # https://devenv.sh/tasks/
  # tasks = {
  #   "myproj:setup".exec = "mytool build";
  #   "devenv:enterShell".after = [ "myproj:setup" ];
  # };

  # https://devenv.sh/tests/
  enterTest = ''
    echo "Running tests"
    git --version | grep --color=auto "${pkgs.git.version}"
  '';

  # https://devenv.sh/git-hooks/
  # git-hooks.hooks.shellcheck.enable = true;

  # See full reference at https://devenv.sh/reference/options/
}

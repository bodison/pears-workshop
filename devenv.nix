{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

let
  buildInputs = with pkgs; [
    glib # libglib-2.0.so.0
    nss # libnss3.so
    nspr # libnspr4.so
    dbus # libdbus-1.so.3
    at-spi2-atk # libatk-1.0.so.0
    cups # libcups.so.2
    libdrm # libdrm.so.2
    gtk3 # libgtk-3.so.0
    pango # libpango-1.0.so.0
    cairo # libcairo.so.2
    xorg.libX11 # libX11.so.6
    xorg.libXcomposite # libXcomposite.so.1
    xorg.libXdamage # libXdamage.so.1
    xorg.libXext # libXext.so.6
    xorg.libXfixes # libXfixes.so.3
    xorg.libXrandr # libXrandr.so.2
    libgbm # libgbm.so.1
    expat # libexpat.so.1
    xorg.libxcb # libxcb.so.1
    libxkbcommon # libxkbcommon.so.0
    alsa-lib # libasound.so.2
    libuuid # libmount.so.1 version `MOUNT_2_40'
    libglvnd # libGL.so.1 (might be optional, pear runtime starts without)
  ];
in
{
  env = {
    GREET = "pears workshop devenv";
    LD_LIBRARY_PATH = "${with pkgs; lib.makeLibraryPath buildInputs}";
  };

  # https://devenv.sh/packages/
  packages = with pkgs; [
    git
    nodejs_23
    graphene # if you want to run keet (./pear/pear.dev run pear://keet)
  ];

  # https://devenv.sh/scripts/
  scripts = {
    hello.exec = ''
      ${pkgs.cowsay}/bin/cowsay Hello from $GREET
    '';
    InstallPearRuntime.exec = ''
      git clone https://github.com/holepunchto/pear \
        && cd pear \
        && git switch release/1.13.x \
        && npm ci \
        && npm run bootstrap \
        && cd ..
    '';
  };

  enterShell = ''
    hello
    git --version
    InstallPearRuntime
  '';
}

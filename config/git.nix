{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Mickey Burks";
    userEmail = builtins.replaceStrings ["\n"] [""] (builtins.readFile ~/.config/nixpkgs/.user-email);
    ignores = [
      "*.dll"
      "*.exe"
      "*.o"
      "*.so"
      "*.swp"
      "*.swo"
      "*.sqlite"
      ".DS_Store*"
      "node_modules"
      "tmp"
      ".user-email"
    ];
    aliases = {
      unstage = "reset HEAD --";
    };
    delta = {
      enable = true;
      options = {
        features = "side-by-side line-numbers decorations";
        syntax-theme = "Nord";
        side-by-side = true;
      };
    };
    extraConfig = {
      pull = {
        rebase = true;
      };
    };
  };
}

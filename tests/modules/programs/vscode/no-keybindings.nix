# Test that keybindings.json is created correctly.
{ config, lib, pkgs, ... }:

with lib;

let
  targetPath = if pkgs.stdenv.hostPlatform.isDarwin then
    "Library/Application Support/Code/User/keybindings.json"
  else
    ".config/Code/User/keybindings.json";
in {
  config = {
    programs.vscode = {
      enable = true;
      package = pkgs.writeScriptBin "vscode" "" // { pname = "vscode"; };
    };

    nmt.script = ''
      assertPathNotExists "home-files/${targetPath}"
    '';
  };
}

{ pkgs, lib, ... }:
{
  packages = lib.attrValues { inherit (pkgs) elixir elixir-ls; };
}

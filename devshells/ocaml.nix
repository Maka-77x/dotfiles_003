{ pkgs, lib, ... }:
{
  packages = lib.attrValues {
    inherit (pkgs)
      dune_3 # Package manager
      dune-release
      gnumake # Needed for exercism tests
      ocaml
      ocamlformat # Code formatter
      ocamlPackages
      ;
    inherit (pkgs.ocamlPackages)
      ocaml-lsp
      findlib # Needed for everything to work
      odoc # Documentation generator
      ounit2 # Unit test runner
      utop # Repl
      core
      core_extended
      ;
  };

  # Unfortunately, findlib's setupHook does not propagate to nix develop
  # This ugly workaround will have to suffice
  devshell.startup.ocamlpath.text = ''
    nix-shell --packages ocamlPackages.findlib \
                         ocamlPackages.ounit2 \
                         ocamlPackages.core \
                         ocamlPackages.core_extended
  '';
}

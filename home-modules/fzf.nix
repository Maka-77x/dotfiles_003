{ lib, pkgs, ... }:
let

  # https://manpages.debian.org/unstable/fzf/fzf.1.en.html
  common = [
    "--reverse"
    "--preview 'echo {}'"
    "--preview 'bat --plain --color=always \"{}\"'"
    "--preview-window up:3:hidden:wrap"
    "--bind 'ctrl-/:toggle-preview'"
    "--bind 'ctrl-y:execute-silent(echo -n {2..} | ${pkgs.wl-clipboard})+abort'"
    "--bind=tab:down"
    "--bind=shift-tab:up"
    "--sort"
    "--height 100%"
    "--border"
    "--header 'Press CTRL-Y to copy to clipboard'"
    "--color header:italic"
  ];
in
{
  home.packages = lib.attrValues { inherit (pkgs) pistol fzf wl-clipboard; };
  programs.fzf = {
    enable = true;
    # https://github.com/junegunn/fzf#fuzzy-completion-for-bash-and-zsh
    enableZshIntegration = true;
    # enableNushellIntegration = true;
    # colors = {
    #   bg = "#000000";
    #   "bg+" = "#FF00FF";
    #   fg = "#FF00FF";
    #   "fg+" = "#000000";
    # };
    defaultOptions = common;
    fileWidgetOptions = common ++ [ "--preview '${pkgs.pistol} {}'" ];
    # CTRL-R: redo
    historyWidgetOptions = common;
    # ALT-C: cd
    changeDirWidgetOptions = common ++ [ "--preview '${pkgs.pistol} {}'" ];
  };
  home.sessionVariables.ENHANCD_FILTER = "${pkgs.fzf} ${lib.concatStringsSep " " common} --preview '${pkgs.pistol} {}'";
}

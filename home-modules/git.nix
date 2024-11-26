{ ... }:
{
  programs.git = {
    enable = true;
    userEmail = "99078878+Maka-77x@users.noreply.github.com";
    userName = "Maka-77x";

    delta = {
      enable = true;
      options = {
        navigate = true;
        interactive.keep-plus-minus-markers = false;
      };
    };

    extraConfig = {
      # ''
      # [credential]
      # helper = cache
      # '';
      init.defaultBranch = "dev";
      core.autocrlf = "input";
      merge.conflictstyle = "diff3";
      diff.colorMoved = "default";
    };
  };

  programs.lazygit = {
    enable = true;
    settings = {
      theme.nerdFontsVersion = 3;
      update.method = false;
      disableStartupPopups = true;
      git =
        let
          logCmd = "git log --color=always";
        in
        {
          paging = {
            colorArg = "always";
            pager = ''DELTA_FEATURES="+" delta --paging=never'';
          };
          branchLogCmd = "${logCmd} {{branchName}}";
          allBranchesLogCmds = [ "${logCmd} --all" ];
        };
    };
  };

  home.sessionVariables = {
    # Ensure bat's line numbers don't show up and mess things up
    DELTA_PAGER = "bat --plain";
    # Ensure --side-by-side is only used for `git diff`
    DELTA_FEATURES = "+side-by-side";
  };
}

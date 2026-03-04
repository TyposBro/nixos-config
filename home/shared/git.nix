{ ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name = "TyposBro";
      user.email = "typosbro@proton.me";
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = false;
      core.autocrlf = "input";
      core.editor = "vim";
      diff.colorMoved = "zebra";
    };
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks."*" = {
      extraOptions.AddKeysToAgent = "yes";
    };
    matchBlocks."github.com" = {
      hostname = "github.com";
      user = "git";
      identityFile = "~/.ssh/id_ed25519";
    };
    matchBlocks."gitlab.com" = {
      hostname = "gitlab.com";
      user = "git";
      identityFile = "~/.ssh/id_ed25519";
    };
  };
}

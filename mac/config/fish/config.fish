if status is-interactive
    # Homebrew
    eval (/opt/homebrew/bin/brew shellenv)

    set -U fish_greeting ""

    # Tools
    starship init fish | source
    fnm env --use-on-cd --shell fish | source

    # PATH additions
    fish_add_path $HOME/.bun/bin
    fish_add_path $HOME/.opencode/bin
    fish_add_path $HOME/.cargo/bin

    # Env
    set -gx BUN_INSTALL $HOME/.bun
    set -gx ANDROID_HOME $HOME/Library/Android/sdk
    set -gx JAVA_HOME (/usr/libexec/java_home -v 17 2>/dev/null)

    # Aliases
    alias ll "ls -la"
    alias la "ls -la"
    alias gs "git status"
    alias ga "git add"
    alias gc "git commit"
    alias gca "git commit --amend"
    alias gp "git push"
    alias gpl "git pull"
    alias gd "git diff"
    alias gl "git log --oneline --graph --decorate"
    alias ncd "cd ~/nixos-config"
    alias exs "npx expo start"
    alias exc "npx expo start --clear"
    alias expa "npx expo run:android"
    alias expi "npx expo run:ios"
end

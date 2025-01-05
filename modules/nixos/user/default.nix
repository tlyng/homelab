{
    options,
    config,
    pkgs,
    lib,
    namespace,
    ...
}:
with lib;
with lib.${namespace};
let
    cfg = config.${namespace}.user;
in
{
    options.${namespace}.user = with types; {
        name = mkOpt str "guest" "The name to use for the user account.";
        fullName = mkOpt str "Guest Account" "The full name of the user.";
        email = mkOpt str "guest@account.com" "The email of the user.";
        initialPassword = mkOpt str "password" "The initial password to use when the user is first created.";
        extraGroups = mkOpt (listOf str) [ ] "Groups assigned to the user.";
        extraOptions = mkOpt attrs { } (
            mdDoc "Extra options passed to the `users.users.<name>`."
        );
    };

    config = {

        programs.zsh = {
            enable = true;
            # autosuggestion.enable = true;
            histFile = "$XDG_CACHE_HOME/zsh.history";
        };

        homelab.home = {
            file = {
                "Desktop/.keep".text = "";
                "src/github.com/tlyng/.keep".text = "";
                ".p10k.zsh".source = ./p10k-config;
                ".zsh/fzf-git.sh".source = ./fzf-git.sh;
            };

            extraOptions = {
                
                programs.zsh = {
                    enable = true;
                    enableCompletion = true;
                    autosuggestion.enable = true;
                    syntaxHighlighting.enable = true;

                    shellAliases = {
                        cat = "bat";
                        cd = "z";
                    };

                    oh-my-zsh = {
                        enable = true;
                        plugins = ["git" "golang" "kitty"];
                    };

                    plugins = [
                        {
                            name = "powerlevel10k";
                            src = pkgs.zsh-powerlevel10k;
                            file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
                        }
                    ];

                    initExtraFirst = "source ~/.p10k.zsh";

                    initExtra = ''
                        # -- Use fd instead of fzf --

                        show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

                        export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
                        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
                        export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
                        export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
                        export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

                        # Use fd (https://github.com/sharkdp/fd) for listing path candidates.
                        # - The first argument to the function ($1) is the base path to start traversal
                        # - See the source code (completion.{bash,zsh}) for the details.
                        _fzf_compgen_path() {
                            fd --hidden --exclude .git . "$1"
                        }

                        # Use fd to generate the list for directory completion
                        _fzf_compgen_dir() {
                            fd --type=d --hidden --exclude .git . "$1"
                        }

                        # Advanced customization of fzf options via _fzf_comprun function
                        # - The first argument to the function is the name of the command.
                        # - You should make sure to pass the rest of the arguments to fzf.
                        _fzf_comprun() {
                            local command=$1
                            shift

                            case "$command" in
                                cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
                                export|unset) fzf --preview "eval 'echo ''${}'"         "$@" ;;
                                ssh)          fzf --preview 'dig {}'                   "$@" ;;
                                *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
                            esac
                        }

                        source ~/.zsh/fzf-git.sh                                   
                    '';
                };
                catppuccin.zsh-syntax-highlighting.enable = true;
            };
        };

        users.users.${cfg.name} = {
            isNormalUser = true;

            inherit (cfg) name initialPassword;

            home = "/home/${cfg.name}";
            group = "users";

            shell = pkgs.zsh;

            extraGroups = [] ++ cfg.extraGroups;
        } // cfg.extraOptions;
    };
}
 {
    description = "Homelab";

    inputs = {
        # NixPkgs
        nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

        nix-index-database = {
            url = "github:nix-community/nix-index-database";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    
        # Lix
        lix = {
            url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.1.tar.gz";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        # Home-manager
        home-manager = {
            url = "github:nix-community/home-manager/release-24.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        # Run unpatched dynamically compiled binaries
        # nix-ld = {
        #     url = "github:Mic92/nix-ld";
        #     inputs.nixpkgs.follows = "nixpkgs";
        # };

        # Hyprland
        # hyprland = {
        #     url = "github:hyprwm/Hyprland";
        #     # inputs.nixpkgs.follows = "nixpkgs";
        # };

        # hyprland-plugins = {
        #     url = "github:hyprwm/hyprland-plugins";
        #     inputs.hyprland.follows = "hyprland";
        # };

        hyprpanel = {
            url = "github:Jas-SinghFSU/HyprPanel";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        # Catppuccin
        catppuccin = {
            url = "github:catppuccin/nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        # Snowfall lib
        snowfall-lib = {
            url = "github:snowfallorg/lib?ref=v3.0.3";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        # Comma
        comma = {
            url = "github:nix-community/comma";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = inputs: let
        lib = inputs.snowfall-lib.mkLib {
            inherit inputs;
            src = ./.;

            snowfall = {
                meta = {
                    name = "homelab";
                    title = "homelab";
                };

                namespace = "homelab";
            };
        };
    in lib.mkFlake
    {
        channels-config = {
            allowUnfree = true;
        };

        nixpkgs.config.allowUnsupportedSystem = true;
        
        overlays = with inputs; [
            hyprpanel.overlay
        ];

        systems.modules.nixos = with inputs; [
            catppuccin.nixosModules.catppuccin
            home-manager.nixosModules.home-manager

            # nix-ld.nixosModules.nix-ld
        ];
    };
 }
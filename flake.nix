{
  description = "My Doom Emacs configuration with DevShell test environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-doom-emacs-unstraightened.url = "github:marienz/nix-doom-emacs-unstraightened";
    nix-doom-emacs-unstraightened.inputs.nixpkgs.follows = "";
  };

  outputs =
    {
      self,
      nixpkgs,
      nix-doom-emacs-unstraightened,
      ...
    }:
    let
      system = "x86_64-linux"; # 根据你的系统调整
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ nix-doom-emacs-unstraightened.overlays.default ];
      };
      emacs = pkgs.emacs;
      # 1. 定义一个针对当前配置构建的 Emacs 实例
      # nix-doom-emacs-unstraightened 的核心函数可以通过 overlay 获取
      # 或者直接手动调用其内部的构建逻辑
      #my-doom-emacs = pkgs.doomEmacs {
      my-doom-emacs = pkgs.emacsWithDoom {
        doomDir = ./.; # 指向当前仓库根目录
        # 可选：指定 Emacs 版本
        #emacs = pkgs.emacs-pgtk;
        emacs = emacs;
        doomLocalDir = "/fastcache/cache/doomemacs/emacs";
        # 可选：指定额外的二进制依赖
        extraBinPackages = with pkgs; [
          ripgrep
          fd
          # lang:python
          pyright
          ty
          isort
          ruff
          # lang:nix
          nixfmt
          # lang:org +jupyter
          python312Packages.jupyter
          # chinese:
          librime
          rime-data
          brise
        ];
        extraPackages = epkgs: [
          epkgs.treesit-grammars.with-all-grammars
          epkgs.liberime
        ];
      };
    in
    {
      homeModules.default =
        { ... }:
        {
          imports = [ nix-doom-emacs-unstraightened.homeModule ];
          programs.doom-emacs = {
            enable = true;
            doomDir = self;
          };
        };

      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          my-doom-emacs
          bash
          glibcLocales

          binutils
          gnumake
          libgcc

          git
          ripgrep
          gnutls
          rustc

          # for doom
          dockfmt
          plantuml
          nixfmt
          # add plantuml
          # services.plantuml-server.enable = true;
          prettier

          # chinese input
          librime

          # lsp server
          gopls
          astro-language-server
          libclang
          csharp-ls
          cmake-language-server
          nixd
          nil
        ];
        shellHook = ''
          echo "=== Doom Emacs Test Environment ==="
          echo "Run 'doom-emacs' to start your configured Emacs."
          echo "Note: This will use a temporary profile to avoid touching your home config."

          export CPATH="${pkgs.librime}/include"
          export LIBRARY_PATH="${pkgs.librime}/lib"
          export LIBRIME_ROOT="${pkgs.librime}"

          export PS1='[doom] \[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

          export LOCALE_ARCHIVE="${pkgs.glibcLocales}/lib/locale/locale-archive"
          export LC_ALL="en_US.UTF-8"
          alias test-doom='doom-emacs'
        '';
      };

      # 3. 如果你想直接运行测试，也可以导出一个 package
      packages.${system}.default = my-doom-emacs;
    };
}

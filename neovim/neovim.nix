{ lib, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      #nvim-treesitter.withAllGrammars
    ];
  };
  home = {
    file = {
      ".config/nvim/lua".source = ./lua;
      ".config/nvim/init.lua".source = ./init.lua;
      ".config/nvim/.neoconf.json".source = ./.neoconf.json;
      ".config/nvim/stylua.toml".source = ./stylua.toml;
      ".config/tree-sitter".source = ./tree-sitter;
    };

    # dependencies
    packages = with pkgs; [
      fzf
      ripgrep
      fd
      lazygit
      tree-sitter
    ];
  };
}

{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ghc
    cabal-install
    stack
    hpack
    haskell-language-server
  ];
}
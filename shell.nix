{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    mdbook
    mdbook-mermaid
    fish
  ];

  shellHook = ''
    echo "##### Tips #####"
    echo "Start a local server:"
    echo "  mdbook serve (mktemp -d) --open"
    echo "################"
    fish 
    echo "nix shell exited"
    exit 0 # exit bash when the exiting fish shell
  '';
}

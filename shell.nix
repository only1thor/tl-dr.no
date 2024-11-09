{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    mdbook
    mdbook-mermaid
    fish
  ];

  shellHook = ''
    export TMP_DIR=$(mktemp -d)
    echo "##### Tips #####"
    echo "Start a local server:"
    echo "  mdbook serve -d $TMP_DIR --open"
    echo "################"
    fish 
    echo "nix shell exited"
    exit 0 # exit bash when the exiting fish shell
  '';
}

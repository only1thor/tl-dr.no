{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    mdbook
    mdbook-mermaid
  ];

  shellHook = ''
    echo "mdbook serve (mktemp -d)" to start a local server (bulid the book in a temporary directory)"
    echo "add --open to open the browser"
  '';
}

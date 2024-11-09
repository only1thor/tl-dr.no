{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    pandoc
    python3Packages.pygments
  ];

#    export PANDOC_HIGHLIGHT_STYLE=dracula
  shellHook = ''
    
    alias md2html='pandoc index.md -o index.html --template=bootstrap-dark.html -s'

    echo "Pandoc environment loaded with bootstrap-dark theme"
    echo "Use 'md2html' to convert index.md to index.html"
  '';
}

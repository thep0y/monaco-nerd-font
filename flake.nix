{
  description = "A flake for packaging fonts";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    monaco = {
      url = "github:thep0y/monaco-nerd-font";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      monaco,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages = {
          monaco = pkgs.stdenv.mkDerivation {
            pname = "monaco NF";
            version = "0.2.1";
            src = monaco;
            installPhase = ''
              mkdir -p $out/share/fonts/opentype
              find $src -type f -name "*.ttf" -exec cp {} $out/share/fonts/opentype/ \;
            '';
          };
        };

        defaultPackage = self.packages.${system}.monaco;
      }
    );
}

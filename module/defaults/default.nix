{ ... }: {
  imports = [
    # TODO: definitely broken on darwin
    ./plugins.nix

    ./paths.nix
  ];
}

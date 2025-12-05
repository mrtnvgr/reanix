# ReaNix - REAPER configuration system for NixOS

> [!warning]
> Work in progress

## Installation

<details>
<summary>Using flakes</summary>

Add ReaNix to your flake inputs:
```nix
{
  inputs.reanix = {
    url = "github:mrtnvgr/reanix";
    inputs.nixpkgs.follows = "nixpkgs";
  };
}
```

Import ReaNix home-manager module:
```nix
home-manager.users.user = {
  imports = [ inputs.reanix.homeModules.default ];
}
```

</details>

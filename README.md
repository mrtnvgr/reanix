# UNMAINTAINED

I do not use this anymore, feel free to fork :)

Thank you.

<br><br><br><br>

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

Import ReaNix home-manager module and use `programs.reanix`:
```nix
home-manager.users.user = {
  imports = [ inputs.reanix.homeModules.default ];

  programs.reanix = {
    enable = true;

    # Useful settings for better experience
    # (e.g. `turn off update checks`)
    defaults = true;
  };
}
```

</details>

Special thanks:
https://mespotin.uber.space/Ultraschall/Reaper_Config_Variables.html

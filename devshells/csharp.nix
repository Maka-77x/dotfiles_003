{ pkgs, lib, ... }:
{
  packages = lib.attrValues {
    inherit (pkgs)
      dotnet-sdk_8 # Default version is currently too low for Exercism
      omnisharp-roslyn # C# language server
      ;
  };

  # Disable telemetry
  env = [
    {
      name = "DOTNET_CLI_TELEMETRY";
      value = 1;
    }
  ];
}

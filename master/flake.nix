{
  description = ''A Jester web plugin that gets a pooled MongoDB connection for each web query.'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-jestermongopool-master.flake = false;
  inputs.src-jestermongopool-master.owner = "JohnAD";
  inputs.src-jestermongopool-master.ref   = "refs/heads/master";
  inputs.src-jestermongopool-master.repo  = "jestermongopool";
  inputs.src-jestermongopool-master.type  = "github";
  
  inputs."jesterwithplugins".owner = "nim-nix-pkgs";
  inputs."jesterwithplugins".ref   = "master";
  inputs."jesterwithplugins".repo  = "jesterwithplugins";
  inputs."jesterwithplugins".type  = "github";
  inputs."jesterwithplugins".inputs.nixpkgs.follows = "nixpkgs";
  inputs."jesterwithplugins".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  inputs."mongopool".owner = "nim-nix-pkgs";
  inputs."mongopool".ref   = "master";
  inputs."mongopool".repo  = "mongopool";
  inputs."mongopool".type  = "github";
  inputs."mongopool".inputs.nixpkgs.follows = "nixpkgs";
  inputs."mongopool".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-jestermongopool-master"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-jestermongopool-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}
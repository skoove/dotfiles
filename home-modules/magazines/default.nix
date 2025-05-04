{ ... }:
{
  programs.fish.functions = {
  # function to interact with magazines!
    mag = {
      body = builtins.readFile ./magazines.fish;
    };
  };
}

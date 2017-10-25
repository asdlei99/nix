with import ./config.nix;

mkDerivation {
  name = "structured";

  __structuredAttrs = true;

  buildCommand = ''
    set -x

    [[ $int = 123456789 ]]
    [[ -z $float ]]
    [[ -n $boolTrue ]]
    [[ -z $boolFalse ]]
    [[ -n ''${hardening[format]} ]]
    [[ -z ''${hardening[fortify]} ]]
    [[ ''${#buildInputs[@]} = 7 ]]
    [[ ''${buildInputs[2]} = c ]]
    [[ -v nothing ]]
    [[ -z $nothing ]]

    mkdir ''${outputs[out]}
    echo bar > $dest
  '';

  buildInputs = [ "a" "b" "c" 123 "'" "\"" null ];

  hardening.format = true;
  hardening.fortify = false;

  outer.inner = [ 1 2 3 ];

  int = 123456789;

  float = 123.456;

  boolTrue = true;
  boolFalse = false;

  nothing = null;

  dest = "${placeholder "out"}/foo";

  "foo bar" = "BAD";
  "1foobar" = "BAD";
  "foo$" = "BAD";
}

module
import Reference

/-! Unused conflicting definitions must not change a literal approved input. -/

initialize do
  try
    IO.FS.writeFile "../evaluator/reference.export" "tampered during compilation"
    IO.eprintln "protected-write-succeeded: compilation"
  catch _ => IO.eprintln "protected-write-denied: compilation"

public theorem success (_ : forall n : Nat, n + n = 2 * n) : True := True.intro

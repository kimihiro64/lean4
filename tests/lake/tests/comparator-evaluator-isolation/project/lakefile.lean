import Lake
open Lake DSL

/-! Attempt tampering during configuration loading, before solution compilation. -/

def attemptTampering : Unit := run_io do
  for name in ["config.json", "accepted.json", "reference.export"] do
    let path := "../evaluator/" ++ name
    try
      IO.FS.writeFile path "tampered"
      IO.eprintln s!"protected-write-succeeded: {name}"
    catch _ => IO.eprintln s!"protected-write-denied: {name}"
  if <- System.FilePath.pathExists ".lake/poison" then
    throw <| IO.userError "submission cache was visible"
  -- The host fixture makes this a hard link to the reference. Fresh storage hides it.
  IO.FS.writeFile ".lake/reference-link" "private build output"
  IO.eprintln "private-build-write-succeeded"

package submission
lean_lib Reference
lean_lib Good
lean_lib AliasSpoof
lean_lib TargetSpoof
lean_lib Extra

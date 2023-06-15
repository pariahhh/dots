{ file }:
if tryEval (import file).success then
  import file;
else
  throw "Failed to import file";
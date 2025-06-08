program backup_cli;

{$mode ObjFPC}{$H+}

uses
  SysUtils, BackupConfig, SnapshotLogic;

begin
  LoadConfig('../data/backup.ini');

  if ParamCount = 0 then
  begin
    WriteLn('Usage: backup_cli --backup | --list | --delete <name>');
    Halt(1);
  end;

  case ParamStr(1) of
    '--help': WriteLn('Use: --backup, --list, --delete <name>');
    '--backup': CreateSnapshot;
    '--list': ListSnapshots;
    '--delete':
      if ParamCount > 1 then
        DeleteSnapshot(ParamStr(2))
      else
        WriteLn('Missing snapshot name.');
  else
    WriteLn('Unknown command. Use --help.');
  end;
end.


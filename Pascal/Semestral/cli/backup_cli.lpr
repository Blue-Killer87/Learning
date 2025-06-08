program backup_cli;

{$mode ObjFPC}{$H+}

uses
  SysUtils, BackupConfig, SnapshotLogic;

procedure ShowHelp;
begin
  WriteLn('BackupTool CLI');
  WriteLn('Usage:');
  WriteLn('  --backup                     Create a snapshot');
  WriteLn('  --list                       List existing snapshots');
  WriteLn('  --delete <name>              Delete snapshot by name');
  WriteLn('  --source <path1> [path2...]  Add source(s) to config');
  WriteLn('  --delsource <path1> [...]    Remove source(s)');
  WriteLn('  --dest <path>                Set destination (asks before overwrite)');
  WriteLn('  --config                     Show current config');
  WriteLn('  --help                       Show this help');
end;

const
  CONFIG_PATH = '../data/backup.ini';

var
  i: Integer;
  Args: array of String;
begin
  LoadConfig(CONFIG_PATH);

  if ParamCount = 0 then
  begin
    ShowHelp;
    Halt(0);
  end;

  case ParamStr(1) of
    '--help': ShowHelp;
    '--backup': CreateSnapshot;
    '--list': ListSnapshots;
    '--delete':
      if ParamCount > 1 then
        DeleteSnapshot(ParamStr(2))
      else
        WriteLn('Missing snapshot name.');
    '--source':
      begin
        if ParamCount < 2 then
        begin
          WriteLn('Provide at least one source path.');
          Halt(1);
        end;
        SetLength(Args, ParamCount - 1);
        for i := 2 to ParamCount do
          Args[i - 2] := ParamStr(i);
        AddSources(CONFIG_PATH, Args);
      end;
    '--delsource':
      begin
        if ParamCount < 2 then
        begin
          WriteLn('Provide source(s) to remove.');
          Halt(1);
        end;
        SetLength(Args, ParamCount - 1);
        for i := 2 to ParamCount do
          Args[i - 2] := ParamStr(i);
        RemoveSources(CONFIG_PATH, Args);
      end;
    '--dest':
      begin
        if ParamCount <> 2 then
        begin
          WriteLn('Usage: --dest <destination path>');
          Halt(1);
        end;
        SetDestination(CONFIG_PATH, ParamStr(2));
      end;
    '--config': ShowConfig;
  else
    WriteLn('Unknown command. Use --help.');
  end;
end.


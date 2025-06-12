unit SnapshotLogic;

{$mode ObjFPC}{$H+}

interface

uses
   SysUtils, Classes, BackupConfig, Unix;

procedure CreateSnapshot;
procedure ListSnapshots;
procedure DeleteSnapshot(const Name: String);
function GetSnapshotList: TStringList;


implementation

function NowAsTimestamp: String;
begin
  Result := FormatDateTime('yyyymmdd_hhnnss', Now);
end;

procedure CreateSnapshot;
var
  SnapName, SnapDir, Src, Cmd: String;
  i: Integer;
begin
  if DestinationDir = '' then
  begin
    WriteLn('No destination set!');
    Exit;
  end;

  SnapName := 'snapshot_' + NowAsTimestamp;
  SnapDir := IncludeTrailingPathDelimiter(DestinationDir) + SnapName;

  if not DirectoryExists(DestinationDir) then
    CreateDir(DestinationDir);
  if not CreateDir(SnapDir) then
  begin
    WriteLn('Failed to create snapshot directory.');
    Exit;
  end;

  for i := 0 to High(SourceDirs) do
  begin
    Src := ExcludeTrailingPathDelimiter(SourceDirs[i]);
    Cmd := Format('cp -r "%s" "%s"', [Src, SnapDir]);
    if fpSystem(PChar(Cmd)) <> 0 then
      WriteLn('Failed to copy: ', Src);
  end;

  WriteLn('Snapshot created: ', SnapName);
end;

procedure ListSnapshots;
var
  SR: TSearchRec;
begin
  if FindFirst(IncludeTrailingPathDelimiter(DestinationDir) + '*', faDirectory, SR) = 0 then
  repeat
    if (SR.Attr and faDirectory) <> 0 then
    begin
      if (SR.Name <> '.') and (SR.Name <> '..') and (Pos('snapshot_', SR.Name) = 1) then
        WriteLn(SR.Name);
    end;
  until FindNext(SR) <> 0;
  FindClose(SR);
end;

procedure DeleteSnapshot(const Name: String);
var
  FullPath: String;
begin
  FullPath := IncludeTrailingPathDelimiter(DestinationDir) + Name;
  if not DirectoryExists(FullPath) then
  begin
    WriteLn('Snapshot not found: ', Name);
    Exit;
  end;

  if fpSystem(PChar('rm -rf "' + FullPath + '"')) = 0 then
    WriteLn('Deleted snapshot: ', Name)
  else
    WriteLn('Failed to delete: ', Name);
end;

function GetSnapshotList: TStringList;
var
  SR: TSearchRec;
  SnapList: TStringList;
begin
  SnapList := TStringList.Create;

  if not DirectoryExists(DestinationDir) then
  begin
    Result := SnapList;
    Exit;
  end;

  if FindFirst(IncludeTrailingPathDelimiter(DestinationDir) + '*', faDirectory, SR) = 0 then
  begin
    repeat
      if (SR.Attr and faDirectory) <> 0 then
      begin
        if (SR.Name <> '.') and (SR.Name <> '..') and (Pos('snapshot_', SR.Name) = 1) then
          SnapList.Add(SR.Name);
      end;
    until FindNext(SR) <> 0;
    FindClose(SR);
  end;

  Result := SnapList;
end;


end.


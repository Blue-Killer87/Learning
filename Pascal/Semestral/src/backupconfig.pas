unit BackupConfig;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, IniFiles;

var
  SourceDirs: array of String;
  DestinationDir: String;

procedure LoadConfig(const FileName: String);
procedure SaveConfig(const FileName: String);
procedure AddSources(const FileName: String; const NewSources: array of String);
procedure RemoveSources(const FileName: String; const ToRemove: array of String);
procedure SetDestination(const FileName, NewDest: String);
procedure ShowConfig;

implementation

const
  SECTION = 'Backup';

procedure LoadConfig(const FileName: String);
var
  Ini: TIniFile;
  Parts: TStringList;
  i: Integer;
begin
  Ini := TIniFile.Create(FileName);
  try
    DestinationDir := Ini.ReadString(SECTION, 'destination', '');

    Parts := TStringList.Create;
    try
      Parts.Delimiter := ';';
      Parts.StrictDelimiter := True;
      Parts.DelimitedText := Ini.ReadString(SECTION, 'sources', '');
      SetLength(SourceDirs, Parts.Count);
      for i := 0 to Parts.Count - 1 do
        SourceDirs[i] := Trim(Parts[i]);
    finally
      Parts.Free;
    end;
  finally
    Ini.Free;
  end;
end;

procedure SaveConfig(const FileName: String);
var
  Ini: TIniFile;
  i: Integer;
  SourcesJoined: String;
begin
  Ini := TIniFile.Create(FileName);
  try
    SourcesJoined := '';
    for i := 0 to High(SourceDirs) do
    begin
      if SourcesJoined <> '' then
        SourcesJoined := SourcesJoined + ';';
      SourcesJoined := SourcesJoined + SourceDirs[i];
    end;
    Ini.WriteString(SECTION, 'sources', SourcesJoined);
    Ini.WriteString(SECTION, 'destination', DestinationDir);
    Ini.UpdateFile;
  finally
    Ini.Free;
  end;
end;

procedure AddSources(const FileName: String; const NewSources: array of String);
var
  i, j: Integer;
  Exists: Boolean;
begin
  for i := 0 to High(NewSources) do
  begin
    Exists := False;
    for j := 0 to High(SourceDirs) do
      if SourceDirs[j] = NewSources[i] then
        Exists := True;
    if not Exists then
    begin
      SetLength(SourceDirs, Length(SourceDirs) + 1);
      SourceDirs[High(SourceDirs)] := NewSources[i];
      WriteLn('Added source: ', NewSources[i]);
    end
    else
      WriteLn('Already exists: ', NewSources[i]);
  end;
  SaveConfig(FileName);
end;

procedure RemoveSources(const FileName: String; const ToRemove: array of String);
var
  NewList: array of String;
  i, j: Integer;
  Found: Boolean;
begin
  SetLength(NewList, 0);
  for i := 0 to High(SourceDirs) do
  begin
    Found := False;
    for j := 0 to High(ToRemove) do
      if SourceDirs[i] = ToRemove[j] then
        Found := True;
    if not Found then
    begin
      SetLength(NewList, Length(NewList) + 1);
      NewList[High(NewList)] := SourceDirs[i];
    end
    else
      WriteLn('Removed: ', SourceDirs[i]);
  end;
  SourceDirs := NewList;
  SaveConfig(FileName);
end;

procedure SetDestination(const FileName, NewDest: String);
var
  Answer: String;
begin
  if (DestinationDir <> '') and (DestinationDir <> NewDest) then
  begin
    Write('Current destination is "', DestinationDir, '". Overwrite? [y/N]: ');
    ReadLn(Answer);
    if LowerCase(Trim(Answer)) <> 'y' then
    begin
      WriteLn('Destination not changed.');
      Exit;
    end;
  end;
  DestinationDir := NewDest;
  SaveConfig(FileName);
  WriteLn('Destination set to: ', NewDest);
end;

procedure ShowConfig;
var
  i: Integer;
begin
  WriteLn('=============================');
  WriteLn(' Current Backup Configuration');
  WriteLn('=============================');
  WriteLn('Sources:');
  for i := 0 to High(SourceDirs) do
    WriteLn('  - ', SourceDirs[i]);
  if DestinationDir <> '' then
    WriteLn('Destination:', #10'  ', DestinationDir)
  else
    WriteLn('Destination: (not set)');
  WriteLn('=============================');
end;

end.


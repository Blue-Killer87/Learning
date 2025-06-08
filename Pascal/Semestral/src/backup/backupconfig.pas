unit BackupConfig;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, IniFiles;

var
  SourceDirs: array of String;
  DestinationDir: String;

procedure LoadConfig(const FileName: String);

implementation

procedure SplitString(const S: String; Delimiter: Char; out ResultArray: array of String);
var
  i, Count: Integer;
  TempStr: String;
begin
  Count := 0;
  TempStr := '';
  for i := 1 to Length(S) do
  begin
    if S[i] = Delimiter then
    begin
      if Count < Length(ResultArray) then
      begin
        ResultArray[Count] := TempStr;
        Inc(Count);
      end;
      TempStr := '';
    end
    else
      TempStr := TempStr + S[i];
  end;
  if TempStr <> '' then
    if Count < Length(ResultArray) then
      ResultArray[Count] := TempStr;
end;

procedure LoadConfig(const FileName: String);
var
  Ini: TIniFile;
  RawSources: String;
  Parts: TStringList;
  i: Integer;
begin
  Ini := TIniFile.Create(FileName);
  try
    RawSources := Ini.ReadString('Backup', 'sources', '');
    DestinationDir := Ini.ReadString('Backup', 'destination', '');

    Parts := TStringList.Create;
    try
      Parts.Delimiter := ';';
      Parts.StrictDelimiter := True;
      Parts.DelimitedText := RawSources;

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

end.


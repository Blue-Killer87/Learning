unit MainForm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  BackupConfig, SnapshotLogic;

type
  { TFormMain }

  TFormMain = class(TForm)
    BtnAddSource: TButton;
    BtnRemoveSource: TButton;
    BtnSetDest: TButton;
    BtnSnapshot: TButton;
    ListSnapshots: TListBox;
    MemoInfo: TMemo;
    procedure BtnAddSourceClick(Sender: TObject);
    procedure BtnRemoveSourceClick(Sender: TObject);
    procedure BtnSetDestClick(Sender: TObject);
    procedure BtnSnapshotClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListSnapshotsClick(Sender: TObject);
  private
    //procedure RefreshSnapshotList;
    procedure RefreshInfo;
  public

  end;

var
  FormMain: TFormMain;
  ConfigPath: String = '../data/backup.ini';

implementation

{$R *.lfm}

uses
  FileUtil, IniFiles, Process;

{ TFormMain }

procedure TFormMain.FormCreate(Sender: TObject);
begin
  LoadConfig(ConfigPath);
  //RefreshSnapshotList;
  RefreshInfo;
end;

{
procedure TFormMain.RefreshSnapshotList;
var
  Snapshots: TStringList;
  i: Integer;
begin
  ListSnapshots.Items.Clear;
  Snapshots := TStringList.Create;
  try
    GetSnapshotList(Snapshots);
    for i := 0 to Snapshots.Count - 1 do
      ListSnapshots.Items.Add(Snapshots[i]);
  finally
    Snapshots.Free;
  end;
end;   }

procedure TFormMain.RefreshInfo;
var
  i: Integer;
begin
  MemoInfo.Clear;
  MemoInfo.Lines.Add('Sources:');
  for i := 0 to High(SourceDirs) do
    MemoInfo.Lines.Add('  ' + SourceDirs[i]);
  MemoInfo.Lines.Add('');
  MemoInfo.Lines.Add('Destination:');
  MemoInfo.Lines.Add('  ' + DestinationDir);
end;

procedure TFormMain.BtnAddSourceClick(Sender: TObject);
var
  Dir: String;
begin
  if SelectDirectory('Select Source Directory', '', Dir) then
  begin
    AddSources(ConfigPath, [Dir]);
    LoadConfig(ConfigPath);
    RefreshInfo;
  end;
end;

procedure TFormMain.BtnRemoveSourceClick(Sender: TObject);
var
  Dir: String;
begin
  if InputQuery('Remove Source', 'Enter exact source path to remove:', Dir) then
  begin
    RemoveSources(ConfigPath, [Dir]);
    LoadConfig(ConfigPath);
    RefreshInfo;
  end;
end;

procedure TFormMain.BtnSetDestClick(Sender: TObject);
var
  Dir: String;
begin
  if SelectDirectory('Select Destination Directory', '', Dir) then
  begin
    SetDestination(ConfigPath, Dir);
    LoadConfig(ConfigPath);
    RefreshInfo;
  end;
end;

procedure TFormMain.BtnSnapshotClick(Sender: TObject);
begin
  CreateSnapshot;
  //RefreshSnapshotList;
end;

procedure TFormMain.ListSnapshotsClick(Sender: TObject);
var
  Selected: String;
begin
  if ListSnapshots.ItemIndex >= 0 then
  begin
    Selected := ListSnapshots.Items[ListSnapshots.ItemIndex];
    if MessageDlg('Delete snapshot "' + Selected + '"?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      DeleteSnapshot(Selected);
      //RefreshSnapshotList;
    end;
  end;
end;

end.


unit MainForm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ComCtrls, Menus, BackupConfig, SnapshotLogic, FileUtil, Process;

type

  { TFormMain }

TFormMain = class(TForm)
    MainMenu1: TMainMenu;
    BtnSetDest: TMenuItem;
    BtnSnapshot: TMenuItem;
    Help: TMenuItem;
    BtnAddSource: TMenuItem;
    BtnRemoveSource: TMenuItem;
    Source: TMenuItem;
    ProgressBar: TProgressBar;
    SourceDestLabel: TLabel;
    SnapshotLabel: TLabel;
    ListLog: TListBox;
    ListSnapshots: TListBox;
    MemoInfo: TMemo;
    PopupRemoveSources: TPopupMenu;
    PopupListSnapshots: TPopupMenu;

    procedure BtnAddSourceClick(Sender: TObject);
    procedure BtnRemoveSourceClick(Sender: TObject);
    procedure BtnSetDestClick(Sender: TObject);
    procedure BtnSnapshotClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ListSnapshotsClick(Sender: TObject);
    procedure RemoveSnapshot(Sender: TObject);
  private
    procedure RefreshSnapshotList;
    procedure SetProgress(Percent: Integer);
    procedure OnRemoveSourceClick(Sender: TObject);

  public
    procedure RefreshInfo;
    procedure LogMessage(const Msg: String);
  end;

var
  FormMain: TFormMain;
  ConfigPath: String = '../data/backup.ini';

implementation

{$R *.lfm}

{ TFormMain }

procedure TFormMain.FormCreate(Sender: TObject);
begin
  PopupRemoveSources := TPopupMenu.Create(Self);
  PopupListSnapshots := TPopupMenu.Create(self);
  LoadConfig(ConfigPath);
  RefreshSnapshotList;
  RefreshInfo;
  FormResize(Self);

end;


procedure TFormMain.RefreshSnapshotList;
var
  Snapshots: TStringList;
  i: Integer;
begin
  ListSnapshots.Items.Clear;
  Snapshots := GetSnapshotList;
  try
    for i := 0 to Snapshots.Count - 1 do
      ListSnapshots.Items.Add(Snapshots[i]);
  finally
    Snapshots.Free;
  end;
end;

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

procedure TFormMain.LogMessage(const Msg: String);
begin
  ListLog.Items.Add(FormatDateTime('hh:nn:ss', Now) + ' - ' + Msg);
end;

procedure TFormMain.SetProgress(Percent: Integer);
begin
  ProgressBar.Position := Percent;
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
    LogMessage('Added source: ' + Dir);
  end;
end;

procedure TFormMain.BtnRemoveSourceClick(Sender: TObject);
var
  i: Integer;
  Item, LabelItem, Separator: TMenuItem;
begin
  PopupRemoveSources.Items.Clear;

  if Length(SourceDirs) = 0 then
  begin
    ShowMessage('No sources to remove.');
    Exit;
  end;

  LabelItem := TMenuItem.Create(PopupRemoveSources);
  LabelItem.Caption := 'Chose a source to remove:';
  Separator := TMenuitem.Create(PopupRemoveSources);
  PopupRemoveSources.Items.Add(LabelItem);
  PopupRemoveSources.Items.Add(Separator);

  for i := 0 to High(SourceDirs) do
  begin
    Item := TMenuItem.Create(PopupRemoveSources);
    Item.Caption := SourceDirs[i];
    Item.OnClick := @OnRemoveSourceClick;
    PopupRemoveSources.Items.Add(Item);
  end;

  PopupRemoveSources.PopUp(Mouse.CursorPos.X, Mouse.CursorPos.Y);
end;

procedure TFormMain.OnRemoveSourceClick(Sender: TObject);
var
  Dir: String;
begin
  Dir := (Sender as TMenuItem).Caption;
  RemoveSources(ConfigPath, [Dir]);
  LoadConfig(ConfigPath);
  RefreshInfo;
  LogMessage('Removed source: ' + Dir);
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
    LogMessage('Destination set to: ' + Dir);
  end;
end;

procedure TFormMain.BtnSnapshotClick(Sender: TObject);
var
  i, Total: Integer;
begin
  ProgressBar.Visible:=True;
  LogMessage('Creating snapshot...');
  SetProgress(0);

  Total := Length(SourceDirs);
  if Total > 0 then
  begin
    for i := 0 to Total - 1 do
    begin
      LogMessage('Saving source: ' + SourceDirs[i]);
      Sleep(200);
      SetProgress(Round((i) / Total * 100));
    end;
  end;

  CreateSnapshot;
  LogMessage('Snapshot completed.');
  SetProgress(100);
  sleep(500);
  ProgressBar.Visible:=False;
  RefreshSnapshotList;
end;

procedure TFormMain.RemoveSnapshot(Sender: TObject);
var
  Selected: String;
begin
    if ListSnapshots.ItemIndex >= 0 then
  begin
    Selected := ListSnapshots.Items[ListSnapshots.ItemIndex];

    if MessageDlg('Delete snapshot "' + Selected + '"?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      DeleteSnapshot(Selected);
      LogMessage('Deleted snapshot: ' + Selected);
      RefreshSnapshotList;
    end;
  end;
end;


procedure TFormMain.ListSnapshotsClick(Sender: TObject);
var
  PopDeleteSnapshot, PopFolderSnapshot: TMenuItem;
begin
  PopupRemoveSources.Items.Clear;

  PopDeleteSnapshot := TMenuItem.Create(PopupListSnapshots);
  PopFolderSnapshot := TMenuItem.Create(PopupListSnapshots);
  PopDeleteSnapshot.caption := 'Delete Snapshot';
  PopFolderSnapshot.caption := 'Open in folder';
  PopDeleteSnapshot.OnClick := @RemoveSnapshot;
  PopupRemoveSources.Items.Add(PopDeleteSnapshot);
  PopupRemoveSources.Items.Add(PopFolderSnapshot);
  PopupRemoveSources.PopUp(Mouse.CursorPos.X, Mouse.CursorPos.Y);
end;

procedure TFormMain.FormResize(Sender: TObject);
begin
  if MemoInfo.Visible then
    SourceDestLabel.Left := MemoInfo.Left + (MemoInfo.Width div 2) - (SourceDestLabel.Width div 2);

  if ListSnapshots.Visible then
    SnapshotLabel.Left := ListSnapshots.Left + (ListSnapshots.Width div 2) - (SnapshotLabel.Width div 2);
end;

end.

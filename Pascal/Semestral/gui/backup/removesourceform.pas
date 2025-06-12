unit RemoveSourceForm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls;

type

  { TFormRemoveSource }

  TFormRemoveSource = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure RefreshSourceButtons;
    procedure RemoveSource(Sender: TObject);
  private
    PanelSources: TScrollBox;
  public
    procedure ShowSources;
  end;

var
  FormRemoveSource: TFormRemoveSource;

implementation

uses BackupConfig, MainForm;

{$R *.lfm}

{ TFormRemoveSource }

procedure TFormRemoveSource.FormCreate(Sender: TObject);
begin
  Caption := 'Remove Source';
  Width := 400;
  Height := 300;
  Position := poScreenCenter;

  PanelSources := TScrollBox.Create(Self);
  PanelSources.Parent := Self;
  PanelSources.Align := alClient;
  PanelSources.BorderStyle := bsNone;

  ShowSources;
end;

procedure TFormRemoveSource.ShowSources;
begin
  RefreshSourceButtons;
end;

procedure TFormRemoveSource.RefreshSourceButtons;
var
  i: Integer;
  lbl: TLabel;
  btn: TButton;
begin
  for i := PanelSources.ControlCount - 1 downto 0 do
    PanelSources.Controls[i].Free;

  for i := 0 to High(SourceDirs) do
  begin
    lbl := TLabel.Create(PanelSources);
    lbl.Parent := PanelSources;
    lbl.Caption := SourceDirs[i];
    lbl.Top := i * 30 + 5;
    lbl.Left := 8;
    lbl.Width := 280;

    btn := TButton.Create(PanelSources);
    btn.Parent := PanelSources;
    btn.Caption := '❌';
    btn.Tag := i;
    btn.Top := lbl.Top - 2;
    btn.Left := 300;
    btn.Width := 30;
    btn.Height := 25;
    btn.OnClick := @RemoveSource;
  end;
end;

procedure TFormRemoveSource.RemoveSource(Sender: TObject);
var
  idx: Integer;
begin
  idx := (Sender as TButton).Tag;
  if idx >= 0 then
  begin
    RemoveSources(ConfigPath, [SourceDirs[idx]]);
    LoadConfig(ConfigPath);
    FormMain.RefreshInfo;
    FormMain.LogMessage('Removed source: ' + SourceDirs[idx]);
    ModalResult := mrOk;
  end;
end;

end.


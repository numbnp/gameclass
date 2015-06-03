{*******************************************************}
{                                                       }
{                       EhLib v7.0                      }
{                  TSQLEditFrame frame                  }
{                    (Build 7.0.00)                     }
{                                                       }
{     Copyright (c) 2005-12 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit SQLEditFrameEh;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGridEh, ExtCtrls, StdCtrls, ComCtrls, ImgList, Buttons,
{$IFDEF EH_LIB_6}
  Variants,
{$ENDIF}
  DB, MemTableEh, DataDriverEh, GridsEh, MemTableDataEh, StdActns, ActnList,
  DBGridEhGrouping, DBGridEhToolCtrls, ToolCtrlsEh, DBAxisGridsEh,
  DynVarsEh;

type
  TSQLEditFrame = class(TFrame)
    Panel1: TPanel;
    Splitter2: TSplitter;
    Panel4: TPanel;
    RichEdit1: TRichEdit;
    Panel5: TPanel;
    Button3: TButton;
    Check: TButton;
    Button1: TButton;
    Panel3: TPanel;
    gridParams: TDBGridEh;
    ImageList2: TImageList;
    Panel8: TPanel;
    SpeedButton2: TSpeedButton;
    dsParams: TDataSource;
    mtParams: TMemTableEh;
    mtParamsParName: TStringField;
    mtParamsParType: TStringField;
    mtParamsParValue: TStringField;
    ActionList1: TActionList;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    EditSelectAll1: TEditSelectAll;
    ImageList1: TImageList;
    spCut: TSpeedButton;
    sbCopy: TSpeedButton;
    spPaste: TSpeedButton;
    sbSelectAll: TSpeedButton;
    mtParamsParVarValue: TVariantField;
    Panel2: TPanel;
    sbRefresh: TSpeedButton;
    procedure SpeedButton2Click(Sender: TObject);
    procedure gridParamsColumns0UpdateData(Sender: TObject; var Text: string;
      var Value: Variant; var UseText, Handled: Boolean);
    procedure gridParamsColumns2UpdateData(Sender: TObject; var Text: string;
      var Value: Variant; var UseText, Handled: Boolean);
    procedure sbRefreshClick(Sender: TObject);
  private
    FCommand: TCustomSQLCommandEh;
    procedure SetCommand(const Value: TCustomSQLCommandEh);
    { Private declarations }
  public
    Panel3Width: Integer;
    procedure Created;
    procedure RefreshFromCommand;
    procedure PutToCommand;
    procedure AssignToDesignControls(Command: TCustomSQLCommandEh);
    property Command: TCustomSQLCommandEh read FCommand write SetCommand;
  end;

implementation

uses
  SQLDriverEditEh;

var
  DataTypeNames :array [TFieldType] of String = (
    'ftUnknown', 'ftString', 'ftSmallint', 'ftInteger', 'ftWord',
    'ftBoolean', 'ftFloat', 'ftCurrency', 'ftBCD', 'ftDate', 'ftTime', 'ftDateTime',
    'ftBytes', 'ftVarBytes', 'ftAutoInc', 'ftBlob', 'ftMemo', 'ftGraphic', 'ftFmtMemo',
    'ftParadoxOle', 'ftDBaseOle', 'ftTypedBinary', 'ftCursor', 'ftFixedChar', 'ftWideString',
    'ftLargeint', 'ftADT', 'ftArray', 'ftReference', 'ftDataSet', 'ftOraBlob', 'ftOraClob',
    'ftVariant', 'ftInterface', 'ftIDispatch', 'ftGuid'
{$IFDEF EH_LIB_6},  'ftTimeStamp', 'ftFMTBcd'{$ENDIF}
{$IFDEF EH_LIB_10},  'ftFixedWideChar', 'ftWideMemo', 'ftOraTimeStamp', 'ftOraInterval'{$ENDIF}
{$IFDEF EH_LIB_12}, 'ftLongWord', 'ftShortint', 'ftByte', 'ftExtended', 'ftConnection', 'ftParams', 'ftStream' {$ENDIF}
{$IFDEF EH_LIB_13}, 'ftTimeStampOffset', 'ftObject', 'ftSingle' {$ENDIF}
    );

{$R *.dfm}

procedure TSQLEditFrame.AssignToDesignControls(Command: TCustomSQLCommandEh);
var
  i: Integer;
  Params: TParams;
begin
  mtParams.EmptyTable;
  RichEdit1.Lines.Text := Command.CommandText.Text;
//  Params := TParams.Create;
  Params := Command.GetParams;//(Params);
  try
    for i := 0 to Params.Count-1 do
    begin
      mtParams.AppendRecord(
        [Params[i].Name,
         DataTypeNames[Params[i].DataType],
         Params[i].Text
        ]);
    end;
  finally
//    Params.Free;
  end;
end;

procedure TSQLEditFrame.Created;
var
  I: Integer;
  fi: TFieldType;
begin
  for i := 0 to gridParams.Columns.Count - 1 do
    gridParams.Columns[i].OnUpdateData := gridParamsColumns0UpdateData;

  gridParams.FieldColumns['ParValue'].OnUpdateData := gridParamsColumns2UpdateData;

  gridParams.FieldColumns['ParType'].PickList.Clear;
  for fi := Low(TFieldType) to High(TFieldType) do
    gridParams.FieldColumns['ParType'].PickList.Add(DataTypeNames[fi]);

  sbRefresh.OnClick := sbRefreshClick;
end;

procedure TSQLEditFrame.gridParamsColumns0UpdateData(Sender: TObject;
  var Text: string; var Value: Variant; var UseText, Handled: Boolean);
begin
  (Sender as TColumnEh).Field.DataSet.Edit;
  (Sender as TColumnEh).Field.Text := Text;
  (Sender as TColumnEh).Field.DataSet.Post;
  Handled := True;
end;

procedure TSQLEditFrame.gridParamsColumns2UpdateData(Sender: TObject;
  var Text: string; var Value: Variant; var UseText, Handled: Boolean);
var
  nv: Variant;
begin
  (Sender as TColumnEh).Field.DataSet.Edit;
  if Text = '' then
    mtParams['ParVarType'] := Unassigned
  else if VarToStr(mtParams['ParType']) <> '' then
  begin
    VarCast(nv, Text, FieldTypeToVarType(GetDataTypeByName(mtParams['ParType'])));
    mtParams['ParVarValue'] := nv;
    Text := VarToStr(nv);
  end;
  (Sender as TColumnEh).Field.Text := Text;
  (Sender as TColumnEh).Field.DataSet.Post;
  Handled := True;
end;

procedure TSQLEditFrame.PutToCommand;
(*var
  i: Integer;*)
begin
(*  if Command <> nil then
  begin
    Command.CommandText.Text := RichEdit1.Lines.Text;
    Command.Params.Clear;
    for i := 1 to mtParams.RecordCount do
    begin
      mtParams.RecNo := i;
      Command.Params.CreateParam(
        ftString, mtParams['ParName'], ptInput).Text := VarToStr(mtParams['ParValue']);
    end;
  end;*)
end;

procedure TSQLEditFrame.RefreshFromCommand;
begin

end;

procedure TSQLEditFrame.SetCommand(const Value: TCustomSQLCommandEh);
begin
  FCommand := Value;
end;

procedure TSQLEditFrame.SpeedButton2Click(Sender: TObject);
begin
  Panel1.DisableAlign;
  try
    if Panel3Width > 0 then
    begin
      Panel3.Left := Panel3.Left + (Panel3.Width - Panel3Width);
      Panel3.Width := Panel3Width;
      Panel3Width := -1;
    end else
    begin
      Panel3Width := Panel3.Width;
      Panel3.Left := Panel3.Left + Panel3.Width;
      Panel3.Width := 0;
    end;
  finally
    Panel1.EnableAlign;
  end;
end;

procedure TSQLEditFrame.sbRefreshClick(Sender: TObject);
var
  DataEditWin: TSQLDataEditWin;
begin
  DataEditWin := TSQLDataEditWin(GetParentForm(Self));
  DataEditWin.AssignControlsDataToDesignDriver;
  Command.CommandText.Text := RichEdit1.Lines.Text;
  DataEditWin.DDEditInteractor.RefreshParams(Command, DataEditWin);
  DataEditWin.AssignDesignDriverToControls;
end;

end.

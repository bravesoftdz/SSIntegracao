unit UCadContabil_Ope_Lacto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, ExtCtrls, UDMCadContabil_Ope, StdCtrls,
  Buttons, RxLookup, DBCtrls, DB, Mask, RxDBComb, ToolEdit, RXDBCtrl, Grids, DBVGrids,
  RzPanel;

type
  TfrmCadContabil_Ope_Lacto = class(TForm)
    Panel3: TPanel;
    BitBtn4: TBitBtn;
    BitBtn1: TBitBtn;
    Panel2: TPanel;
    Label5: TLabel;
    RxDBComboBox1: TRxDBComboBox;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    RxDBComboBox2: TRxDBComboBox;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    RzGroupBox1: TRzGroupBox;
    Label6: TLabel;
    ComboBox1: TComboBox;
    DBMemo1: TDBMemo;
    BitBtn2: TBitBtn;
    RzGroupBox2: TRzGroupBox;
    Label7: TLabel;
    ComboBox2: TComboBox;
    DBMemo2: TDBMemo;
    BitBtn3: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
  private
    { Private declarations }
    function  fnc_Erro: Boolean;
    procedure prc_Gravar_Historico;
    procedure prc_Grava_Valor;

  public
    { Public declarations }
    fDMCadContabil_Ope: TDMCadContabil_Ope;

  end;

var
  frmCadContabil_Ope_Lacto: TfrmCadContabil_Ope_Lacto;

implementation

uses rsDBUtils, uUtilPadrao, StrUtils;

{$R *.dfm}

procedure TfrmCadContabil_Ope_Lacto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if fDMCadContabil_Ope.cdsContabil_Ope_Lacto.State in [dsEdit,dsInsert] then
    fDMCadContabil_Ope.cdsContabil_Ope_Lacto.Cancel;
  Action := Cafree;
end;

procedure TfrmCadContabil_Ope_Lacto.FormShow(Sender: TObject);
begin
  oDBUtils.SetDataSourceProperties(Self, fDMCadContabil_Ope);
end;

procedure TfrmCadContabil_Ope_Lacto.BitBtn1Click(Sender: TObject);
begin
  if not(fDMCadContabil_Ope.cdsContabil_Ope_Lacto.State in [dsEdit,dsInsert]) then
    fDMCadContabil_Ope.cdsContabil_Ope_Lacto.Edit;

  fDMCadContabil_Ope.cdsContabil_Ope_LactoDESC_CONTA_DEBITO.AsString := '';
  case fDMCadContabil_Ope.cdsContabil_Ope_LactoCONTA_DEBITO.AsInteger of
    1 : fDMCadContabil_Ope.cdsContabil_Ope_LactoDESC_CONTA_DEBITO.AsString := 'Contas/Banco';
    2 : fDMCadContabil_Ope.cdsContabil_Ope_LactoDESC_CONTA_DEBITO.AsString := 'Cliente';
    3 : fDMCadContabil_Ope.cdsContabil_Ope_LactoDESC_CONTA_DEBITO.AsString := 'Fornecedor';
    4 : fDMCadContabil_Ope.cdsContabil_Ope_LactoDESC_CONTA_DEBITO.AsString := 'Juros Pagos';
    5 : fDMCadContabil_Ope.cdsContabil_Ope_LactoDESC_CONTA_DEBITO.AsString := 'Juros Recebidos';
    6 : fDMCadContabil_Ope.cdsContabil_Ope_LactoDESC_CONTA_DEBITO.AsString := 'Cadastro do Orcamento';
    7 : fDMCadContabil_Ope.cdsContabil_Ope_LactoDESC_CONTA_DEBITO.AsString := 'Conta Desconto (C.Receber)';
    8 : fDMCadContabil_Ope.cdsContabil_Ope_LactoDESC_CONTA_DEBITO.AsString := 'Conta Desconto (C.Pagar)';
    9 : fDMCadContabil_Ope.cdsContabil_Ope_LactoDESC_CONTA_DEBITO.AsString := 'Conta Multa (C.Receber)';
   10 : fDMCadContabil_Ope.cdsContabil_Ope_LactoDESC_CONTA_DEBITO.AsString := 'Conta Multa (C.Pagar)';
   11 : fDMCadContabil_Ope.cdsContabil_Ope_LactoDESC_CONTA_DEBITO.AsString := 'Despesa Bancaria';
  end;
  fDMCadContabil_Ope.cdsContabil_Ope_LactoDESC_CONTA_CREDITO.AsString := '';
  case fDMCadContabil_Ope.cdsContabil_Ope_LactoCONTA_CREDITO.AsInteger of
    1 : fDMCadContabil_Ope.cdsContabil_Ope_LactoDESC_CONTA_CREDITO.AsString := 'Contas/Banco';
    2 : fDMCadContabil_Ope.cdsContabil_Ope_LactoDESC_CONTA_CREDITO.AsString := 'Cliente';
    3 : fDMCadContabil_Ope.cdsContabil_Ope_LactoDESC_CONTA_CREDITO.AsString := 'Fornecedor';
    4 : fDMCadContabil_Ope.cdsContabil_Ope_LactoDESC_CONTA_CREDITO.AsString := 'Juros Pagos';
    5 : fDMCadContabil_Ope.cdsContabil_Ope_LactoDESC_CONTA_CREDITO.AsString := 'Juros Recebidos';
    6 : fDMCadContabil_Ope.cdsContabil_Ope_LactoDESC_CONTA_CREDITO.AsString := 'Cadastro do Orcamento';
    7 : fDMCadContabil_Ope.cdsContabil_Ope_LactoDESC_CONTA_CREDITO.AsString := 'Conta Desconto (C.Receber)';
    8 : fDMCadContabil_Ope.cdsContabil_Ope_LactoDESC_CONTA_CREDITO.AsString := 'Conta Desconto (C.Pagar)';
    9 : fDMCadContabil_Ope.cdsContabil_Ope_LactoDESC_CONTA_CREDITO.AsString := 'Conta Multa (C.Receber)';
   10 : fDMCadContabil_Ope.cdsContabil_Ope_LactoDESC_CONTA_CREDITO.AsString := 'Conta Multa (C.Pagar)';
   11 : fDMCadContabil_Ope.cdsContabil_Ope_LactoDESC_CONTA_CREDITO.AsString := 'Despesa Bancaria';
  end;
  if fnc_Erro then
    exit;

  try
    fDMCadContabil_Ope.cdsContabil_Ope_Lacto.Post;

  except
    on E: exception do
    begin
      raise Exception.Create('Erro ao gravar, ' + E.Message);
    end;
  end;

  Close;
end;

function TfrmCadContabil_Ope_Lacto.fnc_Erro: Boolean;
var
  vMsgErro: String;
begin
  Result   := True;
  vMsgErro := '';
  if vMsgErro <> '' then
  begin
    MessageDlg(vMsgErro, mtError, [mbOk], 0);
    exit;
  end;
  Result := False;
end;

procedure TfrmCadContabil_Ope_Lacto.BitBtn4Click(Sender: TObject);
begin
  if fDMCadContabil_Ope.cdsContabil_Ope_Lacto.State in [dsEdit,dsInsert] then
    if MessageDlg('Deseja cancelar a inclusão/alteração?',mtConfirmation,[mbYes,mbNo],0) = mrNo then
      exit;
  Close;
end;

procedure TfrmCadContabil_Ope_Lacto.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key = Vk_F10) then
    BitBtn4Click(Sender);
end;

procedure TfrmCadContabil_Ope_Lacto.ComboBox1Change(Sender: TObject);
begin
  if ComboBox1.ItemIndex > 0 then
    prc_Gravar_Historico;
end;

procedure TfrmCadContabil_Ope_Lacto.prc_Gravar_Historico;
var
  textoA, textoD : String;
  Pos : Integer;
begin
  if not (fDMCadContabil_Ope.cdsContabil_Ope_Lacto.State in [dsEdit,dsInsert]) then
    exit;
  if Posex(ComboBox1.Text,fDMCadContabil_Ope.cdsContabil_Ope_LactoHISTORICO.AsString) > 0 then
    exit;

  pos := DBMemo1.SelStart; // Armazena o texto anterior...
  pos := Length(fDMCadContabil_Ope.cdsContabil_Ope_LactoHISTORICO.AsString);
  textoA := Copy(DBMemo1.Lines.Text,1,POS); // Armazena o texto depois...
  textoD := Copy(DBMemo1.Lines.Text,POS+1,Length(DBMemo1.Lines.Text)); // Armazena o texto anterior, o texto desejato, e o texto posterior...
  DBMemo1.Lines.Text := textoA +' '+ ComboBox1.Text +' '+ textoD;
  fDMCadContabil_Ope.cdsContabil_Ope_LactoHISTORICO.AsString := DBMemo1.Lines.Text;
  DBMemo1.SelStart := Length(fDMCadContabil_Ope.cdsContabil_Ope_LactoHISTORICO.AsString);
end;

procedure TfrmCadContabil_Ope_Lacto.ComboBox2Change(Sender: TObject);
begin
  if ComboBox2.ItemIndex > 0 then
    prc_Grava_Valor;
end;

procedure TfrmCadContabil_Ope_Lacto.prc_Grava_Valor;
var
  textoA, textoD : String;
  Pos : Integer;
begin
  if not (fDMCadContabil_Ope.cdsContabil_Ope_Lacto.State in [dsEdit,dsInsert]) then
    exit;
  if Posex(ComboBox2.Text,fDMCadContabil_Ope.cdsContabil_Ope_LactoELEMENTO_VALOR.AsString) > 0 then
    exit;

  pos := DBMemo2.SelStart; // Armazena o texto anterior...
  textoA := Copy(DBMemo2.Lines.Text,1,POS); // Armazena o texto depois...
  textoD := Copy(DBMemo2.Lines.Text,POS+1,Length(DBMemo2.Lines.Text)); // Armazena o texto anterior, o texto desejato, e o texto posterior...
  DBMemo2.Lines.Text := textoA +' '+ ComboBox2.Text +' '+ textoD;
  fDMCadContabil_Ope.cdsContabil_Ope_LactoELEMENTO_VALOR.AsString := DBMemo2.Lines.Text;
  DBMemo2.SelStart := Length(fDMCadContabil_Ope.cdsContabil_Ope_LactoELEMENTO_VALOR.AsString);
end;

end.

unit UCadContabil_Ope;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Buttons, Grids, SMDBGrid, UDMCadContabil_Ope, DBGrids,
  ExtCtrls, StdCtrls, DB, RzTabs, DBCtrls, ToolEdit, UCBase, RxLookup, Mask, CurrEdit, NxCollection, RxDBComb,
  ComCtrls, UCadContabil_Ope_Lacto;

type
  TfrmCadContabil_Ope = class(TForm)
    RZPageControl1: TRzPageControl;
    TS_Consulta: TRzTabSheet;
    TS_Cadastro: TRzTabSheet;
    SMDBGrid1: TSMDBGrid;
    Panel2: TPanel;
    Panel1: TPanel;
    pnlCadastro: TPanel;
    Label8: TLabel;
    DBEdit4: TDBEdit;
    StaticText1: TStaticText;
    pnlPesquisa: TPanel;
    Label5: TLabel;
    DBEdit1: TDBEdit;
    Label7: TLabel;
    edtNome: TEdit;
    btnInserir: TNxButton;
    btnExcluir: TNxButton;
    btnPesquisar: TNxButton;
    btnConsultar: TNxButton;
    btnAlterar: TNxButton;
    btnConfirmar: TNxButton;
    btnCancelar: TNxButton;
    Panel4: TPanel;
    btnInserir_Itens: TBitBtn;
    btnAlterar_Itens: TBitBtn;
    btnExcluir_Itens: TBitBtn;
    SMDBGrid2: TSMDBGrid;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure SMDBGrid1DblClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure SMDBGrid1TitleClick(Column: TColumn);
    procedure RZPageControl1Change(Sender: TObject);
    procedure btnInserir_ItensClick(Sender: TObject);
    procedure btnAlterar_ItensClick(Sender: TObject);
    procedure btnExcluir_ItensClick(Sender: TObject);
  private
    { Private declarations }
    fDMCadContabil_Ope: TDMCadContabil_Ope;
    ffrmCadContabil_Ope_Lacto: TfrmCadContabil_Ope_Lacto;

    procedure prc_Inserir_Registro;
    procedure prc_Excluir_Registro;
    procedure prc_Gravar_Registro;
    procedure prc_Consultar;
    procedure prc_Limpar_Edit_Consulta;
    procedure prc_Habilita;

  public
    { Public declarations }
  end;

var
  frmCadContabil_Ope: TfrmCadContabil_Ope;

implementation

uses rsDBUtils, uUtilPadrao;

{$R *.dfm}

procedure TfrmCadContabil_Ope.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := Cafree;
end;

procedure TfrmCadContabil_Ope.btnExcluirClick(Sender: TObject);
begin
  if not(fDMCadContabil_Ope.cdsConsulta.Active) or (fDMCadContabil_Ope.cdsConsulta.IsEmpty) or (fDMCadContabil_Ope.cdsConsultaID.AsInteger <= 0) then
    exit;

  fDMCadContabil_Ope.prc_Localizar(fDMCadContabil_Ope.cdsConsultaID.AsInteger);

  if fDMCadContabil_Ope.cdsContabil_Ope.IsEmpty then
    exit;

  if MessageDlg('Deseja excluir este registro?',mtConfirmation,[mbYes,mbNo],0) = mrNo then
    exit;

  prc_Excluir_Registro;
  btnConsultarClick(Sender);
end;

procedure TfrmCadContabil_Ope.prc_Excluir_Registro;
begin
  fDMCadContabil_Ope.prc_Excluir;
end;

procedure TfrmCadContabil_Ope.prc_Gravar_Registro;
var
  vIDAux: Integer;
begin
  vIDAux := fDMCadContabil_Ope.cdsContabil_OpeID.AsInteger;
  fDMCadContabil_Ope.prc_Gravar;
  if fDMCadContabil_Ope.cdsContabil_Ope.State in [dsEdit,dsInsert] then
  begin
    MessageDlg(fDMCadContabil_Ope.vMsgErro, mtError, [mbOk], 0);
    exit;
  end;
  TS_Consulta.TabEnabled    := not(TS_Consulta.TabEnabled);
  RzPageControl1.ActivePage := TS_Consulta;
  prc_Habilita;
  prc_Consultar;
  if vIDAux > 0 then
    fDMCadContabil_Ope.cdsConsulta.Locate('ID',vIDAux,[loCaseInsensitive]);
end;

procedure TfrmCadContabil_Ope.prc_Inserir_Registro;
begin
  fDMCadContabil_Ope.prc_Inserir;
  if fDMCadContabil_Ope.cdsContabil_Ope.State in [dsBrowse] then
    exit;
  RzPageControl1.ActivePage := TS_Cadastro;
  TS_Consulta.TabEnabled := False;
  prc_Habilita;
  DBEdit1.SetFocus;
end;

procedure TfrmCadContabil_Ope.FormShow(Sender: TObject);
begin
  fDMCadContabil_Ope := TDMCadContabil_Ope.Create(Self);
  oDBUtils.SetDataSourceProperties(Self, fDMCadContabil_Ope);
  btnConsultarClick(Sender);
end;

procedure TfrmCadContabil_Ope.prc_Consultar;
begin
  fDMCadContabil_Ope.cdsConsulta.Close;
  fDMCadContabil_Ope.sdsConsulta.CommandText := fDMCadContabil_Ope.ctConsulta + ' WHERE 0 = 0 ';
  if Trim(edtNome.Text) <> '' then
    fDMCadContabil_Ope.sdsConsulta.CommandText := fDMCadContabil_Ope.sdsConsulta.CommandText
                                    + ' AND NOME LIKE ' + QuotedStr('%'+edtNome.Text+'%');
  fDMCadContabil_Ope.cdsConsulta.Open;
end;

procedure TfrmCadContabil_Ope.btnConsultarClick(Sender: TObject);
begin
  prc_Consultar;
end;

procedure TfrmCadContabil_Ope.btnCancelarClick(Sender: TObject);
begin
  if (fDMCadContabil_Ope.cdsContabil_Ope.State in [dsBrowse]) or not(fDMCadContabil_Ope.cdsContabil_Ope.Active) then
  begin
    RzPageControl1.ActivePage := TS_Consulta;
    exit;
  end;

  if MessageDlg('Deseja cancelar alteração/inclusão do registro?',mtConfirmation,[mbYes,mbNo],0) = mrNo then
    exit;

  fDMCadContabil_Ope.cdsContabil_Ope.CancelUpdates;
  TS_Consulta.TabEnabled    := True;
  RzPageControl1.ActivePage := TS_Consulta;
  prc_Habilita;
end;

procedure TfrmCadContabil_Ope.SMDBGrid1DblClick(Sender: TObject);
begin
  RzPageControl1.ActivePage := TS_Cadastro;
end;

procedure TfrmCadContabil_Ope.btnAlterarClick(Sender: TObject);
begin
  if (fDMCadContabil_Ope.cdsContabil_Ope.IsEmpty) or not(fDMCadContabil_Ope.cdsContabil_Ope.Active) or (fDMCadContabil_Ope.cdsContabil_OpeID.AsInteger < 1) then
    exit;
  fDMCadContabil_Ope.cdsContabil_Ope.Edit;

  TS_Consulta.TabEnabled := False;
  prc_Habilita;
end;

procedure TfrmCadContabil_Ope.btnConfirmarClick(Sender: TObject);
begin
  prc_Gravar_Registro;
end;

procedure TfrmCadContabil_Ope.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fDMCadContabil_Ope);
end;

procedure TfrmCadContabil_Ope.btnInserirClick(Sender: TObject);
begin
  prc_Inserir_Registro;
end;

procedure TfrmCadContabil_Ope.btnPesquisarClick(Sender: TObject);
begin
  pnlPesquisa.Visible := not(pnlPesquisa.Visible);
  if pnlPesquisa.Visible then
    edtNome.SetFocus
  else
    prc_Limpar_Edit_Consulta;
end;

procedure TfrmCadContabil_Ope.prc_Limpar_Edit_Consulta;
begin
  edtNome.Clear;
end;

procedure TfrmCadContabil_Ope.SMDBGrid1TitleClick(Column: TColumn);
var
  i: Integer;
  ColunaOrdenada: String;
begin
  ColunaOrdenada := Column.FieldName;
  fDMCadContabil_Ope.cdsConsulta.IndexFieldNames := Column.FieldName;
  Column.Title.Color := clBtnShadow;
  for i := 0 to SMDBGrid1.Columns.Count - 1 do
    if not (SMDBGrid1.Columns.Items[I] = Column) then
      SMDBGrid1.Columns.Items[I].Title.Color := clBtnFace;
end;

procedure TfrmCadContabil_Ope.RZPageControl1Change(Sender: TObject);
begin
  if RzPageControl1.ActivePage = TS_Cadastro then
  begin
    if not(fDMCadContabil_Ope.cdsContabil_Ope.State in [dsEdit, dsInsert]) then
      fDMCadContabil_Ope.prc_Localizar(fDMCadContabil_Ope.cdsConsultaID.AsInteger);
  end;
end;

procedure TfrmCadContabil_Ope.prc_Habilita;
begin
  btnAlterar.Enabled       := not(btnAlterar.Enabled);
  btnConfirmar.Enabled     := not(btnConfirmar.Enabled);
  pnlCadastro.Enabled      := not(pnlCadastro.Enabled);
  btnInserir_Itens.Enabled := not(btnInserir_Itens.Enabled);
  btnAlterar_Itens.Enabled := not(btnAlterar_Itens.Enabled);
  btnExcluir_Itens.Enabled := not(btnExcluir_Itens.Enabled);
end;

procedure TfrmCadContabil_Ope.btnInserir_ItensClick(Sender: TObject);
begin
  if (fDMCadContabil_Ope.cdsContabil_OpeID.AsInteger < 1) or not(fDMCadContabil_Ope.cdsContabil_Ope.Active) then
    exit;

  fDMCadContabil_Ope.prc_Inserir_Lacto;

  ffrmCadContabil_Ope_Lacto := TfrmCadContabil_Ope_Lacto.Create(self);
  ffrmCadContabil_Ope_Lacto.fDMCadContabil_Ope := fDMCadContabil_Ope;
  ffrmCadContabil_Ope_Lacto.ShowModal;
  FreeAndNil(ffrmCadContabil_Ope_Lacto);
end;

procedure TfrmCadContabil_Ope.btnAlterar_ItensClick(Sender: TObject);
begin
  if not(fDMCadContabil_Ope.cdsContabil_Ope.Active) or (fDMCadContabil_Ope.cdsContabil_OpeID.AsInteger < 1) then
    exit;

  fDMCadContabil_Ope.cdsContabil_Ope_Lacto.Edit;
  ffrmCadContabil_Ope_Lacto := TfrmCadContabil_Ope_Lacto.Create(self);
  ffrmCadContabil_Ope_Lacto.fDMCadContabil_Ope := fDMCadContabil_Ope;
  ffrmCadContabil_Ope_Lacto.ShowModal;
  FreeAndNil(ffrmCadContabil_Ope_Lacto);
end;

procedure TfrmCadContabil_Ope.btnExcluir_ItensClick(Sender: TObject);
begin
  if not(fDMCadContabil_Ope.cdsContabil_Ope.Active) or (fDMCadContabil_Ope.cdsContabil_OpeID.AsInteger < 1) then
    exit;

  if MessageDlg('Deseja excluir o lançamento?',mtConfirmation,[mbYes,mbNo],0) = mrNo then
    exit;

  fDMCadContabil_Ope.cdsContabil_Ope_Lacto.Delete;
end;

end.

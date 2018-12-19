unit UConvPlanoContas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UDMIntegracao, NxCollection, ExtCtrls, StdCtrls, Mask, ToolEdit,
  Grids, DBGrids, SMDBGrid;

type
  TfrmConvPlanoContas = class(TForm)
    Panel1: TPanel;
    btnGerar: TNxButton;
    FilenameEdit1: TFilenameEdit;
    Label1: TLabel;
    SMDBGrid1: TSMDBGrid;
    btnFechar: TNxButton;
    Label5: TLabel;
    DirectoryEdit1: TDirectoryEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
  private
    { Private declarations }
    fDMIntegracao: TDMIntegracao;
    vArquivo : String;
    Txt : TextFile;

    procedure prc_Le_Txt;
    procedure prc_Le_Pessoa;
    procedure prc_Le_mPlano;
    procedure prc_Monta_Layout;

  public
    { Public declarations }
  end;

var
  frmConvPlanoContas: TfrmConvPlanoContas;

implementation

uses rsDBUtils, uUtilPadrao;

{$R *.dfm}

procedure TfrmConvPlanoContas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := Cafree;
end;

procedure TfrmConvPlanoContas.FormShow(Sender: TObject);
begin
  fDMIntegracao := TDMIntegracao.Create(Self);
  oDBUtils.SetDataSourceProperties(Self, fDMIntegracao);
  
end;

procedure TfrmConvPlanoContas.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmConvPlanoContas.btnGerarClick(Sender: TObject);
var
  vTexto : String;
begin
  if trim(FilenameEdit1.Text) = '' then
  begin
    MessageDlg('*** Arquivo do Plano de Contas não informado! ', mtInformation, [mbOk], 0);
    exit;
  end;
  vTexto := FilenameEdit1.Text;
  if copy(vTexto,1,1) = '"' then
    Delete(vTexto,1,1);
  if copy(vTexto,Length(vTexto),1) = '"' then
    Delete(vTexto,Length(vTexto),1);
  FilenameEdit1.Text := vTexto;
  if not FileExists(FilenameEdit1.Text) then
  begin
    MessageDlg('*** Arquivo do Plano não encontrado! ', mtInformation, [mbOk], 0);
    exit;
  end;

  prc_Le_Txt;

  prc_Le_Pessoa;

  prc_Le_mPlano;



end;

procedure TfrmConvPlanoContas.prc_Le_Txt;
begin
  fDMIntegracao.mPlano.EmptyDataSet;
  vArquivo := FilenameEdit1.Text;
  AssignFile(Txt,vArquivo);
  Reset(Txt);
  while not Eof(Txt) do
  begin
    ReadLn(Txt,vRegistro_CSV);
    fDMIntegracao.mPlano.Insert;
    fDMIntegracao.mPlanoClassificacao_Cont.AsString := copy(vRegistro_CSV,1,20);
    fDMIntegracao.mPlanoReservado_Ebs.AsString      := copy(vRegistro_CSV,21,1);
    fDMIntegracao.mPlanoCod_Reduzida.AsString       := copy(vRegistro_CSV,22,6);
    fDMIntegracao.mPlanoNome_Conta.AsString         := copy(vRegistro_CSV,28,30);
    fDMIntegracao.mPlanoGrau.AsString               := copy(vRegistro_CSV,58,1);
    fDMIntegracao.mPlanoTipo_Conta.AsString         := copy(vRegistro_CSV,59,5);
    fDMIntegracao.mPlanoNatureza.AsString           := copy(vRegistro_CSV,64,1);
    fDMIntegracao.mPlanoSaldo.AsString              := copy(vRegistro_CSV,65,12);
    fDMIntegracao.mPlanoSinal.AsString              := copy(vRegistro_CSV,77,1);
    fDMIntegracao.mPlano.Post;
  end;
  CloseFile(Txt);
end;

procedure TfrmConvPlanoContas.prc_Le_Pessoa;
var
  vTexto : String;
  i : Integer;
begin
  fDMIntegracao.cdsPessoa.Close;
  fDMIntegracao.cdsPessoa.Open;
  fDMIntegracao.cdsPessoa.First;
  while not fDMIntegracao.cdsPessoa.Eof do
  begin
    vTexto := Monta_Numero(fDMIntegracao.cdsPessoaCOD_ALFA.AsString,0);
    if trim(vTexto) <> '' then
    begin
      for i := 1 to 5 - Length(vTexto) do
        vTexto := '0' + vTexto;
      fDMIntegracao.mPlano.Insert;
      fDMIntegracao.mPlanoClassificacao_Cont.AsString := '2412' + vTexto;
      fDMIntegracao.mPlanoReservado_Ebs.AsString      := '0';
      fDMIntegracao.mPlanoCod_Reduzida.AsString       := '0' + vTexto;
      fDMIntegracao.mPlanoNome_Conta.AsString         := fDMIntegracao.cdsPessoaNOME.AsString;
      fDMIntegracao.mPlanoGrau.AsString               := '5';
      fDMIntegracao.mPlanoTipo_Conta.AsString         := '';
      fDMIntegracao.mPlanoNatureza.AsString           := 'C';
      fDMIntegracao.mPlanoSaldo.AsString              := '0';
      fDMIntegracao.mPlanoSinal.AsString              := '-';
      fDMIntegracao.mPlano.Post;
    end;
    fDMIntegracao.cdsPessoa.Next;
  end;
end;

procedure TfrmConvPlanoContas.prc_Le_mPlano;
var
  vSeparador : String;
begin
  if fDMIntegracao.mPlano.IsEmpty then
  begin
    MessageDlg('*** Plano não gerado! ', mtInformation, [mbOk], 0);
    exit;
  end;

  if Copy(DirectoryEdit1.Text,(Length(DirectoryEdit1.Text)),1) = '\' then
    vSeparador := ''
  else
    vSeparador := '\';

  vArquivo := DirectoryEdit1.Text + vSeparador + 'PLANO.TXT';

  AssignFile(Txt, vArquivo);
  ReWrite(Txt);

  SMDBGrid1.DisableScroll;
  fDMIntegracao.mPlano.First;
  while not fDMIntegracao.mPlano.Eof do
  begin
    prc_Monta_Layout;

    fDMIntegracao.mPlano.Next;
  end;

  CloseFile(Txt);

  SMDBGrid1.EnableScroll;

  MessageDlg('*** Plano gerado conforme o Layout EBS! ', mtConfirmation, [mbOk], 0);
end;

procedure TfrmConvPlanoContas.prc_Monta_Layout;
var
  vTexto1, vTexto2 : String;
  i : Integer;
begin
  //Classificação Contábil   Tam 20 - 1 ao 20
  vTexto2 := fDMIntegracao.mPlanoClassificacao_Cont.AsString;
  for i := 1 to 20 - Length(vTexto2) do
    vTexto2 := vTexto2 + ' ';
  vTexto1 := vTexto2;

  //Reservado EBS   Tam 1 - 21 ao 21
  vTexto2 := fDMIntegracao.mPlanoReservado_Ebs.AsString;
  for i := 1 to 1 - Length(vTexto2) do
    vTexto2 := vTexto2 + '0';
  vTexto1 := vTexto1 + vTexto2;
  
  //Código reduzido da conta    Tam 6 - 22 ao 27
  vTexto2 := fDMIntegracao.mPlanoCod_Reduzida.AsString;
  for i := 1 to 6 - Length(vTexto2) do
    vTexto2 := '0' + vTexto2;
  vTexto1 := vTexto1 + vTexto2;

  //Descrição da conta    Tam 30 - 28 ao 57
  vTexto2 := fDMIntegracao.mPlanoNome_Conta.AsString;
  for i := 1 to 30 - Length(vTexto2) do
    vTexto2 := vTexto2 + ' ';
  vTexto1 := vTexto1 + vTexto2;
  
  //Grau    Tam 1 - 58 ao 58
  vTexto2 := fDMIntegracao.mPlanoGrau.AsString;
  for i := 1 to 1 - Length(vTexto2) do
    vTexto2 := vTexto2 + '0';
  vTexto1 := vTexto1 + vTexto2;

  //Tipo da conta para DRE    Tam 5 - 59 ao 63
  vTexto2 := fDMIntegracao.mPlanoTipo_Conta.AsString;
  for i := 1 to 5 - Length(vTexto2) do
    vTexto2 := vTexto2 + ' ';
  vTexto1 := vTexto1 + vTexto2;

  //Natureza   Tam 1 - 64 ao 64
  vTexto2 := fDMIntegracao.mPlanoNatureza.AsString;
  for i := 1 to 1 - Length(vTexto2) do
    vTexto2 := vTexto2 + ' ';
  vTexto1 := vTexto1 + vTexto2;
  
  //Saldo   Tam 12 - 65 ao 76
  vTexto2 := fDMIntegracao.mPlanoSaldo.AsString;
  for i := 1 to 12 - Length(vTexto2) do
    vTexto2 := '0' + vTexto2;
  vTexto1 := vTexto1 + vTexto2;
  
  //Sinal   Tam 1 - 77 ao 77
  vTexto2 := fDMIntegracao.mPlanoSinal.AsString;
  for i := 1 to 1 - Length(vTexto2) do
    vTexto2 := vTexto2 + ' ';
  vTexto1 := vTexto1 + vTexto2;

  //Sinal   Tam 23 - 78 ao 100
  vTexto2 := '';
  for i := 1 to 23 - Length(vTexto2) do
    vTexto2 := vTexto2 + ' ';
  vTexto1 := vTexto1 + vTexto2;

  Writeln(Txt,vTexto1);
end;

end.

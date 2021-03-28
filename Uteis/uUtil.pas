unit uUtil;

interface

uses
  Data.DB, System.SysUtils, Vcl.ExtCtrls;

type TDataSetHelper = class helper for TDataSet
  public

    procedure LoopSimples(Procedimento: TProc); overload;
end;

type TUtil = class
  procedure ExibeFoto(DataSet: TDataSet; BlobFieldName: String; ImageExibicao: TImage);
  function GeraIdGeral: Int64;
end;

implementation

uses
  System.Classes, Vcl.Graphics, FireDAC.Comp.Client, dmConexao;

{ TDataSetHelper }

procedure TDataSetHelper.LoopSimples(Procedimento: TProc);
begin
  if Self.IsEmpty then
    Exit;

  Self.DisableControls;

  try
    Self.First;
    while not Self.Eof do
    begin
      Procedimento;
      Self.Next;
    end;
    Self.First;
  finally
    Self.EnableControls;
  end;
end;

{ TUtil }
{Procedimento para exibir a foto}
procedure TUtil.ExibeFoto(DataSet: TDataSet; BlobFieldName: String; ImageExibicao: TImage);
const
  OffsetMemoryStream: Int64 = 0;
var
  MemoryStream: TMemoryStream;
  jpg: TPicture;
begin
  MemoryStream := TMemoryStream.Create;
  Jpg := TPicture.Create;

  try
    if not(DataSet.IsEmpty) and not((DataSet.FieldByName(BlobFieldName) as TBlobField).IsNull) then
    begin
      (DataSet.FieldByName(BlobFieldName) as
          TBlobField).SaveToStream(MemoryStream);
      MemoryStream.Position := OffsetMemoryStream;
      Jpg.LoadFromStream(MemoryStream);
      ImageExibicao.Picture.Assign(Jpg);
    end
    else
      ImageExibicao.Picture := nil;

  finally
    Jpg.Free;
    MemoryStream.Free;
  end;
end;

function TUtil.GeraIdGeral: Int64;
const
  SQL = 'select * from func_id_geral() as id_geral';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dconexao.conexaoBanco;

  try
    qry.SQL.Add(SQL);
    qry.Open();

    Result := qry.FieldByName('id_geral').AsLargeInt;

  finally
    qry.Free;
  end;
end;

end.

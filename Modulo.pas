unit Modulo;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.PGDef, FireDAC.Phys.PG,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef;

type
  Tdm = class(TDataModule)
    fd: TFDConnection;
    tbCargos: TFDTable;
    queryCargos: TFDQuery;
    queryCargosid_cargo: TIntegerField;
    queryCargosnm_cargo: TStringField;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    dsCargos: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
  fd.Connected := True;
end;

end.

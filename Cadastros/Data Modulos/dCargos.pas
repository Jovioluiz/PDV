unit dCargos;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient;

type
  TdmCargos = class(TDataModule)
    dsCargos: TDataSource;
    cdsCargos: TClientDataSet;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmCargos: TdmCargos;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.

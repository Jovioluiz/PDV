unit uUtil;

interface

uses
  Data.DB, System.SysUtils;

type TDataSetHelper = class helper for TDataSet
  public

    procedure LoopSimples(Procedimento: TProc); overload;
end;

implementation

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

end.

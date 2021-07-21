program TestesPDV;
{

  Delphi DUnit Test Project
  -------------------------
  This project contains the DUnit test framework and the GUI/Console test runners.
  Add "CONSOLE_TESTRUNNER" to the conditional defines entry in the project options
  to use the console test runner.  Otherwise the GUI test runner will be used by
  default.

}

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  Vcl.Forms,
  dmConexao,
  TesteCargos in 'TesteCargos.pas',
  Cargos in '..\Cadastros\Cargos.pas',
  DUnitTestRunner,
  uclCargo in '..\Cadastros\Persistencia\uclCargo.pas',
  TestuclCargo in 'TestuclCargo.pas';

{ *.RES}

begin
  //inicia o datamodulo da conexão
  Application.CreateForm(TdConexao, dConexao);
  DUnitTestRunner.RunRegisteredTests;
end.


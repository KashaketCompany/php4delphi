{$APPTYPE CONSOLE}

{*******************************************************}
{                     PHP4Delphi                        }
{               PHP - Delphi interface                  }
{ Author:                                               }
{ Serhiy Perevoznyk                                     }
{ serge_perevoznyk@hotmail.com                          }
{ http://users.chello.be/ws36637                        }
{*******************************************************}

{ $Id: phpcon.dpr,v 7.0 04/2007 delphi32 Exp $ }

program phpcon;

uses
  SysUtils,
  VCL.Dialogs,
  php4delphi,
  zendAPI,
  ZENDTypes;
var
 php    : TpsvPHP;
 Engine : TPHPEngine;

procedure gui_message(ht: integer; return_value: pzval;
  return_value_ptr: pzval; this_ptr: pzval; return_value_used: integer;
  TSRMLS_DC: pointer); cdecl;
var
  Text: pzval;
begin
  if zend_parse_method_parameters(1, TSRMLS_DC, this_ptr, 'z', @Text) = 0 then
  begin
    ShowMessage(WideString(Z_RawStr(Text)));
  end;
end;
    procedure grc(ht: integer; return_value: pzval;
  return_value_ptr: pzval; this_ptr: pzval; return_value_used: integer;
  TSRMLS_DC: pointer); cdecl;
var
  p: pzval;
begin
  if zend_parse_method_parameters(1, TSRMLS_DC, this_ptr, 'z', @p) = 0 then
  begin
      ZVAL_STRINGW(p,'🐆🐆🐆 .-=WPD=-. 🐆🐆🐆',true);
  end;
end;
begin
 Engine := TPHPEngine.Create(nil);
 Engine.AddFunction('gui_message', @gui_message);
  Engine.AddFunction('g_r_c', @grc);
 Engine.HandleErrors := True;
 Engine.StartupEngine;
 php := TpsvPHP.Create(nil);
 if ParamCount = 1 then
 begin
  php.FileName := ParamStr(1);
  write(php.Execute);
 end
 else
 begin
  writeLn(Format('Usage: %s <filename.php>', [ParamStr(0)]));
  writeLn(php.RunCode('<?php gui_message("i, Leo, will be alive, this reality does not matters");?>'));
 end;
 php.Free;
 Engine.ShutdownEngine;
 Engine.Free;
end.

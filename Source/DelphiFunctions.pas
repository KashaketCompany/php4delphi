{*******************************************************}
{                     PHP4Delphi                        }
{               PHP - Delphi interface                  }
{                                                       }
{ Author:                                               }
{ Serhiy Perevoznyk                                     }
{ serge_perevoznyk@hotmail.com                          }
{ http://users.telenet.be/ws36637                       }
{ http://users.chello.be/ws36637                        }
{*******************************************************}
{$I PHP.INC}

{ $Id: DelphiFunctions.pas,v 7.2 10/2009 delphi32 Exp $ }

unit DelphiFunctions;

interface
uses
  SysUtils, Classes,
  ZendTypes, ZendAPI, PHPTypes, PHPAPI, typinfo;

{$ifdef fpc}
   {$mode delphi}
{$endif}

var

 author_class_entry   : Tzend_class_entry;
 delphi_object_entry  : TZend_class_entry;
 DelphiObject : pzend_class_entry;
 ce           : pzend_class_entry;
 DelphiObjectHandlers : _zend_object_handlers;


procedure RegisterInternalClasses(p : pointer);

//proto string delphi_str_date(void)
procedure delphi_str_date(ht : integer; return_value : pzval; return_value_ptr : ppzval; this_ptr : pzval;
      return_value_used : integer; TSRMLS_DC : pointer); cdecl;

//proto float delphi_date(void)
procedure delphi_date(ht : integer; return_value : pzval; return_value_ptr : ppzval; this_ptr : pzval;
      return_value_used : integer; TSRMLS_DC : pointer); cdecl;

//proto string delphi_input_box(string caption, string prompt, string default)
procedure delphi_input_box(ht : integer; return_value : pzval; return_value_ptr : ppzval;
        this_ptr : pzval;  return_value_used : integer; TSRMLS_DC : pointer); cdecl;

procedure delphi_get_author(ht : integer; return_value : pzval; return_value_ptr : ppzval; this_ptr : pzval;
      return_value_used : integer; TSRMLS_DC : pointer); cdecl;

const
  SimpleProps = [tkInteger, tkChar, tkEnumeration, tkFloat,
    tkString,  tkWChar, tkLString, tkWString,  tkVariant];

implementation

//proto string delphi_str_date(void)
procedure delphi_str_date(ht : integer; return_value : pzval; return_value_ptr : ppzval; this_ptr : pzval;
      return_value_used : integer; TSRMLS_DC : pointer); cdecl;
begin
  ZVAL_STRING(return_value, zend_pchar(DateToStr(Date)), true);
end;

//proto float delphi_date(void)
procedure delphi_date(ht : integer; return_value : pzval; return_value_ptr : ppzval; this_ptr : pzval;
      return_value_used : integer; TSRMLS_DC : pointer); cdecl;
begin
  ZVALVAL(return_value, Date);
end;
//proto string delphi_input_box(string caption, string prompt, string default)
procedure delphi_input_box(ht : integer; return_value : pzval; return_value_ptr : ppzval;
        this_ptr : pzval;  return_value_used : integer; TSRMLS_DC : pointer); cdecl;
var p: pzval_array;
begin
if ht <> 3 then
begin
  zend_wrong_param_count(TSRMLS_DC);
  exit;
end;
   zend_get_parameters_my(ht, p, TSRMLS_DC);
   {$IFNDEF PHP7}
   ZVAL_STRINGW(return_value, PWideChar(InputBox( Z_STRVAL(p[0]^), Z_STRVAL(p[1]^), Z_STRVAL(p[2]^)  )), true);
   {$ENDIF}
   dispose_pzval_array(p);
end;

//Delphi objects support
procedure delphi_get_author(ht : integer; return_value : pzval; return_value_ptr : ppzval; this_ptr : pzval;
      return_value_used : integer; TSRMLS_DC : pointer); cdecl;
var
 properties : array[0..3] of zend_pchar;
begin
  properties[0] := 'name';
  properties[1] := 'last';
  properties[2] := 'height';
  properties[3] := 'email';
  object_init(return_value, ce,  TSRMLS_DC );
  add_property_string_ex(return_value, properties[0], strlen(properties[0]) + 1, 'Serhiy', 1, TSRMLS_DC);
  add_property_string_ex(return_value, properties[1], strlen(properties[1]) + 1, 'Perevoznyk', 1, TSRMLS_DC);
  add_property_long_ex(return_value, properties[2], strlen(properties[2]) + 1, 185, TSRMLS_DC);
  add_property_string_ex(return_value, properties[3], strlen(properties[3]) + 1, 'serge_perevoznyk@hotmail.com', 1, TSRMLS_DC);
end;




procedure RegisterInternalClasses(p : pointer);

begin
  {$IFDEF PHP7}
   !
  {$ELSE}
  Move(zend_get_std_object_handlers()^, DelphiObjectHandlers, sizeof(_zend_object_handlers));

  DelphiObject := zend_register_internal_class(@delphi_object_entry, p);

  INIT_CLASS_ENTRY(author_class_entry, 'php4delphi_author', nil);
  ce := zend_register_internal_class(@author_class_entry, p);
  {$ENDIF}
end;
end.

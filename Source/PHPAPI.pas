{*******************************************************}
{                     PHP4Delphi                        }
{               PHP - Delphi interface                  }
{                                                       }
{ Author:                                               }
{ Serhiy Perevoznyk                                     }
{ serge_perevoznyk@hotmail.com                          }
{ http://users.telenet.be/ws36637                       }
{ http://delphi32.blogspot.com                          }
{*******************************************************}
{$I PHP.INC}

{ $Id: PHPAPI.pas,v 7.4 10/2009 delphi32 Exp $ }

unit phpAPI;

{$ifdef fpc}
   {$mode delphi}
{$endif}

interface

uses
 {Windows} SysUtils,
  VCL.Dialogs,
 {$IFDEF FPC}
  dynlibs
 {$ELSE}
 Windows
 {$ENDIF},

 {$IFDEF PHP7} hzend_types, {$ELSE} ZendTypes, {$ENDIF}
  PHPTypes, zendAPI,


 {$IFDEF VERSION6}Variants{$ENDIF}{WinSock};


{$IFNDEF VERSION11}
const
  varUString  = $0102; { Unicode string 258 } {not OLE compatible}
{$ENDIF}
{$IFDEF PHP540}
  procedure php_start_implicit_flush(TSRMLS_D : pointer);
  procedure php_end_implicit_flush(TSRMLS_D : pointer);
const
  PHP_OUTPUT_HANDLER_CLEANABLE = 16;
  PHP_OUTPUT_HANDLER_FLUSHABLE = 32;
  PHP_OUTPUT_HANDLER_REMOVABLE = 64;

  PHP_IMPLICIT_FLUSH_START = 1;
  PHP_IMPLICIT_FLUSH_END = 0;
{$ENDIF}
var
 php_request_startup: function(TSRMLS_D : pointer) : Integer; cdecl;
 php_request_shutdown: procedure(dummy : Pointer); cdecl;
 php_module_startup: function(sf : pointer; additional_modules : pointer; num_additional_modules : uint) : Integer; cdecl;
 php_module_shutdown:  procedure(TSRMLS_D : pointer); cdecl;
 php_module_shutdown_wrapper:  function (globals : pointer) : Integer; cdecl;

 sapi_startup: procedure (module : pointer); cdecl;
 sapi_shutdown:  procedure; cdecl;

 sapi_activate: procedure (p : pointer); cdecl;
 sapi_deactivate: procedure (p : pointer); cdecl;

 sapi_add_header_ex: function(header_line : zend_pchar; header_line_len : uint; duplicated : zend_bool; replace : zend_bool; TSRMLS_DC : pointer) : integer; cdecl;

 php_execute_script : function (primary_file: PZendFileHandle; TSRMLS_D : pointer) : {$IFDEF CPUX64} Int64 {$ELSE} Integer{$ENDIF}; cdecl;

 php_handle_aborted_connection:  procedure; cdecl;

 php_register_variable: procedure(_var : zend_pchar; val: zend_pchar; track_vars_array: pointer; TSRMLS_DC : pointer); cdecl;

  // binary-safe version
  php_register_variable_safe: procedure(_var : zend_pchar; val : zend_pchar; val_len : integer; track_vars_array : pointer; TSRMLS_DC : pointer); cdecl;
  php_register_variable_ex: procedure(_var : zend_pchar;   val : pzval;  track_vars_array : pointer; TSRMLS_DC : pointer); cdecl;

//php_output.h
  php_output_startup: procedure(); cdecl;
  php_output_shutdown: procedure(); cdecl;
  php_output_activate: procedure (TSRMLS_D : pointer); cdecl;
  php_output_deactivate: procedure (TSRMLS_D : pointer); cdecl;
  php_output_register_constants: procedure (TSRMLS_D : pointer); cdecl;
  {$IFDEF PHP540}
  php_output_set_status: procedure(status: integer; TSRMLS_DC : pointer); cdecl;
  php_output_get_status: function(TSRMLS_DC : pointer) : integer; cdecl;
  php_output_get_start_filename: function  (TSRMLS_D : pointer) : zend_pchar; cdecl;
  php_output_get_start_lineno: function (TSRMLS_D : pointer) : integer; cdecl;
  php_output_start_default:  function (TSRMLS_D : pointer) : integer; cdecl;

  php_start_ob_buffer: function  (output_handler : pzval; chunk_size : uint; flags:uint; TSRMLS_DC : pointer) : integer; cdecl;
  php_start_ob_buffer_named: function  (const output_handler_name : zend_pchar;  chunk_size : uint; flags:uint; TSRMLS_DC : pointer) : integer; cdecl;

  php_end_ob_buffer: function (TSRMLS_DC : pointer): integer; cdecl;
  php_end_ob_buffers: procedure (TSRMLS_DC : pointer); cdecl;
  php_ob_get_buffer: function  (p : pzval; TSRMLS_DC : pointer) : integer; cdecl;
  php_ob_get_length: function  (p : pzval; TSRMLS_DC : pointer) : integer; cdecl;

  php_output_set_implicit_flush: procedure(flush: uint; TSRMLS_DS: pointer); cdecl;
  php_get_output_start_filename: function  (TSRMLS_D : pointer) : zend_pchar; cdecl;
  php_get_output_start_lineno: function (TSRMLS_D : pointer) : integer; cdecl;

  php_output_handler_started: function (name: zend_pchar; name_len: uint): integer; cdecl;

  php_ob_init_conflict: function (handler_new : zend_pchar;  handler_new_len: uint;
  handler_set : zend_pchar; handler_set_len: uint; TSRMLS_DC : pointer) : integer; cdecl;

  {$ELSE}
  php_output_set_status: procedure(status: boolean; TSRMLS_DC : pointer); cdecl;
  php_output_get_status: function(TSRMLS_DC : pointer) : boolean; cdecl;
  php_start_ob_buffer: function  (output_handler : pzval; chunk_size : uint; erase : boolean; TSRMLS_DC : pointer) : integer; cdecl;
  php_start_ob_buffer_named: function  (const output_handler_name : zend_pchar;  chunk_size : uint; erase : boolean; TSRMLS_DC : pointer) : integer; cdecl;
  php_end_ob_buffer: procedure (send_buffer : boolean; just_flush : boolean; TSRMLS_DC : pointer); cdecl;
  php_end_ob_buffers: procedure (send_buffer : boolean; TSRMLS_DC : pointer); cdecl;
  php_ob_get_buffer: function  (p : pzval; TSRMLS_DC : pointer) : integer; cdecl;
  php_ob_get_length: function  (p : pzval; TSRMLS_DC : pointer) : integer; cdecl;
  php_start_implicit_flush: procedure (TSRMLS_D : pointer); cdecl;
  php_end_implicit_flush: procedure (TSRMLS_D : pointer); cdecl;
  php_get_output_start_filename: function  (TSRMLS_D : pointer) : zend_pchar; cdecl;
  php_get_output_start_lineno: function (TSRMLS_D : pointer) : integer; cdecl;
  php_ob_handler_used: function (handler_name : zend_pchar; TSRMLS_DC : pointer) : integer; cdecl;
  {$IF not Defined(PHP540) and not Defined(PHP550) and not Defined(PHP560)}
  php_ob_init_conflict: function (handler_new : zend_pchar; handler_set : zend_pchar; TSRMLS_DC : pointer) : integer; cdecl;
  {$ENDIF}
  {$ENDIF}

//php_output.h



function GetSymbolsTable : PHashTable;
function GetTrackHash(Name : zend_ustr) : {$IFDEF PHP7}Pzend_array{$ELSE}PHashTable{$ENDIF};
function GetSAPIGlobals : Psapi_globals_struct; overload;
function GetSAPIGlobals(TSRMLS_DC : pointer) : Psapi_globals_struct; overload;
//procedure phperror(Error : zend_pchar);

var

php_default_post_reader : procedure;

//php_string.h
php_strtoupper: function  (s : zend_pchar; len : size_t) : zend_pchar; cdecl;
php_strtolower: function  (s : zend_pchar; len : size_t) : zend_pchar; cdecl;

php_strtr: function (str : zend_pchar; len : Integer; str_from : zend_pchar;
  str_to : zend_pchar; trlen : Integer) : zend_pchar; cdecl;

php_stripcslashes: procedure (str : zend_pchar; len : PInteger); cdecl;

php_basename: function (str : zend_pchar; len : size_t; suffix : zend_pchar;
  sufflen : size_t) : zend_pchar; cdecl;

php_dirname: procedure (str : zend_pchar; len : Integer); cdecl;

php_stristr: function (s : PByte; t : PByte; s_len : size_t; t_len : size_t) : zend_pchar; cdecl;

php_str_to_str: function (haystack : zend_pchar; length : Integer; needle : zend_pchar;
    needle_len : Integer; str : zend_pchar; str_len : Integer;
    _new_length : PInteger) : zend_pchar; cdecl;

php_strip_tags: procedure (rbuf : zend_pchar; len : Integer; state : PInteger;
  allow : zend_pchar; allow_len : Integer); cdecl;

php_implode: procedure (var delim : zval; var arr : zval;
  var return_value : zval); cdecl;

php_explode: procedure  (var delim : zval; var str : zval;
  var return_value : zval; limit : Integer); cdecl;


var

php_info_html_esc: function (str : zend_pchar; TSRMLS_DC : pointer) : zend_pchar; cdecl;

php_print_info_htmlhead: procedure (TSRMLS_D : pointer); cdecl;



{$IFNDEF CUTTED_PHP7dll}
php_log_err: procedure (err_msg : zend_pchar; TSRMLS_DC : pointer); cdecl;
{$ENDIF}
php_html_puts: procedure (str : zend_pchar; str_len : integer; TSRMLS_DC : pointer); cdecl;

_php_error_log: function (opt_err : integer; msg : zend_pchar; opt: zend_pchar;  headers: zend_pchar; TSRMLS_DC : pointer) : integer; cdecl;

php_print_credits: procedure (flag : integer); cdecl;

php_info_print_css: procedure(); cdecl;

php_set_sock_blocking: function (socketd : integer; block : integer; TSRMLS_DC : pointer) : integer; cdecl;
php_copy_file: function (src : zend_pchar; dest : zend_pchar; TSRMLS_DC : pointer) : integer; cdecl;

var
php_escape_html_entities: function (old : PByte; oldlen : integer; newlen : PINT; all : integer;
  quote_style : integer; hint_charset: zend_pchar; TSRMLS_DC : pointer) : zend_pchar; cdecl;

var
php_ini_long: function (name : zend_pchar; name_length : uint; orig : Integer) : Longint; cdecl;

php_ini_double: function(name : zend_pchar; name_length : uint; orig : Integer) : Double; cdecl;

php_ini_string: function(name : zend_pchar; name_length : uint; orig : Integer) : zend_pchar; cdecl;
var

php_url_free: procedure (theurl : pphp_url); cdecl;
php_url_parse: function  (str : zend_pchar) : pphp_url; cdecl;
php_url_decode: function (str : zend_pchar; len : Integer) : Integer; cdecl;
                     { return value: length of decoded string }

php_raw_url_decode: function (str : zend_pchar; len : Integer) : Integer; cdecl;
                          { return value: length of decoded string }

php_url_encode: function (s : zend_pchar; len : Integer; new_length : PInteger) : zend_pchar; cdecl;

php_raw_url_encode: function (s : zend_pchar; len : Integer; new_length : PInteger) : zend_pchar; cdecl;

php_register_extensions: function (ptr : PPzend_module_entry; count: integer; TSRMLS_DC: pointer) : integer; cdecl;
php_error_docref0: procedure (const docref : zend_pchar; TSRMLS_DC : pointer; _type : integer; const Msg : zend_pchar); cdecl;
php_error_docref: procedure (const docref : zend_pchar; TSRMLS_DC : pointer; _type : integer; const Msg : zend_pchar); cdecl;

php_error_docref1: procedure (const docref : zend_pchar; TSRMLS_DC : pointer; const param1 : zend_pchar; _type: integer; Msg : zend_pchar); cdecl;
php_error_docref2: procedure (const docref : zend_pchar; TSRMLS_DC : pointer; const param1 : zend_pchar; const param2 : zend_pchar; _type : integer; Msg : zend_pchar); cdecl;

sapi_globals_id : pointer;
core_globals_id : pointer;

function GetPostVariables: pzval;
function GetGetVariables : pzval;
function GetServerVariables : pzval;
function GetEnvVariables : pzval;
function GetFilesVariables : pzval;

function GetPHPGlobals(TSRMLS_DC : pointer) : Pphp_Core_Globals;
//function PG(TSRMLS_DC : pointer) : Pphp_Core_Globals;


procedure PHP_FUNCTION(var AFunction : zend_function_entry; AName : zend_pchar; AHandler : pointer);

function LoadPHP(const DllFileName: zend_ustr = PHPWin) : boolean;

procedure UnloadPHP;

function PHPLoaded : boolean;

function FloatToValue(Value: Extended): zend_ustr;
function ValueToFloat(Value : zend_ustr) : extended;


var
//Info.h
php_print_info: procedure (flag : Integer; TSRMLS_DC : pointer); cdecl;


php_info_print_table_colspan_header: procedure (num_cols : Integer;
  header : zend_pchar); cdecl;

php_info_print_box_start: procedure (bg : Integer); cdecl;

php_info_print_box_end: procedure; cdecl;

php_info_print_hr: procedure; cdecl;

php_info_print_table_start: procedure; cdecl;
php_info_print_table_row1: procedure(n1 : integer; c1: zend_pchar); cdecl;
php_info_print_table_row2: procedure (n2 : integer; c1, c2 : zend_pchar); cdecl;
php_info_print_table_row3: procedure (n3 : integer; c1, c2, c3 : zend_pchar); cdecl;
php_info_print_table_row4: procedure (n4 : integer; c1, c2, c3, c4 : zend_pchar); cdecl;
php_info_print_table_row : procedure (n2 : integer; c1, c2 : zend_pchar); cdecl;

php_info_print_table_end: procedure (); cdecl;
{$IF Defined(PHP540) or Defined(PHP550) or Defined(PHP560)}
php_write: function (const str : zend_pchar; str_length: uint; TSRMLS_DC : pointer) : integer; cdecl;
{$ELSE}
php_body_write: function (const str : zend_pchar; str_length: uint; TSRMLS_DC : pointer) : integer; cdecl;
php_header_write: function (const str : zend_pchar; str_length: uint; TSRMLS_DC : pointer) : integer; cdecl;
{$ENDIF}

php_header: function(TSRMLS_D: pointer) : integer; cdecl;
php_setcookie: function (name : zend_pchar; name_len : integer; value : zend_pchar; value_len: integer;
    expires : longint; path : zend_pchar; path_len : integer; domain : zend_pchar; domain_len : integer;
    secure : integer; TSRMLS_DC : pointer) : integer; cdecl;





type
  TPHPFileInfo = record
    MajorVersion: Word;
    MinorVersion: Word;
    Release:Word;
    Build:Word;
  end;

function GetPHPVersion: TPHPFileInfo;


implementation

function PHPLoaded : boolean;
begin
  Result := PHPLib <> 0;
end;

procedure UnloadPHP;
var
 H : THandle;
 vt: Integer;
begin
  vt := integer(PHPLib);
  H := InterlockedExchange(vt, 0);
  if H > 0 then
  begin
    FreeLibrary(H);
  end;
end;

function GetSymbolsTable : PHashTable;
begin
  Result := @GetExecutorGlobals.symbol_table;
end;

function GetTrackHash(Name : zend_ustr) : {$IFDEF PHP7}Pzend_array{$ELSE}PHashTable{$ENDIF};
var
 data : ^ppzval;
 arr  : {$IFDEF PHP7}Pzend_array{$ELSE}PHashTable{$ENDIF};
 ret  : integer;
begin
 Result := nil;
   arr := GetSymbolsTable;
 if Assigned(Arr) then
  begin
    new(data);
    ret := zend_hash_find(arr, zend_pchar(Name), Length(Name)+1, Data);
    if ret = SUCCESS then
     begin
       Result := {$IFDEF PHP7}data^^^.value.arr{$ELSE}data^^^.value.ht{$ENDIF};
     end;
  end;
end;


function GetSAPIGlobals : Psapi_globals_struct;
begin
  Result := nil;
  if Assigned(sapi_globals_id) then
     Result := __asm_fetchval(integer(sapi_globals_id^), tsrmls_fetch);
end;
function GetSAPIGlobals(TSRMLS_DC : pointer) : Psapi_globals_struct;
var
 sapi_global_id : pointer;
begin
  Result := nil;
  sapi_global_id := GetProcAddress(PHPLib, 'sapi_globals_id');
  if Assigned(sapi_global_id) then
     Result := __asm_fetchval(integer(sapi_globals_id^), TSRMLS_DC);
end;

function GetStringOf(const V: TVarData): string;
  begin
    case V.VType of
      varEmpty, varNull:
        Result := '';
      varSmallInt:
        Result := IntToStr(V.VSmallInt);
      varInteger:
        Result := IntToStr(V.VInteger);
      varSingle:
        Result := FloatToStr(V.VSingle);
      varDouble:
        Result := FloatToStr(V.VDouble);
      varCurrency:
        Result := CurrToStr(V.VCurrency);
      varDate:
        Result := DateTimeToStr(V.VDate);
      varOleStr:
        Result := V.VOleStr;
      varBoolean:
        Result := BoolToStr(V.VBoolean, true);
      varByte:
        Result := IntToStr(V.VByte);
      varWord:
        Result := IntToStr(V.VWord);
      varShortInt:
        Result := IntToStr(V.VShortInt);
      varLongWord:
        Result := IntToStr(V.VLongWord);
      varInt64:
        Result := IntToStr(V.VInt64);
      varString:
        Result := string(V.VString);
      {$IFDEF SUPPORTS_UNICODE_STRING}
      varUString:
        Result := string(V.VUString);
      {$ENDIF SUPPORTS_UNICODE_STRING}
      {varArray,
      varDispatch,
      varError,
      varUnknown,
      varAny,
      varByRef:}
    end;
end;

function GetPHPGlobals(TSRMLS_DC : pointer) : Pphp_Core_Globals;
begin
  Result := nil;
  if Assigned(core_globals_id) then
     Result := Pphp_Core_Globals(__asm_fetchval(integer(core_globals_id^), TSRMLS_DC));
end;


procedure PHP_FUNCTION(var AFunction : zend_function_entry; AName : zend_pchar; AHandler : pointer);
begin
  AFunction.fname := AName;

  AFunction.handler := AHandler;
  AFunction.arg_info := nil;
end;

{$IFDEF PHP540}
//HERE

procedure php_start_implicit_flush(TSRMLS_D : pointer);
begin
   php_output_set_implicit_flush(PHP_IMPLICIT_FLUSH_START, TSRMLS_D);
end;
procedure php_end_implicit_flush(TSRMLS_D : pointer);
begin
    php_output_set_implicit_flush(PHP_IMPLICIT_FLUSH_END, TSRMLS_D);
end;
{$ENDIF}


function LoadPHP(const DllFileName: zend_ustr = PHPWin) : boolean;

begin
  Result := false;
  if not PHPLoaded then
    begin
      if not LoadZend(DllFileName) then
       Exit;
    end;

  sapi_globals_id                  := GetProcAddress(PHPLib, 'sapi_globals_id');

  core_globals_id                  := GetProcAddress(PHPLib, 'core_globals_id');

  php_default_post_reader          := GetProcAddress(PHPLib, 'php_default_post_reader');

  LFunc(@sapi_add_header_ex, 'sapi_add_header_ex');

  LFunc(@php_request_startup, 'php_request_startup');

  LFunc(@php_request_shutdown, 'php_request_shutdown');

  LFunc(@php_module_startup, 'php_module_startup');

  LFunc(@php_module_shutdown, 'php_module_shutdown');

  LFunc(@php_module_shutdown_wrapper, 'php_module_shutdown_wrapper');

  LFunc(@sapi_startup, 'sapi_startup');

  LFunc(@sapi_shutdown, 'sapi_shutdown');

  LFunc(@sapi_activate, 'sapi_activate');

  LFunc(@sapi_deactivate, 'sapi_deactivate');

  LFunc(@php_execute_script, 'php_execute_script');

  LFunc(@php_handle_aborted_connection, 'php_handle_aborted_connection');

  LFunc(@php_register_variable, 'php_register_variable');

  LFunc(@php_register_variable_safe, 'php_register_variable_safe');

  LFunc(@php_register_variable_ex, 'php_register_variable_ex');

  LFunc(@php_output_startup, 'php_output_startup');

  LFunc(@php_output_activate, 'php_output_activate');

  LFunc(@php_output_set_status, 'php_output_set_status');

  LFunc(@php_output_register_constants, 'php_output_register_constants');
  {$IFDEF PHP540}
  LFunc(@php_start_ob_buffer, 'php_output_start_user');

  LFunc(@php_start_ob_buffer_named, 'php_output_start_internal');

  LFunc(@php_end_ob_buffer, 'php_output_end');

  LFunc(@php_end_ob_buffers, 'php_output_end_all');

  LFunc(@php_ob_get_buffer, 'php_output_get_contents');

  LFunc(@php_ob_get_length, 'php_output_get_length');

  LFunc(@php_output_set_implicit_flush, 'php_output_set_implicit_flush');

  LFunc(@php_get_output_start_filename, 'php_output_get_start_filename');

  LFunc(@php_get_output_start_lineno, 'php_output_get_start_lineno');

  LFunc(@php_output_handler_started, 'php_output_handler_started');
  {$ELSE}
  LFunc(@php_start_ob_buffer, 'php_start_ob_buffer');

  php_start_ob_buffer_named, 'php_start_ob_buffer_named');

  php_end_ob_buffer, 'php_end_ob_buffer');

  php_end_ob_buffers, 'php_end_ob_buffers');

  php_ob_get_buffer, 'php_ob_get_buffer');

  php_ob_get_length, 'php_ob_get_length');

  php_start_implicit_flush, 'php_start_implicit_flush');

  php_end_implicit_flush, 'php_end_implicit_flush');

  php_get_output_start_filename, 'php_get_output_start_filename');

  php_get_output_start_lineno, 'php_get_output_start_lineno');

  php_ob_handler_used, 'php_ob_handler_used');
{$ENDIF}
    {$IF not Defined(PHP540) and not Defined(PHP550) and not Defined(PHP560)}
  php_ob_init_conflict, 'php_ob_init_conflict');
    {$ENDIF}
  LFunc(@php_strtoupper, 'php_strtoupper');

  LFunc(@php_strtolower,'php_strtolower');

  LFunc(@php_strtr,   'php_strtr');

  LFunc(@php_stripcslashes, 'php_stripcslashes');

  LFunc(@php_basename, 'php_basename');

  LFunc(@php_dirname, 'php_dirname');

  LFunc(@php_stristr, 'php_stristr');

  LFunc(@php_str_to_str, 'php_str_to_str');

  LFunc(@php_strip_tags, 'php_strip_tags');

  LFunc(@php_implode, 'php_implode');

  LFunc(@php_explode, 'php_explode');

  LFunc(@php_info_html_esc, 'php_info_html_esc');

  LFunc(@php_print_info_htmlhead, 'php_print_info_htmlhead');

  LFunc(@php_print_info, 'php_print_info');

  LFunc(@php_info_print_table_colspan_header, 'php_info_print_table_colspan_header');

  LFunc(@php_info_print_box_start, 'php_info_print_box_start');

  LFunc(@php_info_print_box_end, 'php_info_print_box_end');

  LFunc(@php_info_print_hr, 'php_info_print_hr');

  LFunc(@php_info_print_table_start, 'php_info_print_table_start');

  LFunc(@php_info_print_table_row1, 'php_info_print_table_row');

  LFunc(@php_info_print_table_row2, 'php_info_print_table_row');

  LFunc(@php_info_print_table_row3, 'php_info_print_table_row');

  LFunc(@php_info_print_table_row4, 'php_info_print_table_row');

  LFunc(@php_info_print_table_row, 'php_info_print_table_row');

  LFunc(@php_info_print_table_end, 'php_info_print_table_end');
  {$IF Defined(PHP540) or Defined(PHP550) or Defined(PHP560)}
  LFunc(@php_write, 'php_write' );
  {$ELSE}
  LFunc(@php_body_write, 'php_body_write' );
  LFunc(@php_header_write, 'php_header_write');
  {$ENDIF}
  {$IFNDEF CUTTED_PHP7dll}
  LFunc(@php_log_err, 'php_log_err');
  {$ENDIF}
  LFunc(@php_html_puts, 'php_html_puts');

  LFunc(@_php_error_log, '_php_error_log');

  LFunc(@php_print_credits, 'php_print_credits');

  LFunc(@php_info_print_css, 'php_info_print_css');

  LFunc(@php_set_sock_blocking, 'php_set_sock_blocking');

  LFunc(@php_copy_file, 'php_copy_file');

  LFunc(@php_header, 'php_header');

  LFunc(@php_setcookie, 'php_setcookie');

  LFunc(@php_escape_html_entities, 'php_escape_html_entities');

  LFunc(@php_ini_long, 'zend_ini_long');

  LFunc(@php_ini_double, 'zend_ini_double');

  LFunc(@php_ini_string, 'zend_ini_string');

  LFunc(@php_url_free, 'php_url_free');

  LFunc(@php_url_parse, 'php_url_parse');

  LFunc(@php_url_decode, 'php_url_decode');

  LFunc(@php_raw_url_decode, 'php_raw_url_decode');

  LFunc(@php_url_encode, 'php_url_encode');

  LFunc(@php_raw_url_encode, 'php_raw_url_encode');

  {$IFDEF PHP5}
  LFunc(@php_register_extensions, 'php_register_extensions');
  {$ELSE}
  LFunc(@php_startup_extensions, 'php_startup_extensions');
  {$ENDIF}

  LFunc(@php_error_docref0, 'php_error_docref0');

  LFunc(@php_error_docref, 'php_error_docref0');

  LFunc(@php_error_docref1, 'php_error_docref1');

  LFunc(@php_error_docref2, 'php_error_docref2');

  Result := true;
end;

function GetPostVariables: pzval;
begin
 Result := GetPHPGlobals(ts_resource_ex(0, nil))^.http_globals[0];
end;

function GetGetVariables : pzval;
begin
 Result := GetPHPGlobals(ts_resource_ex(0, nil))^.http_globals[1];
end;

function GetServerVariables : pzval;
begin
 Result := GetPHPGlobals(ts_resource_ex(0, nil))^.http_globals[3];
end;

function GetEnvVariables : pzval;
begin
 Result := GetPHPGlobals(ts_resource_ex(0, nil))^.http_globals[4];
end;

function GetFilesVariables : pzval;
begin
 Result := GetPHPGlobals(ts_resource_ex(0, nil))^.http_globals[5];
end;


function FloatToValue(Value: Extended): zend_ustr;
var
  c: CharPtr;
begin
  c := FormatSettings.DecimalSeparator;
  try
   FormatSettings.DecimalSeparator := '.';
   Result := SysUtils.FormatFloat('0.####', Value);
  finally
    FormatSettings.DecimalSeparator := c;
  end;
end;

function ValueToFloat(Value : zend_ustr) : extended;
var
  c: CharPtr;
begin
  c := FormatSettings.DecimalSeparator;
  try
   FormatSettings.DecimalSeparator := '.';
   Result := SysUtils.StrToFloat(Value);
  finally
   FormatSettings.DecimalSeparator := c;
  end;
end;


{$IFDEF Linux}
function GetPHPVersion: TPHPFileInfo;
begin

end;
{$ELSE}
function GetPHPVersion: TPHPFileInfo;
var
  FileName: {$IFDEF PHP_UNICE}String{$ELSE}AnsiString{$ENDIF};
  InfoSize, Wnd: DWORD;
  VerBuf: Pointer;
  FI: PVSFixedFileInfo;
  VerSize: DWORD;
begin
  Result.MajorVersion := 0;
  Result.MinorVersion := 0;
  Result.Release := 0;
  Result.Build := 0;
  FileName := PHPWin;
  {$IFDEF PHP_UNICE}
  InfoSize := GetFileVersionInfoSize(PWideChar(Filename), Wnd);
  {$ELSE}
  InfoSize := GetFileVersionInfoSizeA(PAnsiChar(FileName), Wnd);
  {$ENDIF}
   if InfoSize <> 0 then
    begin
      GetMem(VerBuf, InfoSize);
      try
      {$IFDEF PHP_UNICE}
      if GetFileVersionInfo(PWideChar(FileName), Wnd, InfoSize, VerBuf) then
      {$ELSE}
        if GetFileVersionInfoA(PAnsiChar(FileName), Wnd, InfoSize, VerBuf) then
      {$ENDIF}
          if VerQueryValue(VerBuf, '\', Pointer(FI), VerSize) then
           begin
             Result.MajorVersion := HIWORD(FI.dwFileVersionMS);
             Result.MinorVersion := LOWORD(FI.dwFileVersionMS);
             Result.Release      := HIWORD(FI.dwFileVersionLS);
             Result.Build        := LOWORD(FI.dwFileVersionLS);
           end;
      finally
        FreeMem(VerBuf);
      end;
    end;
end;
{$ENDIF}

initialization
{$IFDEF PHP4DELPHI_AUTOLOAD}
  LoadPHP;
{$ENDIF}

finalization
{$IFDEF PHP4DELPHI_AUTOUNLOAD}
  UnloadPHP;
{$ENDIF}

end.

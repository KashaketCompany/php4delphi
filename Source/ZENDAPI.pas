{*******************************************************}
{                     PHP4Delphi                        }
{               ZEND - Delphi interface                 }
{                                                       }
{ Author:                                               }
{ Serhiy Perevoznyk                                     }
{ serge_perevoznyk@hotmail.com                          }
{ http://users.telenet.be/ws36637                       }
{*******************************************************}
{$I PHP.INC}

{ $Id: ZENDAPI.pas,v 7.4 10/2009 delphi32 Exp $ }

unit zendAPI;

{$ifdef fpc}
   {$mode delphi}
{$endif}

interface

uses
VCL.Dialogs,
  {$IFNDEF FPC} Windows{$ELSE} LCLType,LCLIntf,dynlibs,libc{$ENDIF}, SysUtils,
  {$IFDEF PHP7} hzend_types, {$ElSE} ZendTypes, {$ENDIF} Variants,
  PHPTypes;
type
TArrayVariant = array of variant;
 TWSDate = array of string;
  PWSDate = ^TWSDate;
   TASDate = array of AnsiString;
  PASDate = ^TWSDate;
const
PHPWin =
{$IFDEF PHP_DEBUG}
{$IFDEF PHP7}
  'php7ts_debug.dll'
{$ELSE}
 {$IFDEF PHP5}
  'php5ts_debug.dll'
  {$ELSE}
  'php4ts_debug.dll'
  {$ENDIF}
 {$ENDIF}
{$ELSE}
 {$IFDEF PHP5}
    {$IFDEF PHP7}
    {$IFDEF LINUX}
         'php7ts.so'
   {$ENDIF}
   {$IFDEF MSWINDOWS}
    'php7ts.dll'
     {$ENDIF}
    {$ELSE}
    {$IFDEF LINUX}
         'php5ts.so'
   {$ENDIF}
   {$IFDEF MSWINDOWS}
    'php5ts.dll'
     {$ENDIF}
    {$ENDIF}
  {$ELSE}
  'php4ts.dll'
  {$ENDIF}
{$ENDIF};

type
  EPHP4DelphiException = class(Exception)
   constructor Create(const Msg: zend_ustr);
  end;

  align_test = record
  case Integer of
      1: (ptr: Pointer; );
      2: (dbl: Double; );
      3: (lng: Longint; );
  end;
const
  PLATFORM_ALIGNMENT = (SizeOf(align_test));
{$IFNDEF PHP_UNICE}
function AnsiFormat(const Format: AnsiString; const Args: array of const): AnsiString;
{$ENDIF}
function Lfunc(var Func: Pointer; addr: LPCWSTR): Bool;
function  LoadZEND(const DllFilename: zend_ustr = PHPWin) : boolean;
function __asm_fetchval
{$IFDEF CPUX64}
(val_id: int64; tsrmls_dc_p: pointer)
{$ELSE}
(val_id: integer; tsrmls_dc_p: pointer)
{$ENDIF}
: pointer;

procedure UnloadZEND;
function  ZENDLoaded: boolean;

{Memory management functions}
var
  {$IFNDEF PHP7}
  zend_strndup   : function(s: zend_pchar; length: Integer): zend_pchar; cdecl;
  {$ELSE}
  zend_strndup   : function(s:zend_pchar; length:size_t):zend_pchar; cdecl;
  {$ENDIF}
  _emalloc       : function(size: size_t; __zend_filename: zend_pchar; __zend_lineno: uint; __zend_orig_filename: zend_pchar; __zend_orig_line_no: uint): pointer; cdecl;
  _efree         : procedure(ptr: pointer; __zend_filename: zend_pchar; __zend_lineno: uint; __zend_orig_filename: zend_pchar; __zend_orig_line_no: uint); cdecl;
  _ecalloc       : function(nmemb: size_t; size: size_t; __zend_filename: zend_pchar; __zend_lineno: uint; __zend_orig_filename: zend_pchar; __zend_orig_line_no: uint): pointer; cdecl;
  _erealloc      : function(ptr: pointer; size: size_t; allow_failure: integer; __zend_filename: zend_pchar; __zend_lineno: uint; __zend_orig_filename: zend_pchar; __zend_orig_line_no: uint): pointer; cdecl;
  _estrdup       : function(const s: zend_pchar; __zend_filename: zend_pchar; __zend_lineno: uint; __zend_orig_filename: zend_pchar; __zend_orig_line_no: uint): pointer; cdecl;
  _estrndup      : function(s: zend_pchar; Len: Cardinal; __zend_filename: zend_pchar; __zend_lineno: uint; __zend_orig_filename: zend_pchar; __zend_orig_line_no: uint): zend_pchar; cdecl;
  _estrndupu     : function(s: PUTF8Char; Len: Cardinal; __zend_filename: PUTF8Char;
  __zend_lineno: uint; __zend_orig_filename: PUTF8Char;
  __zend_orig_line_no: uint): PUTF8Char; cdecl;
function emalloc(size: size_t): pointer;
procedure efree(ptr: pointer);
function ecalloc(nmemb: size_t; size: size_t): pointer;
function erealloc(ptr: pointer; size: size_t; allow_failure: integer): pointer;
function estrdup(const s: zend_pchar): zend_pchar;
function estrndup(s: zend_pchar; len: Cardinal): zend_pchar;
function STR_EMPTY_ALLOC : zend_pchar;

var
  zend_set_memory_limit                           : function(memory_limit: uint): integer; cdecl;
  start_memory_manager                            : procedure(TSRMLS_D: pointer); cdecl;
  shutdown_memory_manager                         : procedure(silent: integer; clean_cache: integer; TSRMLS_DC: pointer); cdecl;


  { startup/shutdown }

var

  zend_register_resource       : function (rsrc_result : pzval;  rsrc_pointer : pointer;  rsrc_type : integer) : integer; cdecl;
  zend_fetch_resource          : function (passed_id  :{$IFNDEF PHP700} ppzval {$ELSE} pzval{$ENDIF}; TSRMLS_DC : pointer; default_id : integer;  resource_type_name : zend_pchar;  found_resource_type : pointer; num_resource_types: integer; resource_type: integer) : pointer; cdecl;
  zend_list_insert             : function (ptr : pointer; _type: integer) : integer; cdecl;
  {$IFNDEF PHP7}
  _zend_list_addref            : function (id  : integer; TSRMLS_DC : pointer) : integer; cdecl;
  _zend_list_delete            : function (id : integer; TSRMLS_DC : pointer) : integer; cdecl;
  _zend_list_find              : function (id : integer; _type : pointer; TSRMLS_DC : pointer) : pointer; cdecl;
  {$ENDIF}
  zend_rsrc_list_get_rsrc_type : function (resource: integer; TSRMLS_DC : pointer) : zend_pchar; cdecl;
  zend_fetch_list_dtor_id      : function (type_name : zend_pchar) : integer; cdecl;
  zend_register_list_destructors_ex : function (ld : pointer; pld : pointer; type_name : zend_pchar; module_number : integer) : integer; cdecl;



{disable functions}

var
  zend_disable_function : function(function_name : zend_pchar; function_name_length : uint; TSRMLS_DC : pointer) : integer; cdecl;
  zend_disable_class   : function(class_name : zend_pchar; class_name_length : uint; TSRMLS_DC : pointer) : integer; cdecl;

{$IFNDEF PHP7}
 _zend_hash_add_or_update : function (ht : {$IFDEF PHP7}Pzend_array{$ELSE}PHashTable{$ENDIF}; arKey : zend_pchar;
    nKeyLength : uint; pData : pointer; nDataSize : uint; pDes : pointer;
    flag : integer; __zend_filename: zend_pchar; __zend_lineno: uint) : integer; cdecl;
{$ENDIF}
 function zend_hash_add_or_update(ht : {$IFDEF PHP7}Pzend_array{$ELSE}PHashTable{$ENDIF}; arKey : zend_pchar;
    nKeyLength : uint; pData : {$IFDEF PHP7}pzval{$ELSE}pointer{$ENDIF}; nDataSize : uint; pDes : pointer;
    flag : integer) : integer; cdecl;


function zend_hash_add(ht : {$IFDEF PHP7}Pzend_array{$ELSE}PHashTable{$ENDIF}; arKey : zend_pchar; nKeyLength : uint; pData : pointer; nDataSize : uint; pDest : pointer) : integer; cdecl;

var
 _zend_hash_init : function (ht : {$IFDEF PHP7}Pzend_array{$ELSE}PHashTable{$ENDIF}; nSize : uint;
   pHashFunction : pointer; pDestructor : pointer; persistent: zend_bool;
   __zend_filename: zend_pchar; __zend_lineno: uint) : integer; cdecl;
 _zend_hash_init_ex : function (ht : {$IFDEF PHP7}Pzend_array{$ELSE}PHashTable{$ENDIF};  nSize : uint;
   pHashFunction : pointer; pDestructor : pointer;  persistent : zend_bool;
   bApplyProtection : zend_bool; __zend_filename: zend_pchar; __zend_lineno: uint): integer; cdecl;

 function zend_hash_init (ht : {$IFDEF PHP7}Pzend_array{$ELSE}PHashTable{$ENDIF}; nSize : uint; pHashFunction : pointer;
   pDestructor : pointer; persistent: zend_bool) : integer; cdecl;
 function zend_hash_init_ex (ht : {$IFDEF PHP7}Pzend_array{$ELSE}PHashTable{$ENDIF};  nSize : uint; pHashFunction : pointer;
 pDestructor : pointer;  persistent : zend_bool;  bApplyProtection : zend_bool): integer; cdecl;

 {$IFDEF PHP7}
 function zend_hash_num_elements(ht: Pzend_array): integer;
 function  add_char_to_string  (_result: Pzval; op1: Pzval; op2: Pzval): Integer;
 function  add_string_to_string(_result: Pzval; op1: Pzval; op2: Pzval): Integer;
 {$ENDIF}
var
  zend_hash_destroy                               : procedure(ht: PHashTable); cdecl;
  zend_hash_clean                                 : procedure(ht: PHashTable); cdecl;

  { additions/updates/changes }




  zend_hash_add_empty_element                     : function(ht: PHashTable; arKey: zend_pchar;
    nKeyLength: uint): Integer; cdecl;




var
  zend_hash_graceful_destroy                      : procedure(ht: PHashTable); cdecl;
  {$IFNDEF PHP7}
  zend_hash_graceful_reverse_destroy              : zend_hash_graceful_reverse_destroy_t;
  {$ENDIF}
  zend_hash_apply                                 : procedure(ht: PHashTable; apply_func: pointer; TSRMLS_DC: Pointer); cdecl;

  zend_hash_apply_with_argument                   : procedure(ht: PHashTable;
    apply_func: pointer; _noname1: Pointer; TSRMLS_DC: Pointer); cdecl;

  { This function should be used with special care (in other words,
   * it should usually not be used).  When used with the ZEND_HASH_APPLY_STOP
   * return value, it assumes things about the order of the elements in the hash.
   * Also, it does not provide the same kind of reentrancy protection that
   * the standard apply functions do.
   }

  zend_hash_reverse_apply                         : procedure(ht: {$IFDEF PHP7} Pzend_array {$ELSE} PHashTable{$ENDIF};
    apply_func: pointer; TSRMLS_DC: Pointer); cdecl;

  { Deletes }

  {$IFDEF PHP7}
  zend_hash_del_key_or_index                      : function(ht: Pzend_array; key:Pzend_string):longint; cdecl;
  {$ELSE}
  zend_hash_del_key_or_index                      : function(ht:  PHashTable; arKey: zend_pchar;
    nKeyLength: uint; h: ulong; flag: Integer): Integer; cdecl;
  {$ENDIF}
  zend_get_hash_value                             : function(ht: {$IFDEF PHP7} Pzend_array {$ELSE} PHashTable{$ENDIF}; arKey: zend_pchar;
    nKeyLength: uint): Longint; cdecl;

  { Data retreival }

  zend_hash_find                                  : function(ht: {$IFDEF PHP7} Pzend_array {$ELSE} PHashTable{$ENDIF}; arKey: zend_pchar; nKeyLength: uint;
    pData: Pointer): Integer; cdecl;

  zend_hash_quick_find                            :
   function(ht: {$IFDEF PHP7} Pzend_array {$ELSE} PHashTable{$ENDIF}; arKey: zend_pchar;
    nKeyLength: uint; h: ulong; out pData: ppzval): Integer; cdecl;

  zend_hash_index_find                            : function(ht: {$IFDEF PHP7} Pzend_array {$ELSE} PHashTable{$ENDIF}; h: ulong; pData: Pointer): Integer; cdecl;

  { Misc }

  zend_hash_exists                                : function(ht: {$IFDEF PHP7}Pzend_array{$ELSE}PHashTable{$ENDIF}; arKey: zend_pchar; nKeyLength: uint): Integer; cdecl;

  zend_hash_index_exists                          : function(ht: {$IFDEF PHP7}Pzend_array{$ELSE}PHashTable{$ENDIF}; h: ulong): Integer; cdecl;
  {$IFNDEF PHP7}
  zend_hash_next_free_element                     : function(ht: {$IFDEF PHP7}Pzend_array{$ELSE}PHashTable{$ENDIF}): Longint; cdecl;
  {$ENDIF}
  { traversing }

  zend_hash_move_forward_ex                       : function(ht: {$IFDEF PHP7}Pzend_array{$ELSE}PHashTable{$ENDIF}; pos: HashPosition): Integer; cdecl;

  zend_hash_move_backwards_ex                     : function(ht: {$IFDEF PHP7}Pzend_array{$ELSE}PHashTable{$ENDIF}; pos: HashPosition): Integer; cdecl;

  zend_hash_get_current_key_ex                    : function(ht: {$IFDEF PHP7}Pzend_array{$ELSE}PHashTable{$ENDIF};
    var str_index: zend_pchar; var str_length: uint; var num_index: ulong;
    duplicate: boolean; pos: HashPosition): Integer; cdecl;

  zend_hash_get_current_key_type_ex               : function(ht: {$IFDEF PHP7}Pzend_array{$ELSE}PHashTable{$ENDIF}; pos: HashPosition): Integer; cdecl;

  zend_hash_get_current_data_ex                   : function(ht: {$IFDEF PHP7}Pzend_array{$ELSE}PHashTable{$ENDIF}; pData: Pointer; pos: HashPosition): Integer; cdecl;

  zend_hash_internal_pointer_reset_ex             : procedure(ht: {$IFDEF PHP7}Pzend_array{$ELSE}PHashTable{$ENDIF}; pos: HashPosition); cdecl;

  zend_hash_internal_pointer_end_ex               : procedure(ht: {$IFDEF PHP7}Pzend_array{$ELSE}PHashTable{$ENDIF}; pos: HashPosition); cdecl;

  { Copying, merging and sorting }

  zend_hash_copy                                  : procedure(target: {$IFDEF PHP7}Pzend_array{$ELSE}PHashTable{$ENDIF}; source: {$IFDEF PHP7}Pzend_array{$ELSE}PHashTable{$ENDIF};
    pCopyConstructor: pointer; tmp: Pointer; size: uint); cdecl;


  zend_hash_sort                                  :
  {$IFDEF PHP7}
  function(ht:PZend_array; sort_func:sort_func_t; compare_func:compare_func_t; renumber:zend_bool):longint; cdecl;
  {$ELSE}
   function(ht: PHashTable; sort_func: pointer;
    compare_func: pointer; renumber: Integer; TSRMLS_DC: Pointer): Integer; cdecl;
  {$ENDIF}

  zend_hash_compare                               : function(ht1: {$IFDEF PHP7}Pzend_array{$ELSE}PHashTable{$ENDIF}; ht2: {$IFDEF PHP7}Pzend_array{$ELSE}PHashTable{$ENDIF};
    compar: pointer; ordered: boolean; TSRMLS_DC: Pointer): Integer; cdecl;

  zend_hash_minmax                                : function(ht: {$IFDEF PHP7}Pzend_array{$ELSE}PHashTable{$ENDIF}; compar: pointer;
    flag: Integer; pData: Pointer; TSRMLS_DC: Pointer): Integer; cdecl;
  {$IFNDEF PHP7}
  zend_hash_num_elements                          : function(ht: {$IFDEF PHP7}Pzend_array{$ELSE}PHashTable{$ENDIF}): Integer; cdecl;
  {$ENDIF}
  zend_hash_rehash                                : function(ht: {$IFDEF PHP7}Pzend_array{$ELSE}PHashTable{$ENDIF}): Integer; cdecl;

  zend_hash_func                                  : function(arKey: zend_pchar; nKeyLength: uint): Longint; cdecl;


function zend_hash_get_current_data(ht: {$IFDEF PHP7} Pzend_array {$ELSE} PHashTable{$ENDIF}; pData: Pointer): Integer; cdecl;
procedure zend_hash_internal_pointer_reset(ht: {$IFDEF PHP7} Pzend_array {$ELSE} PHashTable{$ENDIF}); cdecl;

// zend_constants.h
var
  zend_get_constant                               : function(name: zend_pchar; name_len: uint; var result: zval;
    TSRMLS_DC: Pointer): IntPtr; cdecl;

  zend_register_null_constant                     : procedure(name: zend_pchar; name_len: uint;
    flags: IntPtr; module_number: IntPtr; TSRMLS_DC: Pointer); cdecl;

  zend_register_bool_constant                     : procedure(name: zend_pchar; name_len: uint;
    bval: zend_bool; flags: IntPtr; module_number: IntPtr; TSRMLS_DC: Pointer); cdecl;

  zend_register_long_constant                     : procedure(name: zend_pchar; name_len: uint;
    lval: Longint; flags: IntPtr; module_number: IntPtr; TSRMLS_DC: Pointer); cdecl;

  zend_register_double_constant                   : procedure(name: zend_pchar; name_len: uint;
   dval: Double; flags: IntPtr; module_number: IntPtr; TSRMLS_DC: Pointer); cdecl;

  zend_register_string_constant                   : procedure(name: zend_pchar; name_len: uint;
  strval: zend_pchar; flags: IntPtr; module_number: IntPtr; TSRMLS_DC: Pointer); cdecl;

  zend_register_stringl_constant                  : procedure(name: zend_pchar; name_len: uint;
    strval: zend_pchar; strlen: uint; flags: IntPtr; module_number: IntPtr;
    TSRMLS_DC: Pointer); cdecl;

  zend_register_constant                          : function(var c: zend_constant; TSRMLS_DC: Pointer): IntPtr; cdecl;

  zend_register_auto_global :
  {$IFDEF PHP700}
  function(name:Pzend_string; jit:zend_bool; auto_global_callback:Pointer):longint; cdecl;
  {$ELSE}
    {$IFDEF PHP5}
    function(name: zend_pchar; name_len: uint; jit:boolean; callback: Pointer; TSRMLS_DC: Pointer): Integer; cdecl;
     zend_activate_auto_globals: procedure(TSRMLS_C: Pointer); cdecl;
    {$ELSE}
    function(name: zend_pchar; name_len: uint; callback: Pointer; TSRMLS_DC: Pointer): Integer; cdecl;
    {$ENDIF}
  {$ENDIF}
procedure REGISTER_MAIN_LONG_CONSTANT(name: zend_pchar; lval: longint; flags: integer; TSRMLS_DC: Pointer);
procedure REGISTER_MAIN_DOUBLE_CONSTANT(name: zend_pchar; dval: double; flags: integer; TSRMLS_DC: Pointer);
procedure REGISTER_MAIN_STRING_CONSTANT(name: zend_pchar; str: zend_pchar; flags: integer; TSRMLS_DC: Pointer);
procedure REGISTER_MAIN_STRINGL_CONSTANT(name: zend_pchar; str: zend_pchar; len: uint; flags: integer; TSRMLS_DC: Pointer);


var
  tsrm_startup                                    : function(expected_threads: integer;
    expected_resources: integer; debug_level: integer; debug_filename: zend_pchar): integer; cdecl;

  ts_allocate_id                                  : function(rsrc_id: pts_rsrc_id; size: size_t; ctor: pointer; dtor: pointer): ts_rsrc_id; cdecl;
  // deallocates all occurrences of a given id
  ts_free_id                                      : procedure(id: ts_rsrc_id); cdecl;

  tsrm_shutdown                                   : procedure; cdecl;
  ts_resource_ex                                  : function(id: integer; p: pointer): pointer; cdecl;
  ts_free_thread                                  : procedure; cdecl;

  zend_error                                      : procedure(ErrType: integer; ErrText: zend_pchar); cdecl;
  zend_error_cb                                   : procedure; cdecl;

  zend_eval_string                                : function(str: zend_pchar; ret_val: pointer; strname: zend_pchar; tsrm: pointer): integer; cdecl;
  zend_eval_string_ex                             : function(str:PAnsiChar;  retval_ptr:pzval; string_name:PAnsiChar; handle_exceptions:longint):longint; cdecl;
  zend_make_compiled_string_description           : function(a: zend_pchar; tsrm: pointer): zend_pchar; cdecl;
  _zval_copy_ctor_func                            : procedure(val: pzval; __zend_filename: zend_pchar; __zend_lineno: uint); cdecl;
  _zval_dtor_func                                 : procedure(val: pzval; __zend_filename: zend_pchar; __zend_lineno: uint); cdecl;
  _zval_ptr_dtor: procedure(val: ppzval;  __zend_filename: zend_pchar); cdecl;
  procedure  _zval_copy_ctor (val: pzval; __zend_filename: zend_pchar; __zend_lineno: uint); cdecl;
  procedure _zval_dtor(val: pzval; __zend_filename: zend_pchar; __zend_lineno: uint); cdecl;

var
  zend_print_variable                             : function(val: pzval): integer; cdecl;


  zend_get_compiled_filename : function(TSRMLS_DC: Pointer): zend_pchar; cdecl;
  zend_get_compiled_lineno   : function(TSRMLS_DC: Pointer): integer; cdecl;

function ts_resource(id : integer) : pointer;
function tsrmls_fetch : pointer;

//procedure zenderror(Error : zend_pchar);

var
  zend_stack_init                                 : function(stack: Pzend_stack): Integer; cdecl;

  zend_stack_push                                 : function(stack: Pzend_stack; element: Pointer; size: Integer): Integer; cdecl;

  zend_stack_top                                  : function(stack: Pzend_stack; element: Pointer): Integer; cdecl;

  zend_stack_del_top                              : function(stack: Pzend_stack): Integer; cdecl;

  zend_stack_int_top                              : function(stack: Pzend_stack): Integer; cdecl;

  zend_stack_is_empty                             : function(stack: Pzend_stack): Integer; cdecl;

  zend_stack_destroy                              : function(stack: Pzend_stack): Integer; cdecl;

  zend_stack_base                                 : function(stack: Pzend_stack): Pointer; cdecl;

  zend_stack_count                                : function(stack: Pzend_stack): Integer; cdecl;

  zend_stack_apply                                : procedure(stack: Pzend_stack; _type: Integer; apply_function: Integer); cdecl;

  zend_stack_apply_with_argument                  : procedure(stack: Pzend_stack; _type: Integer; apply_function: Integer; arg: Pointer); cdecl;


  //zend_operators.h

var
  _convert_to_string                              : procedure(op: pzval; __zend_filename: zend_pchar; __zend_lineno: uint); cdecl;

procedure convert_to_string(op: pzval);

var
  add_function                                    : function(_result: Pzval; op1: Pzval; op2: Pzval; TSRMLS_DC: Pointer): Integer; cdecl;

  sub_function                                    : function(_result: Pzval; op1: Pzval; op2: Pzval; TSRMLS_DC: Pointer): Integer; cdecl;

  mul_function                                    : function(_result: Pzval; op1: Pzval; op2: Pzval; TSRMLS_DC: Pointer): Integer; cdecl;

  div_function                                    : function(_result: Pzval; op1: Pzval; op2: Pzval; TSRMLS_DC: Pointer): Integer; cdecl;

  mod_function                                    : function(_result: Pzval; op1: Pzval; op2: Pzval; TSRMLS_DC: Pointer): Integer; cdecl;

  boolean_xor_function                            : function(_result: Pzval; op1: Pzval; op2: Pzval; TSRMLS_DC: Pointer): Integer; cdecl;

  boolean_not_function                            : function(_result: Pzval; op1: Pzval): Integer; cdecl;

  bitwise_not_function                            : function(_result: Pzval; op1: Pzval): Integer; cdecl;

  bitwise_or_function                             : function(_result: Pzval; op1: Pzval; op2: Pzval; TSRMLS_DC: Pointer): Integer; cdecl;

  bitwise_and_function                            : function(_result: Pzval; op1: Pzval; op2: Pzval; TSRMLS_DC: Pointer): Integer; cdecl;

  bitwise_xor_function                            : function(_result: Pzval; op1: Pzval; op2: Pzval; TSRMLS_DC: Pointer): Integer; cdecl;

  shift_left_function                             : function(_result: Pzval; op1: Pzval; op2: Pzval; TSRMLS_DC: Pointer): Integer; cdecl;

  shift_right_function                            : function(_result: Pzval; op1: Pzval; op2: Pzval; TSRMLS_DC: Pointer): Integer; cdecl;

  concat_function                                 : function(_result: Pzval; op1: Pzval; op2: Pzval; TSRMLS_DC: Pointer): Integer; cdecl;

  is_equal_function                               : function(_result: Pzval; op1: Pzval; op2: Pzval; TSRMLS_DC: Pointer): Integer; cdecl;

  is_identical_function                           : function(_result: Pzval; op1: Pzval; op2: Pzval; TSRMLS_DC: Pointer): Integer; cdecl;

  is_not_identical_function                       : function(_result: Pzval; op1: Pzval; op2: Pzval; TSRMLS_DC: Pointer): Integer; cdecl;

  is_not_equal_function                           : function(_result: Pzval; op1: Pzval; op2: Pzval; TSRMLS_DC: Pointer): Integer; cdecl;

  is_smaller_function                             : function(_result: Pzval; op1: Pzval; op2: Pzval; TSRMLS_DC: Pointer): Integer; cdecl;

  is_smaller_or_equal_function                    : function(_result: Pzval; op1: Pzval; var op2: zval; TSRMLS_DC: Pointer): Integer; cdecl;

  increment_function                              : function(op1: Pzval): Integer; cdecl;

  decrement_function                              : function(op2: Pzval): Integer; cdecl;

  convert_scalar_to_number                        : procedure(op: Pzval; TSRMLS_DC: Pointer); cdecl;

  convert_to_long                                 : procedure(op: Pzval); cdecl;

  convert_to_double                               : procedure(op: Pzval); cdecl;

  convert_to_long_base                            : procedure(op: Pzval; base: Integer); cdecl;

  convert_to_null                                 : procedure(op: Pzval); cdecl;

  convert_to_boolean                              : procedure(op: Pzval); cdecl;

  convert_to_array                                : procedure(op: Pzval); cdecl;

  convert_to_object                               : procedure(op: Pzval); cdecl;
  {$IFNDEF PHP7}
  add_char_to_string                              : function(_result: Pzval; op1: Pzval; op2: Pzval): Integer; cdecl;

  add_string_to_string                            : function(_result: Pzval; op1: Pzval; op2: Pzval): Integer; cdecl;
  {$ENDIF}
  zend_string_to_double                           : function(number: zend_pchar; length: zend_uint): Double; cdecl;

  zval_is_true                                    : function(op: Pzval): Integer; cdecl;

  compare_function                                : function(_result: Pzval; op1: Pzval; op2: Pzval; TSRMLS_DC: Pointer): Integer; cdecl;

  numeric_compare_function                        : function(_result: Pzval; op1: Pzval; op2: Pzval; TSRMLS_DC: Pointer): Integer; cdecl;

  string_compare_function                         : function(_result: Pzval; op1: Pzval; op2: Pzval; TSRMLS_DC: Pointer): Integer; cdecl;

  zend_str_tolower                                : procedure(str: zend_pchar; length: Integer); cdecl;

  zend_binary_zval_strcmp                         : function(s1: Pzval; s2: Pzval): Integer; cdecl;

  zend_binary_zval_strncmp                        : function(s1: Pzval; s2: Pzval; s3: Pzval): Integer; cdecl;

  zend_binary_zval_strcasecmp                     : function(s1: Pzval; s2: Pzval): Integer; cdecl;

  zend_binary_zval_strncasecmp                    : function(s1: Pzval; s2: Pzval; s3: Pzval): Integer; cdecl;

  zend_binary_strcmp                              : function(s1: zend_pchar; len1: uint; s2: zend_pchar; len2: uint): Integer; cdecl;

  zend_binary_strncmp                             : function(s1: zend_pchar; len1: uint; s2: zend_pchar; len2: uint; length: uint): Integer; cdecl;

  zend_binary_strcasecmp                          : function(s1: zend_pchar; len1: uint; s2: zend_pchar; len2: uint): Integer; cdecl;

  zend_binary_strncasecmp                         : function(s1: zend_pchar; len1: uint; s2: zend_pchar; len2: uint; length: uint): Integer; cdecl;

  zendi_smart_strcmp                              : procedure(_result: zval; s1: Pzval; s2: Pzval); cdecl;

  zend_compare_symbol_tables                      : procedure(_result: Pzval; ht1: PHashTable; ht2: PHashTable; TSRMLS_DC: Pointer); cdecl;

  zend_compare_arrays                             : procedure(_result: zval; a1: Pzval; a2: Pzval; TSRMLS_DC: Pointer); cdecl;

  zend_compare_objects                            : procedure(_result: Pzval; o1: Pzval; o2: Pzval; TSRMLS_DC: Pointer); cdecl;

  zend_atoi                                       : function(str: zend_pchar; str_len: Integer): Integer; cdecl;

  //zend_execute.h
  get_active_function_name                        : function(TSRMLS_D: pointer): zend_pchar; cdecl;

  zend_get_executed_filename                      : function(TSRMLS_D: pointer): zend_pchar; cdecl;

  zend_get_executed_lineno                        : function(TSRMLS_DC: pointer): uint; cdecl;

  zend_set_timeout                                : procedure(seconds: Longint); cdecl;

  zend_unset_timeout                              : procedure(TSRMLS_D: pointer); cdecl;

  zend_timeout                                    : procedure(dummy: Integer); cdecl;


var
  zend_highlight                                  : procedure(syntax_highlighter_ini: Pzend_syntax_highlighter_ini; TSRMLS_DC: Pointer); cdecl;

  zend_strip                                      : procedure(TSRMLS_D: pointer); cdecl;

  highlight_file                                  : function(filename: zend_pchar; syntax_highlighter_ini: Pzend_syntax_highlighter_ini; TSRMLS_DC: Pointer): Integer; cdecl;

  highlight_string                                : function(str: Pzval; syntax_highlighter_ini: Pzend_syntax_highlighter_ini; str_name: zend_pchar; TSRMLS_DC: Pointer): Integer; cdecl;

  zend_html_putc                                  : procedure(c: zend_uchar); cdecl;

  zend_html_puts                                  : procedure(s: zend_pchar; len: uint; TSRMLS_DC: Pointer); cdecl;

  	zend_parse_method_parameters:function(num_args:longint; TSRMLS_DC:Pointer; this_ptr:Pzval; type_spec:PAnsiChar):longint; cdecl varargs;

	zend_parse_method_parameters_ex:function(flags:longint; num_args:longint; TSRMLS_DC:Pointer; this_ptr:Pzval; type_spec:PAnsiChar):longint; cdecl varargs;

  {$IFDEF PHP7}
  zend_parse_parameters_throw                     : function(num_args:longint; type_spec:PAnsiChar):longint; cdecl varargs;
  {$ELSE}
  zend_indent                                     : procedure; cdecl;
  {$ENDIF}
  Zend_Get_Parameters                               : function(ht:longint; param_count:longint):longint; cdecl varargs;
  zend_get_params_ex :
  {$IFDEF PHP7}
  function(param_count:longint):longint; cdecl varargs;
  {$ELSE}
  function(param_count : Integer; Args : ppzval): integer; cdecl varargs;
  {$ENDIF}
  {$IFDEF PHP7}
   ZvalGetArgs: function(Count: Integer; Args: ppzval): Integer;cdecl varargs;
	_zend_get_parameters_array_ex:function(param_count:longint; argument_array:Pzval):longint; cdecl;
  {$ELSE}
  _zend_get_parameters_array: function(ht: integer; param_count:longint; argument_array: ppzval; TSRMLS_DC: pointer): integer; cdecl;
  _zend_get_parameters_array_ex : function(param_count: integer; argument_array:
  pppzval; TSRMLS_CC: pointer): integer; cdecl;
  {$ENDIF}
function zend_get_parameters_my(number: integer; var Params: pzval_array; TSRMLS_DC: Pointer): integer;


procedure dispose_pzval_array(Params: pzval_array);

var
  zend_ini_refresh_caches                         : procedure(stage: Integer; TSRMLS_DC: Pointer); cdecl;


var
  _zend_bailout                                   : procedure (filename : zend_pchar; lineno : uint); cdecl;

  zend_alter_ini_entry                            : function(name: PAnsiChar; name_length: uint; new_value: PAnsiChar; new_value_length: uint; modify_type: Integer; stage: Integer): Integer; cdecl;
  zend_alter_ini_entry_ex                            : function(name: zend_pchar; name_length: uint; new_value: zend_pchar; new_value_length: uint; modify_type: Integer; stage: Integer; force_change: integer): Integer; cdecl;

  zend_restore_ini_entry                          : function(name: zend_pchar; name_length: uint; stage: Integer): Integer; cdecl;

  zend_ini_long                                   : function(name: zend_pchar; name_length: uint; orig: Integer): Longint; cdecl;

  zend_ini_double                                 : function(name: zend_pchar; name_length: uint; orig: Integer): Double; cdecl;

  zend_ini_string                                 : function(name: zend_pchar; name_length: uint; orig: Integer): zend_pchar; cdecl;

  compile_string                                  : function(source_string: pzval; filename: zend_pchar; TSRMLS_DC: Pointer): pointer; cdecl;

  execute                                         : procedure(op_array: pointer; TSRMLS_DC: Pointer); cdecl;

  zend_wrong_param_count                          : procedure(TSRMLS_D: pointer); cdecl;
  _zend_hash_quick_add_or_update:function(ht: {$IFDEF PHP7}Pzend_array{$ELSE}PHashTable{$ENDIF}; arKey: zend_pchar; nKeyLength: uint; h: uint; out pData: pzval; nDataSize: uint; pDest: PPointer; flag: Integer) : Integer; cdecl;
  add_property_long_ex                            : function(arg: pzval; key: zend_pchar; key_len: uint; l: longint; TSRMLS_DC : pointer): integer; cdecl;

  add_property_null_ex                            : function(arg: pzval; key: zend_pchar; key_len: uint; TSRMLS_DC: Pointer): integer; cdecl;
  add_property_bool_ex                            : function(arg: pzval; key: zend_pchar; key_len: uint; b: integer; TSRMLS_DC: Pointer): integer; cdecl;
  add_property_resource_ex                        : function(arg: pzval; key: zend_pchar; key_len: uint; r: integer; TSRMLS_DC: Pointer): integer; cdecl;
  add_property_double_ex                          : function(arg: pzval; key: zend_pchar; key_len: uint; d: double; TSRMLS_DC: Pointer): integer; cdecl;
  add_property_string_ex                          : function(arg: pzval; key: zend_pchar; key_len: uint; str: zend_pchar; duplicate: integer; TSRMLS_DC: Pointer): integer; cdecl;
  add_property_stringl_ex                         : function(arg: pzval; key: zend_pchar; key_len: uint; str: zend_pchar; len: uint; duplicate: integer; TSRMLS_DC: Pointer): integer; cdecl;
  add_property_zval_ex                            : function(arg: pzval; key: zend_pchar; key_len: uint; value: pzval; TSRMLS_DC: Pointer): integer; cdecl;

  {$IFDEF CUTTED_PHP7dll}
  call_user_function : procedure(func:pzval; argv:pzval; argc:integer);cdecl;
  {$ELSE}
   call_user_function : function(function_table: PHashTable; object_pp: pzval;
                         function_name: pzval; return_ptr: pzval; param_count: zend_uint; params: pzval_array_ex;
                          TSRMLS_DC: Pointer): integer; cdecl;

  call_user_function_ex : function(function_table: PHashTable; object_pp: pzval;
                         function_name: pzval; return_ptr_ptr: {$IFNDEF PHP700} ppzval {$ELSE} pzval{$ENDIF}; param_count: zend_uint;
                         params: pzval_array;
                         no_separation: zend_uint; symbol_table: PHashTable;
                          TSRMLS_DC: Pointer): integer; cdecl;
  {$ENDIF}


  add_assoc_long_ex                               : function(arg: pzval; key: zend_pchar; key_len: uint; n: longint): integer; cdecl;
  add_assoc_null_ex                               : function(arg: pzval; key: zend_pchar; key_len: uint): integer; cdecl;
  add_assoc_bool_ex                               : function(arg: pzval; key: zend_pchar; key_len: uint; b: integer): integer; cdecl;
  add_assoc_resource_ex                           : function(arg: pzval; key: zend_pchar; key_len: uint; r: integer): integer; cdecl;
  add_assoc_double_ex                             : function(arg: pzval; key: zend_pchar; key_len: uint; d: double): integer; cdecl;
  add_assoc_string_ex                             : function(arg: pzval; key: zend_pchar; key_len: uint; str: zend_pchar; duplicate: integer): integer; cdecl;
  add_assoc_stringl_ex                            : function(arg: pzval; key: zend_pchar; key_len: uint; str: zend_pchar; len: uint; duplicate: integer): integer; cdecl;
  add_assoc_zval_ex                               : function(arg: pzval; key: zend_pchar; key_len: uint; value: pzval): integer; cdecl;

  add_index_long                                  : function(arg: pzval; idx: uint; n: longint): integer; cdecl;
  add_index_null                                  : function(arg: pzval; idx: uint): integer; cdecl;
  add_index_bool                                  : function(arg: pzval; idx: uint; b: integer): integer; cdecl;
  add_index_resource                              : function(arg: pzval; idx: uint; r: integer): integer; cdecl;
  add_index_double                                : function(arg: pzval; idx: uint; d: double): integer; cdecl;
  add_index_string                                : function(arg: pzval; idx: uint; str: zend_pchar; duplicate: integer): integer; cdecl;
  add_index_stringl                               : function(arg: pzval; idx: uint; str: zend_pchar; len: uint; duplicate: integer): integer; cdecl;
  add_index_zval                                  : function(arg: pzval; index: uint; value: pzval): integer; cdecl;

  add_next_index_long                             : function(arg: pzval; n: longint): integer; cdecl;
  add_next_index_null                             : function(arg: pzval): integer; cdecl;
  add_next_index_bool                             : function(arg: pzval; b: integer): integer; cdecl;
  add_next_index_resource                         : function(arg: pzval; r: integer): integer; cdecl;
  add_next_index_double                           : function(arg: pzval; d: double): integer; cdecl;
  add_next_index_string                           : function(arg: pzval; str: zend_pchar; duplicate: integer): integer; cdecl;
  add_next_index_stringl                          : function(arg: pzval; str: zend_pchar; len: uint; duplicate: integer): integer; cdecl;
  add_next_index_zval                             : function(arg: pzval; value: pzval): integer; cdecl;

  add_get_assoc_string_ex                         : function(arg: pzval; key: zend_pchar; key_len: uint; str: zend_pchar; dest: pointer; duplicate: integer): integer; cdecl;
  add_get_assoc_stringl_ex                        : function(arg: pzval; key: zend_pchar; key_len: uint; str: zend_pchar; len: uint; dest: pointer; duplicate: integer): integer; cdecl;

  add_get_index_long                              : function(arg: pzval; idx: uint; l: longint; dest: pointer): integer; cdecl;
  add_get_index_double                            : function(arg: pzval; idx: uint; d: double; dest: pointer): integer; cdecl;
  add_get_index_string                            : function(arg: pzval; idx: uint; str: zend_pchar; dest: pointer; duplicate: integer): integer; cdecl;
  add_get_index_stringl                           : function(arg: pzval; idx: uint; str: zend_pchar; len: uint; dest: pointer; duplicate: integer): integer; cdecl;

  _array_init                                     : function(arg: pzval; __zend_filename: zend_pchar; __zend_lineno: uint): integer; cdecl;

  _object_init                                    : function(arg: pzval;TSRMLS_DC: pointer): integer; cdecl;

  _object_init_ex                                 : function (arg: pzval; ce: pzend_class_entry; __zend_lineno : integer; TSRMLS_DC : pointer) : integer; cdecl;

  _object_and_properties_init                     : function(arg: pzval; ce: pointer; properties: phashtable; __zend_filename: zend_pchar; __zend_lineno: uint; TSRMLS_DC: pointer): integer; cdecl;


  {$IFDEF PHP5}
  zend_destroy_file_handle : procedure(file_handle : PZendFileHandle; TSRMLS_DC : pointer); cdecl;
  {$ENDIF}

var
  zend_write                                      : zend_write_t;

procedure ZEND_PUTS(str: zend_pchar);

type
  TObjectAConvertMethod = procedure(v:variant;z:pzval);
  TObjectBConvertMethod = function(a: pzval):Variant;

var
  zend_register_internal_class     : function(class_entry: pzend_class_entry; TSRMLS_DC: pointer): Pzend_class_entry; cdecl;
  zend_register_internal_class_ex  : function(class_entry: pzend_class_entry; parent_ce: pzend_class_entry; parent_name: zend_pchar; TSRMLS_DC: pointer): Pzend_class_entry; cdecl;
  zend_startup_module              : function(module_entry: Pzend_module_entry):integer; cdecl;
  zend_startup_module_ex           : function(module_entry: Pzend_module_entry; TSRMLS_DC: pointer):integer; cdecl;
  zend_register_module_ex          : function(module_entry: Pzend_module_entry; TSRMLS_DC: pointer): Pzend_module_entry;cdecl;
  zend_register_internal_module    : function(module_entry: Pzend_module_entry; TSRMLS_DC: pointer): Pzend_module_entry;cdecl;
  zend_startup_modules             : function(TSRMLS_DC:pointer):integer;
  zend_collect_module_handlers     : function(TSRMLS_DC:pointer):integer;
  function ZvalInt(z:zval):Integer;
  function ZvalDouble(z:zval):Double;
  function ZvalBool(z:zval):Boolean;

  function ZvalStrS(z:zval) : string;
  function ZvalStr(z:zval)  : zend_ustr;
  function ZvalStrW(z:zval) : WideString;

  procedure ZvalVAL(z:pzval; v:Boolean) overload;
  procedure ZvalVAL(z:pzval; v:Integer; const _type:Integer = IS_LONG) overload;
  procedure ZvalVAL(z:pzval) overload;
  procedure ZvalVAL(z:pzval; v:Double) overload;
  procedure ZvalVAL(z:pzval; v:SmallInt) overload;
  procedure ZvalVAL(z:pzval; v:Extended) overload;
  procedure ZvalVAL(z: pzval; s: zend_ustr; len: Integer = 0); overload;
  procedure ZvalString(z:pzval) overload;
  procedure ZvalString(z:pzval; s:zend_pchar; len:Integer = 0) overload;
  procedure ZvalString(z:pzval; s:PWideChar; len:Integer = 0) overload;
  procedure ZvalString(z:pzval; s:string; len:Integer = 0) overload;

function ZvalArrayAdd(z: pzval; Args: array of const): Integer; overload;
function ZvalArrayAdd(z: pzval; idx: Integer; Args: array of const)
  : Integer; overload;
function ZvalArrayAdd(z: pzval; key: zend_ustr; Args: array of const)
  : Integer; overload;

function ZValArrayKeyExists(v: pzval; key: zend_ustr): Boolean; overload;
function ZValArrayKeyExists(v: pzval; key: zend_ustr; out pData: pzval)
  : Boolean; overload;
function ZValArrayKeyExists(v: pzval; idx: Integer): Boolean; overload;
function ZValArrayKeyExists(v: pzval; idx: Integer; out pData: pzval)
  : Boolean; overload;
function ZValArrayKeyDel(v: pzval; key: zend_ustr): Boolean; overload;
function ZValArrayKeyDel(v: pzval; idx: Integer): Boolean; overload;

function ZValArrayKeyFind(v: pzval; key: zend_ustr; out pData: ppzval)
  : Boolean; overload;
function ZValArrayKeyFind(v: pzval; idx: Integer; out pData: ppzval)
  : Boolean; overload;

 function GetArgPZval(Args: TVarRec; const _type: Integer = IS_LONG;
  Make: Boolean = false): pzval;
procedure ZVAL_RESOURCE(value: pzval; l: longint);
procedure ZVAL_EMPTY_STRING(z: pzval);

function add_next_index_variant(arg: pzval; value: variant): integer;
function add_index_variant(arg: pzval; index:integer; value: variant): integer;
function add_assoc_variant(arg: pzval; key: zend_pchar; key_len: uint; value: variant): integer;

procedure ZVAL_ARRAY(z: pzval; arr:  TWSDate); overload;
procedure ZVAL_ARRAY(z: pzval; arr:  TASDate); overload;
procedure ZVAL_ARRAY(z: pzval; arr:  array of string); overload;
procedure ZVAL_ARRAY(z: pzval; arr:  array of zend_ustr); overload;
procedure ZVAL_ARRAY(z: pzval; arr: array of variant); overload;
procedure ZVAL_ARRAY(z: pzval; arr: System.TArray<System.integer>); overload;
procedure ZVAL_ARRAY(z: pzval; arr: Variant); overload;
procedure ZVAL_ARRAYAC(z: pzval; keynames: Array of AnsiChar; keyvals: Array of AnsiChar);
procedure ZVAL_ARRAYWC(z: pzval; keynames: Array of PWideChar; keyvals: Array of PWideChar);
procedure ZVAL_ARRAYAS(z: pzval; keynames: Array of AnsiString; keyvals: Array of AnsiString); overload;
procedure ZVAL_ARRAYAS(z: pzval; keynames: TASDate; keyvals: TASDate);  overload;
procedure ZVAL_ARRAYWS(z: pzval; keynames: TWSDate; keyvals: TWSDate);  overload;
procedure ZVAL_ARRAYWS(z: pzval; keynames: array of string; keyvals: array of string); overload;
procedure HashToArray(HT: {$IFDEF PHP7}Pzend_array{$ELSE}PHashTable{$ENDIF}; var AR: TArrayVariant); overload;
procedure ArrayToHash(AR: Array of Variant; var HT: pzval); overload;
procedure ArrayToHash(Keys,AR: Array of Variant; var HT: pzval); overload;
function ToStrA(V: Variant): zend_ustr;
function ToStr(V: Variant): String;
function toWChar(s: zend_pchar): PWideChar;
function ZendToVariant(const Value: pzval;cobj: TObjectBConvertMethod=nil): Variant;
{$IFNDEF PHP7}
overload;
function ZendToVariant(const Value: ppzval;cobj: TObjectBConvertMethod=nil): Variant; overload;
function ZendToVariant(const Value: pppzval;cobj: TObjectBConvertMethod=nil): Variant; overload;
{$ENDIF}
procedure VariantToZend(const Value: Variant; z: pzval;
cobj: TObjectAConvertMethod=nil);
procedure ZVAL_STRING(z: pzval; s: zend_pchar; duplicate: boolean);
procedure ZVAL_STRINGU(z: pzval; s: PUtf8Char; duplicate: boolean);
procedure ZVAL_STRINGW(z: pzval; s: PWideChar; duplicate: boolean);

procedure ZVAL_STRINGL(z: pzval; s: zend_pchar; l: integer; duplicate: boolean);
procedure ZVAL_STRINGLW(z: pzval; s: PWideChar; l: integer; duplicate: boolean);

procedure INIT_CLASS_ENTRY(var class_container: Tzend_class_entry; class_name: zend_pchar; functions:
{$IFDEF PHP7}HashTable{$ELSE}pointer{$ENDIF});
procedure zend_copy_constant(c: zend_constant);
{$IF defined(PHP540) or defined(PHP550) or defined(PHP560)}
procedure zend_copy_constants(target: PHashTable; source: PHashTable); cdecl;
procedure zend_class_add_ref(aclass: Ppzend_class_entry); cdecl;
{$ENDIF}

var
  get_zend_version           : function(): zend_pchar; cdecl;
  zend_make_printable_zval   : procedure(expr: pzval; expr_copy: pzval; use_copy: pint); cdecl;
  zend_print_zval            : function(expr: pzval; indent: integer): integer; cdecl;
  zend_print_zval_r          : procedure(expr: pzval; indent: integer); cdecl;
  zend_output_debug_string   : procedure(trigger_break: boolean; Msg: zend_pchar); cdecl;

{$IFDEF PHP5}
  {$IF not defined(PHP540) and not defined(PHP550) and not defined(PHP560)}
  zend_copy_constants: procedure(target: PHashTable; source: PHashTable); cdecl;
  {$ENDIF}
  zend_objects_new : function (_object : pointer; class_type : pointer; TSRMLS_DC : pointer) : {$IFDEF PHP7}zend_object{$ELSE}_zend_object_value{$ENDIF}; cdecl;
  zend_objects_clone_obj: function(_object: pzval; TSRMLS_DC : pointer): {$IFDEF PHP7}zend_object{$ELSE}_zend_object_value{$ENDIF}; cdecl;
  zend_objects_store_add_ref: procedure (_object : pzval; TSRMLS_DC : pointer); cdecl;
  zend_objects_store_del_ref: procedure (_object : pzval; TSRMLS_DC : pointer); cdecl;

  function_add_ref: procedure (func: {$IFDEF PHP7}Pzend_function{$ELSE}PZendFunction{$ENDIF}); cdecl;
  {$IF not defined(PHP540) and not defined(PHP550) and not defined(PHP560)}
  zend_class_add_ref: procedure(aclass: Ppzend_class_entry); cdecl;
  {$ENDIF}

{$ENDIF}

{$IFNDEF COMPILER_VC9}
const
  MSCRT = 'msvcrt.dll';

//Microsoft C++ functions
function  strdup(strSource : zend_pchar) : zend_pchar; cdecl; external MSCRT name '_strdup';
{$ELSE}
function  DupStr(strSource : zend_pchar) : zend_pchar; cdecl;
{$ENDIF}
{$IFNDEF PHP7}
function ZEND_FAST_ALLOC: pzval;
function ALLOC_ZVAL: pzval; overload;
procedure ALLOC_ZVAL(out Result: pzval); overload;
{$ENDIF}
procedure INIT_PZVAL(p: pzval);
function MAKE_STD_ZVAL: pzval; overload;
procedure MAKE_STD_ZVAL(out Result: pzval); overload;

var
  PHPLib : THandle = 0;

var
 zend_ini_deactivate : function(TSRMLS_D : pointer) : integer; cdecl;

function GetGlobalResource(resource_name: AnsiString) : pointer;
function GetGlobalResourceDC(resource_name: AnsiString;TSRMLS_DC:pointer) : pointer;
function GetCompilerGlobals : Pzend_compiler_globals;
function GetExecutorGlobals : pzend_executor_globals;
function GetAllocGlobals : pointer;

function zend_register_functions(functions : {$IFDEF PHP7}P_zend_function_entry{$ELSE}pzend_function_entry{$ENDIF};  function_table :  {$IFDEF PHP7} Pzend_array {$ELSE} PHashTable{$ENDIF}; _type: integer;  TSRMLS_DC : pointer) : integer;
function zend_unregister_functions(functions : {$IFDEF PHP7}P_zend_function_entry{$ELSE}pzend_function_entry{$ENDIF}; count : integer; function_table :  {$IFDEF PHP7} Pzend_array {$ELSE} PHashTable{$ENDIF}; TSRMLS_DC : pointer) : integer;

{$IFDEF PHP5}

var
  zend_get_std_object_handlers : function() : {$IFDEF PHP7}P_zend_object_handlers{$ELSE}pzend_object_handlers{$ENDIF};
  zend_objects_get_address : function (_object : pzval; TSRMLS_DC : pointer) : pzend_object; cdecl;
  zend_is_true : function(z : pzval) : integer; cdecl;

function object_init(arg: pzval; ce: pzend_class_entry; TSRMLS_DC : pointer) : integer; cdecl; assembler;
function Z_LVAL(z : Pzval) : longint;
function Z_BVAL(z : Pzval) : boolean;
function Z_DVAL(z : Pzval) : double;
function Z_STRVAL(z : Pzval) : zend_ustr;
function Z_STRUVAL(z : PZval): UTF8String;
function Z_STRWVAL(z : pzval) : String;
function Z_CHAR(z: PZval) : zend_uchar;
function Z_WCHAR(z: PZval) : WideChar;
function Z_ACHAR(z: PZVAL): AnsiChar;
function Z_UCHAR(z: PZVAL): UTF8Char;

function Z_STRLEN(z : Pzval) : longint;
function Z_ARRVAL(z : Pzval ) : PHashTable;
function Z_OBJ_HANDLE(z :Pzval) : {$IFDEF PHP7} P_zend_object_handlers {$ELSE} zend_object_handle{$ENDIF};
function Z_OBJ_HT(z : Pzval) : {$IFDEF PHP7}P_zend_object_handlers{$ELSE}pzend_object_handlers{$ENDIF};
function Z_OBJPROP(z : Pzval;TSRMLS_DC:pointer=nil) : PHashTable;
function Z_VARREC(z: pzval): TVarRec;

 procedure zend_addref_p(z: pzval); cdecl;
 procedure my_class_add_ref(aclass: Ppzend_class_entry); cdecl;
 procedure copy_zend_constant(C: PZendConstant); cdecl;


{$ENDIF}

implementation


function zend_hash_add(ht : {$IFDEF PHP7}Pzend_array{$ELSE}PHashTable{$ENDIF}; arKey : zend_pchar; nKeyLength : uint; pData : pointer; nDataSize : uint; pDest : pointer) : integer; cdecl;
begin
  result := zend_hash_add_or_update(ht, arKey, nKeyLength, pData, nDataSize, pDest, HASH_ADD);
end;

{$IFDEF PHP7}
function zend_hash_num_elements(ht: Pzend_array): integer;
  begin
    Result := integer(ht.nNumOfElements);
  end;
function  add_char_to_string  (_result: Pzval; op1: Pzval; op2: Pzval): Integer;
Begin
  Result := -1;
  if op1.u1.v._type = IS_STRING then
  begin
    _result.value.str.len := op1.value.str.len + op2.value.str.len;
    _result.value.str.val := zend_pchar(zend_ustr(op1.value.str.val) + zend_ustr(op2.value.str.val));
    Result := SUCCESS;
  end;
End;
function  add_string_to_string(_result: Pzval; op1: Pzval; op2: Pzval): Integer;
begin
  Result := add_char_to_string(_result, op1, op2);
end;
{$ENDIF}

function STR_EMPTY_ALLOC : zend_pchar;
begin
  Result := estrndup('', 0);
end;

function estrndup(s: zend_pchar; len: Cardinal): zend_pchar;
begin
  if assigned(s) then
    Result := _estrndup(s, len, nil, 0, nil, 0)
     else
      Result := nil;
end;
function estrndupu(s: PUtf8Char; len: Cardinal): PUTf8Char;
begin
  if assigned(s) then
    Result := _estrndupu(s, len, nil, 0, nil, 0)
     else
      Result := nil;
end;
function emalloc(size: size_t): pointer;
begin
  Result := _emalloc(size, nil, 0, nil, 0);
end;

procedure efree(ptr: pointer);
begin
  _efree(ptr, nil, 0, nil, 0);
end;

function ecalloc(nmemb: size_t; size: size_t): pointer;
begin
  Result := _ecalloc(nmemb, size, nil, 0, nil, 0);
end;

function erealloc(ptr: pointer; size: size_t; allow_failure: integer): pointer;
begin
  Result := _erealloc(ptr, size, allow_failure, nil, 0, nil, 0);
end;

function estrdup(const s: zend_pchar): zend_pchar;
begin
  if assigned(s) then
  begin
   Result := _estrdup(s, nil, 0, nil, 0);
  end
    else
     Result := nil;
end;


procedure REGISTER_MAIN_LONG_CONSTANT(name: zend_pchar; lval: longint; flags: integer; TSRMLS_DC: Pointer);
begin
  zend_register_long_constant(name, length(name) + 1, lval, flags, 0, TSRMLS_DC);
end;

procedure REGISTER_MAIN_DOUBLE_CONSTANT(name: zend_pchar; dval: double; flags: integer; TSRMLS_DC: Pointer);
begin
  zend_register_double_constant(name, length(name) + 1, dval, flags, 0, TSRMLS_DC);
end;

procedure REGISTER_MAIN_STRING_CONSTANT(name: zend_pchar; str: zend_pchar; flags: integer; TSRMLS_DC: Pointer);
begin
  zend_register_string_constant(name, length(name) + 1, str, flags, 0, TSRMLS_DC);
end;

procedure REGISTER_MAIN_STRINGL_CONSTANT(name: zend_pchar; str: zend_pchar; len: uint; flags: integer; TSRMLS_DC: Pointer);
begin
  zend_register_stringl_constant(name, length(name) + 1, str, len, flags, 0, TSRMLS_DC);
end;

procedure ZVAL_RESOURCE(value: pzval; l: longint);
begin
  {$IFDEF PHP7}
  value^.u1.v._type
  {$ELSE}
  value^._type
  {$ENDIF} := IS_RESOURCE;
  value^.value.lval := l;
end;

procedure ZVAL_NULL(z: pzval);
begin
  {$IFDEF PHP7}
  z^.u1.v._type
  {$ELSE}
  z^._type
  {$ENDIF}  := IS_NULL;
end;

procedure ZvalString(z:pzval);
begin
  z^.value.str.len := 0;
  z^.value.str.val := '';
  {$IFDEF PHP7}
  z^.u1.v._type
  {$ELSE}
  z^._type
  {$ENDIF}  := IS_STRING;
end;

procedure ZvalString(z:pzval; s:zend_pchar; len:Integer = 0);
var
  lens:Integer;
begin
  if not assigned(s) then
    ZvalString(z)
  else begin
    if len = 0 then
      lens := Length(s)
    else
      lens := len;

    z^.value.str.len := lens;
    z^.value.str.val := estrndup(s, lens);
    {$IFDEF PHP7}
    z^.u1.v._type
    {$ELSE}
    z^._type
    {$ENDIF}  := IS_STRING;
  end;
end;

procedure ZvalString(z:pzval; s:PWideChar; len:Integer = 0);
begin
  if not assigned(s) then
    ZvalString(z)
  else
    ZvalString(z, zend_pchar(zend_ustr(WideString(s))), len);
end;

procedure ZvalString(z:pzval; s:string; len:Integer = 0);
var
  _s:PWideChar;
begin
  _s := PWideChar(s);

  if not assigned(_s) then
    ZvalString(z)
  else
    ZvalString(z, _s, len);
end;
function ZvalInt;
begin
  Result := z.value.lval;
end;

function ZvalDouble;
begin
  Result := z.value.dval;
end;

function ZvalBool;
begin
  Result := boolean(z.value.lval);
end;

function ZvalStrS;
begin
 Result := z.value.str.val;
end;

function ZvalStr;
begin
 Result := z.value.str.val;
end;

function ZvalStrW;
begin
 Result := WideString(z.value.str.val);
end;

procedure ZvalVAL(z:pzval; v:Boolean);
Begin
  {$IFDEF PHP7}
  z^.u1.v._type
  {$ELSE}
  z^._type
  {$ENDIF}  := IS_BOOL;
  z.value.lval := integer(v);
End;

procedure ZvalVAL(z:pzval; v:Integer; const _type:Integer = IS_LONG);
Begin
  {$IFDEF PHP7}
  z^.u1.v._type
  {$ELSE}
  z^._type
  {$ENDIF}  := _type;
  z^.value.lval := v;
End;

procedure ZvalVAL(z:pzval);
Begin
  {$IFDEF PHP7}
  z^.u1.v._type
  {$ELSE}
  z^._type
  {$ENDIF}  := IS_NULL;
End;

procedure ZvalVAL(z:pzval; v:Double);
Begin
  {$IFDEF PHP7}
  z^.u1.v._type
  {$ELSE}
  z^._type
  {$ENDIF} := IS_LONG;
  z.value.dval := v;
End;

procedure ZvalVAL(z:pzval; v:SmallInt);
begin
  {$IFDEF PHP7}
  z^.u1.v._type
  {$ELSE}
  z^._type
  {$ENDIF}  := IS_LONG;
  z^.value.lval := v;
end;

procedure ZvalVAL(z:pzval; v:Extended);
Begin
  {$IFDEF PHP7}
  z^.u1.v._type
  {$ELSE}
  z^._type
  {$ENDIF} := IS_LONG;
  z.value.dval := v;
End;

procedure ZvalVAL(z: pzval; s: zend_ustr; len: Integer = 0);
var
  lens: Integer;
  AChar: zend_pchar;
begin
  AChar := zend_pchar(s);

  if not assigned(AChar) then
    ZVAL_NULL(z)
  else
  begin
    if len = 0 then
      lens := Length(AChar)
    else
      lens := len;

    z^.value.str.len := lens;
    z^.value.str.val := _estrndup(AChar, lens, nil, 0, nil, 0);
    {$IFDEF PHP7}
    z^.u1.v._type
    {$ELSE}
    z^._type
    {$ENDIF}  := IS_STRING;
  end;
end;

function AddElementZvalArray(z: pzval; Args: array of const; flag: Integer;
  idx: uint = 0; len: uint = 0; const key: zend_ustr = ''): Integer;
var
  tmp: pzval;
  arKey: zend_pchar;
begin
  Result := FAILURE;
  if {$IFDEF PHP7}
  z^.u1.v._type
  {$ELSE}
  z^._type
  {$ENDIF}  <> IS_ARRAY then
    exit;

  if len <> 0 then
  begin
    inc(len);
    arKey := zend_pchar(key);
    idx := zend_hash_func(arKey, len);
  end;

  tmp := GetArgPZval(Args[0], 1, true);

  Result := _zend_hash_quick_add_or_update(
  {$IFDEF PHP7}z.value.arr{$ELSE}z.value.ht{$ENDIF}, arKey, len, idx, tmp,
    sizeof(pzval), nil, flag);
end;
// Add Next
function ZvalArrayAdd(z: pzval; Args: array of const): Integer; overload;
begin
  Result := FAILURE;
  if {$IFDEF PHP7}
  z^.u1.v._type
  {$ELSE}
  z^._type
  {$ENDIF} <> IS_ARRAY then
    exit;
  Result := AddElementZvalArray(z, Args, HASH_NEXT_INSERT,
    {$IFDEF PHP7} z.value.arr.nNextFreeElement {$ELSE} z.value.ht.nNextFreeElement {$ENDIF});
end;

// Add Index
function ZvalArrayAdd(z: pzval; idx: Integer; Args: array of const)
  : Integer; overload;
begin
  Result := AddElementZvalArray(z, Args, HASH_UPDATE, idx);
end;

// Add Assoc
function ZvalArrayAdd(z: pzval; key: zend_ustr; Args: array of const)
  : Integer; overload;
begin
  Result := AddElementZvalArray(z, Args, HASH_UPDATE, 0, Length(key), key);
end;

function IsArrayRetVal(v: pzval): Boolean;
begin
  Result := {$IFDEF PHP7}
  v^.u1.v._type
  {$ELSE}
  v^._type
  {$ENDIF} = IS_ARRAY;
end;

function ZValArrayKeyExists(v: pzval; key: zend_ustr): Boolean; overload;
begin
  Result := false;
  if {$IFDEF PHP7}
  v^.u1.v._type
  {$ELSE}
  v^._type
  {$ENDIF} <> IS_ARRAY then
    exit;

  if {$IFDEF PHP7} v.value.arr.nNumOfElements {$ELSE} v.value.ht.nNumOfElements {$ENDIF} = 0  then
    exit;

  Result := zend_hash_exists({$IFDEF PHP7}v.value.arr{$ELSE}v.value.ht{$ENDIF}, zend_pchar(key), Length(key) + 1) = 1;
end;

function ZValArrayKeyExists(v: pzval; idx: Integer): Boolean; overload;
begin
  Result := false;
  if ({$IFDEF PHP7} v.u1.v._type {$ELSE} v._type {$ENDIF} <> IS_ARRAY) then
    exit;

  if {$IFDEF PHP7} v.value.arr.nNumOfElements {$ELSE} v.value.ht.nNumOfElements {$ENDIF} = 0  then
    exit;

  Result := zend_hash_index_exists({$IFDEF PHP7}v.value.arr{$ELSE}v.value.ht{$ENDIF}, idx) = 1;
end;

function ZValArrayKeyExists(v: pzval; key: zend_ustr; out pData: pzval)
  : Boolean; overload;
var
  tmp: ppzval;
begin
  Result := ZValArrayKeyExists(v, key);
  if Result then
  begin
    pData := nil;
    if ZValArrayKeyFind(v, key, tmp) then
      pData := tmp^;
  end;
end;

function ZValArrayKeyExists(v: pzval; idx: Integer; out pData: pzval)
  : Boolean; overload;
var
  tmp: ppzval;
begin
  Result := ZValArrayKeyExists(v, idx);
  if Result then
  begin
    pData := nil;
    if ZValArrayKeyFind(v, idx, tmp) then
      pData := tmp^;
  end;
end;

function ZValArrayKeyDel(v: pzval; key: zend_ustr): Boolean; overload;
{$IFDEF PHP7}
var
  pzs: pzend_string;
{$ENDIF}
begin
  Result := false;
  if ZValArrayKeyExists(v, key) then
  {$IFDEF PHP7}
  begin
  pzs^.len := strlen(zend_pchar(key));
  pzs^.val := estrdup(zend_pchar(key));
  Result := zend_hash_del_key_or_index(v.value.arr, pzs) = SUCCESS
  end;
  {$ELSE}
    Result := zend_hash_del_key_or_index(v.value.ht, zend_pchar(key),
      Length(key) + 1, 0, HASH_DEL_KEY) = SUCCESS;
  {$ENDIF}
end;

function ZValArrayKeyDel(v: pzval; idx: Integer): Boolean; overload;
{$IFDEF PHP7}
var
  pzs: pzend_string;
{$ENDIF}
begin
  Result := false;
  if ZValArrayKeyExists(v, idx) then
  {$IFDEF PHP7}
  begin
  pzs^.len := strlen(zend_pchar(inttostr(idx)));
  pzs^.val := estrdup(zend_pchar(inttostr(idx)));
  Result := zend_hash_del_key_or_index(v.value.arr, pzs) = SUCCESS
  end;
  {$ELSE}
    Result := zend_hash_del_key_or_index({$IFDEF PHP7}v.value.arr{$ELSE}v.value.ht{$ENDIF}, nil, 0, idx,
      HASH_DEL_INDEX) = SUCCESS;
  {$ENDIF}
end;

function ZValArrayKeyFind(v: pzval; key: zend_ustr; out pData: ppzval)
  : Boolean; overload;
var
  keyStr: zend_pchar;
  KeyLength: uint;
begin
  keyStr := zend_pchar(key);
  KeyLength := Length(key) + 1;

  Result := zend_hash_quick_find({$IFDEF PHP7}v.value.arr{$ELSE}v.value.ht{$ENDIF}, keyStr, KeyLength,
    zend_hash_func(keyStr, KeyLength), pData) = SUCCESS;
end;

function ZValArrayKeyFind(v: pzval; idx: Integer; out pData: ppzval)
  : Boolean; overload;
begin
  Result := zend_hash_quick_find({$IFDEF PHP7}v.value.arr{$ELSE}v.value.ht{$ENDIF}, nil, 0, idx, pData) = SUCCESS;
end;
procedure MAKE_STD_ZVAL(out Result: pzval);
begin
  {$IFNDEF PHP7}
    ALLOC_ZVAL(Result);
  {$ENDIF}
  INIT_PZVAL(Result);
end;



function GetArgPZval;
begin
  if Args._Reserved1 = 0 then // nil
  begin
    if Make then
      MAKE_STD_ZVAL(Result);
   {$IFDEF PHP7} Result.u1.v._type {$ELSE} Result._type {$ENDIF} := IS_NULL;
  end
  else if Args.VType = vtPointer then
    Result := Args.VPointer
  else
  begin
    if Make then
      MAKE_STD_ZVAL(Result);
    case Args.VType of
      vtInteger:
        ZvalVAL(Result, Args.VInteger, _type);
      vtInt64:
        ZvalVAL(Result, NativeInt(Args.VInt64^), _type);
      vtBoolean:
        ZvalVAL(Result, Args.VBoolean);
      vtExtended:
        ZvalVAL(Result, Args.VExtended^);
      vtClass, vtObject:
        ZvalVAL(Result, Args._Reserved1);
      vtString:
        ZvalVAL(Result, zend_ustr(Args.VString^));
      vtAnsiString:
        ZvalVAL(Result, zend_pchar(zend_ustr(Args.VAnsiString)));
      vtUnicodeString:
        ZvalVAL(Result, UnicodeString(Args._Reserved1));
      vtWideChar:
        ZvalVAL(Result, zend_ustr(Args.VWideChar));
      vtChar:
        ZvalVAL(Result, zend_pchar(zend_uchar(Args.VChar)));
      vtPWideChar:
        ZvalVAL(Result, Args.VPWideChar);
      vtPChar:
        ZvalVAL(Result, zend_pchar(Args.VPChar));
      vtWideString:
        ZvalVAL(Result, zend_pchar(Args.VWideString));
    end;
  end;
end;


procedure ZVAL_STRINGU(z: pzval; s: PUtf8Char; duplicate: boolean);
var
  __s : PUTF8Char;
begin
  if not assigned(s) then
   __s := ''
    else
     __s := s;

  z^.value.str.len := length(__s);
  if duplicate then

   z^.value.str.val := estrndup(__s, z^.value.str.len)
  else
    z^.value.str.val := __s;
  {$IFDEF PHP7} z^.u1.v._type {$ELSE} z^._type {$ENDIF} := IS_STRING;
end;

procedure ZVAL_STRING(z: pzval; s: zend_pchar; duplicate: boolean);
var
  __s : zend_pchar;
begin
  if not assigned(s) then
   __s := ''
    else
     __s := s;

  z^.value.str.len := strlen(__s);
  if duplicate then

   z^.value.str.val := estrndup(__s, z^.value.str.len)
  else
    z^.value.str.val := __s;
  {$IFDEF PHP7} z^.u1.v._type {$ELSE} z^._type {$ENDIF} := IS_STRING;
end;

procedure ZVAL_STRINGW(z: pzval; s: PWideChar; duplicate: boolean);
var
  __s : zend_pchar;
  StA : zend_ustr;
  StW : WideString;
begin
  if not assigned(s) then
   __s := ''
    else
      begin
        StW := WideString(s);
        StA := zend_ustr(StW);
        __s := zend_pchar(StA);
      end;

  z^.value.str.len := strlen(__s);
  if duplicate then

   z^.value.str.val := estrndup(__s, z^.value.str.len)
  else
    z^.value.str.val := __s;
  {$IFDEF PHP7} z^.u1.v._type {$ELSE} z^._type {$ENDIF} := IS_STRING;
end;

procedure ZVAL_STRINGL(z: pzval; s: zend_pchar; l: integer; duplicate: boolean);
var
  __s  : zend_pchar;
  __l  : integer;
begin
  if not assigned(s) then
   __s := ''
    else
     __s := s;
  __l := l;
  z^.value.str.len := __l;
  if duplicate then
    z^.value.str.val := estrndup(__s, __l)
  else
    z^.value.str.val := __s;
  {$IFDEF PHP7} z^.u1.v._type {$ELSE} z^._type {$ENDIF} := IS_STRING;
end;

procedure ZVAL_STRINGLW(z: pzval; s: PWideChar; l: integer; duplicate: boolean);
var
  __s  : zend_pchar;
  __l  : integer;
  StA : zend_ustr;
  StW : WideString;
begin
  if not assigned(s) then
   __s := ''
    else
     begin
       StW := WideString(s);
       StA := zend_ustr(StW);
        __s := zend_pchar(StA);
     end;

  __l := l;
  z^.value.str.len := __l;
  if duplicate then
    z^.value.str.val := estrndup(__s, __l)
  else
    z^.value.str.val := __s;
  {$IFDEF PHP7} z^.u1.v._type {$ELSE} z^._type {$ENDIF} := IS_STRING;
end;

procedure ZVAL_EMPTY_STRING(z: pzval);
begin
  z^.value.str.len := 0;
 // {$IFDEF PHP510}
  z^.value.str.val := STR_EMPTY_ALLOC;
  (*{$ELSE}
  z^.value.str.val := '';
  {$ENDIF}*)
  {$IFDEF PHP7} z^.u1.v._type {$ELSE} z^._type {$ENDIF} := IS_STRING;
end;

function ToStrA(V: Variant): zend_ustr;
begin
  Result := V;
end;

function ToStr(V: Variant): String;
begin
  Result := V;
end;

function ToPChar(V: Variant): zend_pchar;
begin
  Result := zend_pchar(ToStr(V));
end;

function toWChar(s: zend_pchar): PWideChar;
  var
  ss: WideString;
  ss2: string;
begin
  ss2 := s;
  ss := ss2;
  Result := PWideChar(ss);
end;
function HashToVarArray(const Value:{$IFDEF PHP7}Pzend_array{$ELSE}PHashTable{$ENDIF}): Variant;
  Var
  Len,I: Integer;
  {$IFDEF PHP7}tmp : pzval;{$ELSE}tmp : pppzval;{$ENDIF}
begin
 len := zend_hash_num_elements(Value);
 Result := VarArrayCreate([0, len - 1], varVariant);
 for i:=0 to len-1 do
  begin
    new(tmp);

    zend_hash_index_find(Value,i,tmp);

    VarArrayPut(Result, ZendToVariant(tmp), [i]);
    freemem(tmp);
  end;
end;
procedure VarArrayToHash(var HT: pzval;Value: Variant);
  Var
  I,Len: Integer;
begin
  _array_init(ht,nil,1);
  len := TVarData(Value).VArray^.Bounds[0].ElementCount;
    for i:= 0 to len - 1 do
    begin
      add_index_variant(HT, i, VarArrayGet(Value, [i]));
    end;
end;
function ZendToVariant(const Value: pzval;
cobj: TObjectBConvertMethod=nil): Variant; overload;
  Var
  S: String;
begin
 case {$IFDEF PHP7} Value^.u1.v._type {$ELSE}Value^._type{$ENDIF} of
 0: Result := Null;                           //Null
 1: Result := Value^.value.lval;              //LongInt -> Integer
 2: Result := Value^.value.dval;              //Double
 3: Result := boolean(Value^.value.lval);     //Boolean
 {$IFDEF PHP7}
 4: Result := HashToVarArray(Value^.value.arr);//Array
 {$ELSE}
 4: Result := HashToVarArray(Value^.value.ht);//Array
 {$ENDIF}
 5:                                           //Object
  if Assigned(cobj) then
    Result := cobj(Value)
  else
    Result := Null;                           //String
 6: begin S := Value^.value.str.val; Result := S; end;
 7: Result := Value^.value.lval;              //Resource
                                              //Constant
 8: begin S := Value^.value.str.val; Result := S; end;
 {$IFDEF PHP7}
  9: Result := HashToVarArray(Value^.value.arr) //Constant Array
 {$ELSE}
 9: Result := HashToVarArray(Value^.value.ht) //Constant Array
 {$ENDIF}
 else Result := Null;                         //Unknown/undefined
 end;
end;

procedure VariantToZend(const Value:Variant;z:pzval;
cobj: TObjectAConvertMethod=nil);
var
 W : WideString;
 S: String;
begin
  if VarIsEmpty(value) or VarIsNull(Value) then
   begin
     ZVALVAL(z);
     Exit;
   end;
  case TVarData(Value).VType of
  varString    : //Peter Enz
         begin
           if Assigned ( TVarData(Value).VString ) then
             begin
               ZVAL_STRING(z, TVarData(Value).VString , true);
             end
               else
                 begin
                   ZVAL_STRING(z, '', true);
                 end;
         end;

  varUString    : //Peter Enz
         begin
            S := string(TVarData(Value).VUString);

             ZVAL_STRING(z, zend_pchar(zend_ustr(S)), true);
         end;

     varOleStr    : //Peter Enz
         begin
           if Assigned ( TVarData(Value).VOleStr ) then
             begin
               W := WideString(Pointer(TVarData(Value).VOleStr));
               ZVAL_STRINGW(z, PWideChar(W),  true);
             end
               else
                 begin
                   ZVAL_STRING(z, '', true);
                 end;
         end;

     varWord     : ZVALVAL(z, TVarData(Value).VWord);
  //HERE;
  //    varVariant  :
  //    varUnknown  :
  //<=== следует искать через VarIs{TYPE}()

    //varDispatch : integer(TVarData(Value).VDispatch
     //<==указатель на вызывающую функцию... хз точно не пойму
     //вообщем на метод с типом Dispatch (вызов, выброс)... забыл я
     //ну метод в классе коро.че
    varDispatch    :
     begin
       if Assigned(cobj) then
        cobj(Value, z)
       else
        ZVALVAL(z);
     end;
    //varAny : integer(TVarData(Value).VAny
     //<==указатель на метод*(любой)
     //
     varAny    :
     begin
       if Assigned(cobj) then
        cobj(Value, z)
       else
        ZVALVAL(z);
     end;
     //varRecord : integer(TVarData(Value).VRecord)
     //<==запись... я до сих пор не разобрался как с ними через RTTI работать
     varRecord    :
     begin
       if Assigned(cobj) then
        cobj(Value, z)
       else
        ZVALVAL(z);
     end;
     //varObject : integer(TVarData(Value).VObject)
     //<==объект...
     varObject    :
     begin
       if Assigned(cobj) then
        cobj(Value, z)
       else
        ZVALVAL(z, integer(TObject(TVarData(Value).VPointer^)));
     end;
     varStrArg    : //Peter Enz
         begin
           if Assigned ( TVarData(Value).VString ) then
             begin
               ZVAL_STRING(z, TVarData(Value).VString , true);
             end
               else
                 begin
                   ZVAL_STRING(z, '', true);
                 end;
         end;

     varUStrArg    : //Peter Enz
         begin
            S := string(TVarData(Value).VUString);

             ZVAL_STRING(z, zend_pchar(zend_ustr(S)), true);
         end;
     varInt64    : ZVALVAL(z, TVarData(Value).VInt64);
     varUInt64   : ZVALVAL(z, TVarData(Value).VUInt64);
     varShortInt : ZVALVAL(z, Integer(TVarData(Value).VShortInt));
     varSmallInt : ZVALVAL(z, Integer(TVarData(Value).VSmallint));
     varInteger  : ZVALVAL(z, TVarData(Value).VInteger);
     varBoolean  : ZVALVAL(z, TVarData(Value).VBoolean);
     varSingle   : ZVALVAL(z, TVarData(Value).VSingle);
     varDouble   : ZVALVAL(z, TVarData(Value).VDouble);
     varCurrency : ZVALVAL(z, TVarData(Value).VCurrency);
     //!>
     varError    : ZVALVAL(z, Integer(TVarData(Value).VError));

     varByte     : ZVALVAL(z, Integer(TVarData(Value).VByte));
     varDate     : ZVALVAL(z, TVarData(Value).VDate);
     varArray    : VarArrayToHash(z, Value);
     else
       ZVALVAL(Z);
  end;
end;

function ZendToVariant(const Value: ppzval;cobj: TObjectBConvertMethod=nil): Variant; overload;
begin
Result := ZendToVariant(Value^);
end;

function ZendToVariant(const Value: pppzval;cobj: TObjectBConvertMethod=nil): Variant; overload;
begin
Result := ZendToVariant(Value^^);
end;

procedure HashToArray(HT: {$IFDEF PHP7}Pzend_array{$ELSE}PHashTable{$ENDIF}; var AR: TArrayVariant); overload;
  Var
  Len,I: Integer;
  tmp : pppzval;
begin
 len := zend_hash_num_elements(HT);
 SetLength(AR,len);
 for i:=0 to len-1 do
  begin
    new(tmp);

    zend_hash_index_find(ht,i,tmp);

    AR[i] := ZendToVariant(tmp);
    freemem(tmp);
  end;
end;


procedure ArrayToHash(AR: Array of Variant; var HT: pzval); overload;
  Var
  I,Len: Integer;
begin
  _array_init(ht,nil,1);
  len := Length(AR);
  for i:=0 to len-1 do
   begin
    add_index_variant(ht,i,AR[i]);
   end;
end;

procedure ArrayToHash(Keys,AR: Array of Variant; var HT: pzval); overload;
  Var
  I,Len: Integer;
begin
  _array_init(ht,nil,1);
  len := Length(AR);
  for i:=0 to len-1 do
   begin
    add_assoc_variant(ht, ToPChar(Keys[i]),strlen(ToPChar(Keys[i]))+1,AR[i]);
   end;
end;

function add_next_index_variant(arg: pzval; value: variant): integer;
var iz: pzval;
begin
  iz := MAKE_STD_ZVAL;
  if VarIsEmpty(value) then
   begin
     ZVAL_NULL(iz);
     Result := add_next_index_zval(arg, iz);
     Exit;
   end;
   VariantToZend(Value,iz);
   Result := add_next_index_zval(arg, iz);
end;

function add_index_variant(arg: pzval; index:integer; value: variant): integer;
var iz: pzval;
begin
  iz := MAKE_STD_ZVAL;
  if VarIsEmpty(value) then
   begin
     ZVAL_NULL(iz);
     Result := add_index_zval(arg, index, iz);
     Exit;
   end;
   VariantToZend(Value,iz);
   Result := add_index_zval(arg, index, iz);
end;

function add_assoc_variant(arg: pzval; key: zend_pchar; key_len: uint; value: variant): integer;
var iz: pzval;
begin
  iz := MAKE_STD_ZVAL;
  if VarIsEmpty(value) then
   begin
     ZVAL_NULL(iz);
     Result := add_assoc_zval_ex(arg, key, key_len, iz);
     Exit;
   end;
   VariantToZend(Value,iz);
   Result := add_assoc_zval_ex(arg, key, key_len, iz);
end;

procedure ZVAL_ARRAY(z: pzval; arr:  TWSDate); overload;
var
  i : integer;
begin
 if _array_init(z, nil, 0) = FAILURE then //Создаём массив первого уровня
  begin
    ZVALVAL(z,False);
    Exit;
  end;

  if Length(arr) = 0 then
  begin
    {$IFDEF PHP7}
    z^.value.counted.gc.refcount
    {$ELSE}
    z^.refcount
    {$ENDIF} := 1;
    Exit;
  end;

   for i := 0 to Length(arr)-1 do
    begin
       add_next_index_string(z, zend_pchar(zend_ustr(arr[i])), 1);
    end;
    Exit;
end;

procedure ZVAL_ARRAY(z: pzval; arr:  TASDate); overload;
var
  i : integer;
begin
 if _array_init(z, nil, 0) = FAILURE then //Создаём массив первого уровня
  begin
    ZVALVAL(z,False);
    Exit;
  end;

  if Length(arr) = 0 then
  begin
    {$IFDEF PHP7}
    z^.value.counted.gc.refcount
    {$ELSE}
    z^.refcount
    {$ENDIF} := 1;
    Exit;
  end;

   for i := 0 to Length(arr)-1 do
    begin
       add_next_index_string(z, zend_pchar(arr[i]), 1);
    end;
    Exit;
end;

procedure ZVAL_ARRAY(z: pzval; arr: array of string); overload;
var
  i: integer;
begin
 if _array_init(z, nil, 0) = FAILURE then //Создаём массив первого уровня
  begin
    ZVALVAL(z,False);
    Exit;
  end;

  if Length(arr) = 0 then
  begin
    {$IFDEF PHP7}
    z^.value.counted.gc.refcount
    {$ELSE}
    z^.refcount
    {$ENDIF} := 1;
    Exit;
  end;

   for i := 0 to Length(arr)-1 do
    begin
       add_next_index_string(z, zend_pchar(zend_ustr(arr[i])), 1);
    end;
    Exit;
end;

procedure ZVAL_ARRAY(z: pzval; arr:  array of zend_ustr); overload;
var
  i: integer;
begin
 if _array_init(z, nil, 0) = FAILURE then //Создаём массив первого уровня
  begin
    ZVALVAL(z,False);
    Exit;
  end;

  if Length(arr) = 0 then
  begin
    {$IFDEF PHP7}
    z^.value.counted.gc.refcount
    {$ELSE}
    z^.refcount
    {$ENDIF} := 1;
    Exit;
  end;

   for i := 0 to Length(arr)-1 do
    begin
       add_next_index_string(z, zend_pchar(arr[i]), 1);
    end;
    Exit;
end;

procedure ZVAL_ARRAY(z: pzval; arr:  array of variant); overload;
var
  i: integer;
begin
 if _array_init(z, nil, 0) = FAILURE then //Создаём массив первого уровня
  begin
    ZVALVAL(z,False);
    Exit;
  end;

  if Length(arr) = 0 then
  begin
    {$IFDEF PHP7}
    z^.value.counted.gc.refcount
    {$ELSE}
    z^.refcount
    {$ENDIF} := 1;
    Exit;
  end;

   for i := 0 to Length(arr)-1 do
    begin
       add_next_index_variant(z, arr[i]);
    end;
    Exit;
end;
procedure ZVAL_ARRAY(z: pzval; arr: System.TArray<System.integer>); overload;
var
  i: integer;
begin
 if _array_init(z, nil, 0) = FAILURE then //Создаём массив первого уровня
  begin
    ZVALVAL(z,False);
    Exit;
  end;

  if Length(arr) = 0 then
  begin
    {$IFDEF PHP7}
    z^.value.counted.gc.refcount
    {$ELSE}
    z^.refcount
    {$ENDIF} := 1;
    Exit;
  end;

   for i := 0 to Length(arr)-1 do
    begin
       add_next_index_long(z, arr[i]);
    end;
    Exit;
end;

procedure ZVAL_ARRAY(z: pzval; arr: Variant); overload;
var
  i: integer;
  {V: TVarData;}
begin
 if _array_init(z, nil, 0) = FAILURE then //Создаём массив первого уровня
  begin
    ZVALVAL(z,False);
    Exit;
  end;

  if arr.PVarArray.DimCount = 0 then
  begin
    ZVALVAL(z,False);
    Exit;
  end;

   for i := 0 to arr.DimCount-1 do
    begin
       add_next_index_variant(z, arr[i]);
    end;
    Exit;
end;

procedure ZVAL_ARRAYAC(z: pzval; keynames: Array of ansichar; keyvals: Array of ansichar);
var
  i : integer;
begin
 if _array_init(z, nil, 0) = FAILURE then
  begin
    ZVALVAL(z,False);
    Exit;
  end;

  if (Length(keynames) = 0)and(Length(keynames) = Length(keyvals)) then
  begin
    {$IFDEF PHP7}
    z^.value.counted.gc.refcount
    {$ELSE}
    z^.refcount
    {$ENDIF} := 1;
    Exit;
  end;

  if Length(keynames) = Length(keyvals) then
   begin
   for i := 0 to Length(keynames)-1 do
      add_assoc_string_ex(z, zend_pchar(zend_uchar(keynames[i])), StrLen(PAnsiChar(keynames[i])) + 1, zend_pchar(zend_uchar(keyvals[i])), 1);
   end
   else
   begin
      ZVALVAL(z,False);
   end;
end;
procedure ZVAL_ARRAYWC(z: pzval; keynames: Array of PWideChar; keyvals: Array of PWideChar);
var
  i : integer;
begin
 if _array_init(z, nil, 0) = FAILURE then
  begin
    ZVALVAL(z,False);
    Exit;
  end;

  if (Length(keynames) = 0)and(Length(keynames) = Length(keyvals)) then
  begin
    {$IFDEF PHP7}
    z^.value.counted.gc.refcount
    {$ELSE}
    z^.refcount
    {$ENDIF} := 1;
    Exit;
  end;

  if Length(keynames) = Length(keyvals) then
   begin
   for i := 0 to Length(keynames)-1 do
    begin
      add_assoc_string_ex(z, zend_pchar(keynames[i]), StrLen(zend_pchar(keynames[i])) + 1, zend_pchar(keyvals[i]), 1);
    end;
    Exit;
   end
   else
   begin
      ZVALVAL(z,False);
    Exit;
   end;

end;
procedure ZVAL_ARRAYWS(z: pzval; keynames:  TWSDate; keyvals:  TWSDate); overload;
var
  i : integer;
begin
 if _array_init(z, nil, 0) = FAILURE then //Создаём массив первого уровня
  begin
    ZVALVAL(z,False);
    Exit;
  end;
   //z^.refcount := Length(keynames); //Передаём количество возвращаемых массивов
  if (Length(keynames) = 0) then
  begin
    {$IFDEF PHP7}
    z^.value.counted.gc.refcount
    {$ELSE}
    z^.refcount
    {$ENDIF} := 1;
    Exit;
  end;

  if Length(keynames) = Length(keyvals) then
   begin
   for i := 0 to Length(keynames)-1 do
    begin
                    //Создаём строку в массиве первого уровня
                    //Создаём ассоциацию строки с ключём первого уровня
      add_assoc_string_ex(z, zend_pchar(zend_ustr(keynames[i])), StrLen(zend_pchar(zend_ustr(keynames[i]))) + 1,
      zend_pchar(zend_ustr(keyvals[i])), 1);

                    //Продолжаем цикл
    end;
    Exit;
   end
   else
   begin
      ZVALVAL(z,False);
    Exit;
   end;

end;
procedure ZVAL_ARRAYWS(z: pzval; keynames:  array of string; keyvals:  array of string); overload;
var
  i : integer;
begin
 if _array_init(z, nil, 0) = FAILURE then
  begin
    ZVALVAL(z,False);
    Exit;
  end;

  if (Length(keynames) = 0)and(Length(keynames) = Length(keyvals)) then
  begin
    {$IFDEF PHP7}
    z^.value.counted.gc.refcount
    {$ELSE}
    z^.refcount
    {$ENDIF} := 1;
    Exit;
  end;

  if Length(keynames) = Length(keyvals) then
   begin
   for i := 0 to Length(keynames)-1 do
    begin
      add_assoc_string_ex(z, zend_pchar(zend_ustr(keynames[i])), StrLen(zend_pchar(zend_ustr(keynames[i]))) + 1,
      zend_pchar(zend_ustr(keyvals[i])), 1);
    end;
    Exit;
   end
   else
   begin
      ZVALVAL(z,False);
    Exit;
   end;

end;
procedure ZVAL_ARRAYAS(z: pzval; keynames: TASDate; keyvals: TASDate); overload;
var
  i : integer;
begin
 if _array_init(z, nil, 0) = FAILURE then
  begin
    ZVALVAL(z,False);
    Exit;
  end;

  if (Length(keynames) = 0)and(Length(keynames) = Length(keyvals)) then
  begin
    {$IFDEF PHP7}
    z^.value.counted.gc.refcount
    {$ELSE}
    z^.refcount
    {$ENDIF} := 1;
    Exit;
  end;

  if Length(keynames) = Length(keyvals) then
   begin
   for i := 0 to Length(keynames)-1 do
    begin
      add_assoc_string_ex(z, zend_pchar(keynames[i]), StrLen(zend_pchar(keynames[i])) + 1, zend_pchar(keyvals[i]), 1);
    end;
    Exit;
   end
   else
   begin
      ZVALVAL(z,False);
    Exit;
   end;

end;
procedure ZVAL_ARRAYAS(z: pzval; keynames: Array of AnsiString; keyvals: Array of AnsiString); overload;
var
  i : integer;
begin
 if _array_init(z, nil, 0) = FAILURE then
  begin
    ZVALVAL(z,False);
    Exit;
  end;

  if (Length(keynames) = 0)and(Length(keynames) = Length(keyvals)) then
  begin
    {$IFDEF PHP7}
    z^.value.counted.gc.refcount
    {$ELSE}
    z^.refcount
    {$ENDIF} := 1;
    Exit;
  end;

  if Length(keynames) = Length(keyvals) then
   begin
   for i := 0 to Length(keynames)-1 do
    begin
      add_assoc_string_ex(z, zend_pchar(zend_ustr(keynames[i])), StrLen(PAnsiChar(keynames[i])) + 1, zend_pchar(zend_ustr(keyvals[i])), 1);
    end;
    Exit;
   end
   else
   begin
      ZVALVAL(z,False);
    Exit;
   end;

end;
function ZENDLoaded: boolean;
begin
  Result := PHPLib <> 0;
end;

procedure UnloadZEND;
var
 H : THandle;
 t: Integer;
begin
  t := Integer(PHPLib);
  H := InterlockedExchange(t, 0);
  if H > 0 then
  begin
    FreeLibrary(H);
  end;
end;
function Lfunc(var Func: Pointer; addr: LPCWSTR): BOOL;
begin
  Result := True;
  Func := GetProcAddress(PHPLib, addr);
  if Func = nil then
  begin
    {$IFNDEF QUIET_LOAD}
    raise EPHP4DelphiException.Create(addr);
    {$ENDIF}
    Result := False;
  end;
end;
procedure zend_copy_constant(c: zend_constant);
begin
  c.name := zend_strndup(c.name, c.name_len - 1);
	if (c.flags and CONST_PERSISTENT) = 0 then
    _zval_copy_ctor_func(@c.value, '', 0);
end;
{$IF defined(PHP540) or defined(PHP550) or defined(PHP560)}

procedure zend_copy_constants(target: PHashTable;source: PHashTable);
var tmp: zend_constant;
begin
	zend_hash_copy(target, source, @zend_copy_constant, @tmp, sizeof(zend_constant));
end;

procedure zend_class_add_ref(aclass: Ppzend_class_entry); cdecl;
begin
  Inc(aclass^.refcount,1);
end;
{$ENDIF}
function LoadZEND(const DllFilename: zend_ustr = PHPWin) : boolean;
var
  WriteFuncPtr  : pointer;
begin
 {$IFDEF QUIET_LOAD}
  Result := false;
 {$ENDIF}
  PHPLib := LoadLibrary( PWideChar(WideString(DllFilename)) );

{$IFNDEF QUIET_LOAD}
  if PHPLib = 0 then
  begin
   RaiseLastOSError;
  // raise Exception.Create(RaiseLastOSError);
  end;
{$ELSE}
  if PHPLib = 0 then Exit;
{$ENDIF}

 {$IFDEF PHP5}
 {$IF not defined(PHP540) and not defined(PHP550) and not defined(PHP560)}
   LFunc(@zend_copy_constants, 'zend_copy_constants');
 {$ENDIF}
   LFunc(@zend_objects_new, 'zend_objects_new');
   LFunc(@zend_objects_clone_obj, 'zend_objects_clone_obj');
   LFunc(@function_add_ref, 'function_add_ref');
 {$IF not defined(PHP540) and not defined(PHP550) and not defined(PHP560)}
   LFunc(@zend_class_add_ref, 'zend_class_add_ref');
 {$ENDIF}

   LFunc(@zend_objects_store_add_ref, 'zend_objects_store_add_ref');
   LFunc(@zend_objects_store_del_ref, 'zend_objects_store_del_ref');

   LFunc(@zend_get_std_object_handlers, 'zend_get_std_object_handlers');
   LFunc(@zend_objects_get_address, 'zend_objects_get_address');
   LFunc(@zend_is_true, 'zend_is_true');
{$ENDIF}

  LFunc(@_zend_bailout, '_zend_bailout');

  LFunc(@zend_disable_function, 'zend_disable_function');
  LFunc(@zend_disable_class, 'zend_disable_class');
  LFunc(@zend_register_list_destructors_ex, 'zend_register_list_destructors_ex');
  LFunc(@zend_register_resource, 'zend_register_resource');
  LFunc(@zend_fetch_resource, 'zend_fetch_resource');
  LFunc(@zend_list_insert, 'zend_list_insert');
  {$IFNDEF PHP7}
  LFunc(@_zend_list_addref, '_zend_list_addref');
  LFunc(@_zend_list_delete, '_zend_list_delete');
  LFunc(@_zend_list_find, '_zend_list_find');
  {$ENDIF}
  LFunc(@zend_rsrc_list_get_rsrc_type, 'zend_rsrc_list_get_rsrc_type');
  LFunc(@zend_fetch_list_dtor_id, 'zend_fetch_list_dtor_id');

  LFunc(@zend_get_compiled_filename, 'zend_get_compiled_filename');

  LFunc(@zend_get_compiled_lineno, 'zend_get_compiled_lineno');

  LFunc(@zend_ini_deactivate, 'zend_ini_deactivate');

  // -- tsrm_startup
  LFunc(@tsrm_startup, 'tsrm_startup');

  // -- ts_allocate_id
  LFunc(@ts_allocate_id, 'ts_allocate_id');

  // -- ts_free_id
  LFunc(@ts_free_id, 'ts_free_id');

  // -- zend_strndup
  LFunc(@zend_strndup,
  {$IFNDEF PHP7}
  'zend_strndup'
  {$ELSE}
  'zend_strndup@@8'
  {$ENDIF});

  // -- _emalloc
  LFunc(@_emalloc,
  {$IFNDEF PHP7}
  '_emalloc'
  {$ELSE}
  '_emalloc@@4'
  {$ENDIF});


  // -- _efree
  LFunc(@_efree,
  {$IFNDEF PHP7}
  '_efree'
  {$ELSE}
  '_efree@@4'
  {$ENDIF});


  // -- _ecalloc
  LFunc(@_ecalloc,
  {$IFNDEF PHP7}
  '_ecalloc'
  {$ELSE}
  '_ecalloc@@8'
  {$ENDIF});


  // -- _erealloc
  LFunc(@_erealloc,
  {$IFNDEF PHP7}
  '_erealloc'
  {$else}
  '_erealloc@@8'
  {$ENDIF});


  // -- _estrdup
  LFunc(@_estrdup,
  {$IFNDEF PHP7}
  '_estrdup'
  {$ELSE}
  '_estrdup@@4'
  {$ENDIF});

  // -- _estrndup
  LFunc(@_estrndup,
  {$IFNDEF PHP7}
  '_estrndup'
  {$ELSE}
  '_estrndup@@8'
  {$ENDIF});

  // -- _estrndup  Unicode
  LFunc(@_estrndupu,
  {$IFNDEF PHP7}
  '_estrndup'
  {$ELSE}
  '_estrndup@@8'
  {$ENDIF});

  // -- zend_set_memory_limit
  LFunc(@zend_set_memory_limit, 'zend_set_memory_limit');

  // -- start_memory_manager
  LFunc(@start_memory_manager, 'start_memory_manager');

  // -- shutdown_memory_manager
  LFunc(@shutdown_memory_manager, 'shutdown_memory_manager');

  LFunc(@_zend_hash_init, '_zend_hash_init');
  LFunc(@_zend_hash_init_ex, '_zend_hash_init_ex');

  // -- zend_hash_add_or_update
  LFunc(@_zend_hash_add_or_update,
  {$IFDEF PHP7}'_zend_hash_add_or_update@@16'{$ELSE}'_zend_hash_add_or_update'{$ENDIF});

  // -- zend_hash_destroy
  LFunc(@zend_hash_destroy, {$IFDEF PHP7}'zend_hash_destroy@@4'{$ELSE}'zend_hash_destroy'{$ENDIF});

  // -- zend_hash_clean
  LFunc(@zend_hash_clean, {$IFDEF PHP7}'zend_hash_clean@@4'{$ELSE}'zend_hash_clean'{$ENDIF});

  // -- zend_hash_add_empty_element
  LFunc(@zend_hash_add_empty_element, {$IFDEF PHP7}'zend_hash_add_empty_element@@8'{$ELSE}'zend_hash_add_empty_element'{$ENDIF});

  // -- zend_hash_graceful_destroy
  LFunc(@zend_hash_graceful_destroy, {$IFDEF PHP7}'zend_hash_graceful_destroy@@4'{$ELSE}'zend_hash_graceful_destroy'{$ENDIF});

  // -- zend_hash_graceful_reverse_destroy
  LFunc(@zend_hash_graceful_reverse_destroy, {$IFDEF PHP7}'zend_hash_graceful_reverse_destroy@@4'{$ELSE}'zend_hash_graceful_reverse_destroy'{$ENDIF});

  // -- zend_hash_apply
  LFunc(@zend_hash_apply, {$IFDEF PHP7}'zend_hash_apply@@8'{$ELSE}'zend_hash_apply'{$ENDIF});

  // -- zend_hash_apply_with_argument
  LFunc(@zend_hash_apply_with_argument, {$IFDEF PHP7}'zend_hash_apply_with_argument@@12'{$ELSE}'zend_hash_apply_with_argument'{$ENDIF});

  // -- zend_hash_reverse_apply
  LFunc(@zend_hash_reverse_apply, {$IFDEF PHP7}'zend_hash_reverse_apply@@8'{$ELSE}'zend_hash_reverse_apply'{$ENDIF});

  // -- zend_hash_del_key_or_index
  LFunc(@zend_hash_del_key_or_index, {$IFDEF PHP7}'zend_hash_del@@8'{$ELSE}'zend_hash_del_key_or_index'{$ENDIF});

  // -- zend_get_hash_value
  LFunc(@zend_get_hash_value,
  {$IFDEF PHP560}'zend_hash_func'{$ELSE}'zend_get_hash_value'{$ENDIF});

  // -- zend_hash_find
  LFunc(@zend_hash_find, {$IFDEF PHP7}'zend_hash_find@@8'{$ELSE}'zend_hash_find'{$ENDIF});

  // -- zend_hash_quick_find
  LFunc(@zend_hash_quick_find, {$IFDEF PHP7}'zend_hash_find@@8'{$ELSE}'zend_hash_quick_find'{$ENDIF});

  // -- zend_hash_index_find
  LFunc(@zend_hash_index_find, {$IFDEF PHP7}'zend_hash_index_find@@8'{$ELSE}'zend_hash_index_find'{$ENDIF});

  // -- zend_hash_exists
  LFunc(@zend_hash_exists, {$IFDEF PHP7}'zend_hash_exists@@8'{$ELSE}'zend_hash_exists'{$ENDIF});

  // -- zend_hash_index_exists
  LFunc(@zend_hash_index_exists, {$IFDEF PHP7}'zend_hash_index_exists@@8'{$ELSE}'zend_hash_index_exists'{$ENDIF});
  {$IFDEF PHP7}
  LFunc(@_zend_hash_add_or_update, '_zend_hash_add_or_update@@16');
  LFunc(@_zend_hash_add, '_zend_hash_add@@12');
  {$IFDEF CUTTED_PHP7dll}
  LFunc(@zend_hash_index_findZval,'zend_hash_index_findZval');
  LFunc(@zend_symtable_findTest,'zend_symtable_findTest');
  LFunc(@zend_hash_index_existsZval,'zend_hash_index_existsZval');
  {$ENDIF}
  {$ELSE}
  // -- zend_hash_next_free_element
  LFunc(@zend_hash_next_free_element, 'zend_hash_next_free_element');
  {$ENDIF}
  // -- zend_hash_move_forward_ex
  LFunc(@zend_hash_move_forward_ex, {$IFDEF PHP7}'zend_hash_move_forward_ex@@8'{$ELSE}'zend_hash_move_forward_ex'{$ENDIF});

  // -- zend_hash_move_backwards_ex
  LFunc(@zend_hash_move_backwards_ex, {$IFDEF PHP7}'zend_hash_move_backwards_ex@@8'{$ELSE}'zend_hash_move_backwards_ex'{$ENDIF});

  // -- zend_hash_get_current_key_ex
  LFunc(@zend_hash_get_current_key_ex, {$IFDEF PHP7}'zend_hash_get_current_key_ex@@16'{$ELSE}'zend_hash_get_current_key_ex'{$ENDIF});

  // -- zend_hash_get_current_key_type_ex
  LFunc(@zend_hash_get_current_key_type_ex, {$IFDEF PHP7}'zend_hash_get_current_key_type_ex@@8'{$ELSE}'zend_hash_get_current_key_type_ex'{$ENDIF});

  // -- zend_hash_get_current_data_ex
  LFunc(@zend_hash_get_current_data_ex, {$IFDEF PHP7}'zend_hash_get_current_data_ex@@8'{$ELSE}'zend_hash_get_current_data_ex'{$ENDIF});

  // -- zend_hash_internal_pointer_reset_ex
  LFunc(@zend_hash_internal_pointer_reset_ex, {$IFDEF PHP7}'zend_hash_internal_pointer_reset_ex@@8'{$ELSE}'zend_hash_internal_pointer_reset_ex'{$ENDIF});

  // -- zend_hash_internal_pointer_end_ex
  LFunc(@zend_hash_internal_pointer_end_ex, {$IFDEF PHP7}'zend_hash_internal_pointer_end_ex@@8'{$ELSE}'zend_hash_internal_pointer_end_ex'{$ENDIF});

  // -- zend_hash_copy
  LFunc(@zend_hash_copy, {$IFDEF PHP7}'zend_hash_copy@@12'{$ELSE}'zend_hash_copy'{$ENDIF});


  // -- zend_hash_sort
  LFunc(@zend_hash_sort, {$IFDEF PHP7}'zend_hash_sort_ex@@16'{$ELSE}'zend_hash_sort'{$ENDIF});

  // -- zend_hash_compare
  LFunc(@zend_hash_compare, 'zend_hash_compare');

  // -- zend_hash_minmax
  LFunc(@zend_hash_minmax, {$IFDEF PHP7}'zend_hash_minmax@@12'{$ELSE}'zend_hash_minmax'{$ENDIF});

  // -- zend_hash_num_elements
  {$IFNDEF PHP7}
  LFunc(@zend_hash_num_elements, 'zend_hash_num_elements');
  {$ENDIF}

  // -- zend_hash_rehash
  LFunc(@zend_hash_rehash, {$IFDEF PHP7}'zend_hash_rehash@@4'{$ELSE}'zend_hash_rehash'{$ENDIF});

  // -- zend_hash_func
  LFunc(@zend_hash_func, 'zend_hash_func');

  // -- zend_get_constant
  LFunc(@zend_get_constant, 'zend_get_constant');

  // -- zend_register_null_constant
  LFunc(@zend_register_null_constant, 'zend_register_null_constant');

  // -- zend_register_bool_constant
  LFunc(@zend_register_bool_constant, 'zend_register_bool_constant');

  // -- zend_register_long_constant
  LFunc(@zend_register_long_constant, 'zend_register_long_constant');

  // -- zend_register_double_constant
  LFunc(@zend_register_double_constant, 'zend_register_double_constant');

  // -- zend_register_string_constant
  LFunc(@zend_register_string_constant, 'zend_register_string_constant');

  // -- zend_register_stringl_constant
  LFunc(@zend_register_stringl_constant, 'zend_register_stringl_constant');

  // -- zend_register_constant
  LFunc(@zend_register_constant, 'zend_register_constant');

  LFunc(@zend_register_auto_global, 'zend_register_auto_global');
  {$IFDEF PHP5}
  LFunc(@zend_activate_auto_globals, 'zend_activate_auto_globals');
  {$ENDIF}

  // -- tsrm_shutdown
  LFunc(@tsrm_shutdown, 'tsrm_shutdown');

  // -- ts_resource_ex
  LFunc(@ts_resource_ex, 'ts_resource_ex');

  // -- ts_free_thread
  LFunc(@ts_free_thread, 'ts_free_thread');

  // -- zend_error
  LFunc(@zend_error, 'zend_error');

  // -- zend_error_cb
  LFunc(@zend_error_cb, 'zend_error_cb');

  // -- zend_eval_string
  LFunc(@zend_eval_string, 'zend_eval_string');

  // -- zend_eval_string
  LFunc(@zend_eval_string_ex, 'zend_eval_string_ex');

  // -- zend_make_compiled_string_description
  LFunc(@zend_make_compiled_string_description, 'zend_make_compiled_string_description');

  LFunc(@_zval_copy_ctor_func, {$IFDEF PHP7}'_zval_copy_ctor_func@@4'{$ELSE}'_zval_copy_ctor_func'{$ENDIF});
  LFunc(@_zval_dtor_func, {$IFDEF PHP7}'_zval_dtor_func@@4'{$ELSE}'_zval_dtor_func'{$ENDIF});
  LFunc(@_zval_ptr_dtor, '_zval_ptr_dtor');

  // -- zend_print_variable
  LFunc(@zend_print_variable, 'zend_print_variable');

  // -- zend_stack_init
  LFunc(@zend_stack_init, 'zend_stack_init');

  // -- zend_stack_push
  LFunc(@zend_stack_push, 'zend_stack_push');

  // -- zend_stack_top
  LFunc(@zend_stack_top, 'zend_stack_top');

  // -- zend_stack_del_top
  LFunc(@zend_stack_del_top, 'zend_stack_del_top');

  // -- zend_stack_int_top
  LFunc(@zend_stack_int_top, 'zend_stack_int_top');

  // -- zend_stack_is_empty
  LFunc(@zend_stack_is_empty, 'zend_stack_is_empty');

  // -- zend_stack_destroy
  LFunc(@zend_stack_destroy, 'zend_stack_destroy');

  // -- zend_stack_base
  LFunc(@zend_stack_base, 'zend_stack_base');

  // -- zend_stack_count
  LFunc(@zend_stack_count, 'zend_stack_count');

  // -- zend_stack_apply
  LFunc(@zend_stack_apply, 'zend_stack_apply');

  // -- zend_stack_apply_with_argument
  LFunc(@zend_stack_apply_with_argument, 'zend_stack_apply_with_argument');

  // -- _convert_to_string
  LFunc(@_convert_to_string, {$IFDEF PHP7}'_convert_to_string@@4'{$ELSE}'_convert_to_string'{$ENDIF});

  // -- add_function
  LFunc(@add_function, {$IFDEF PHP7}'add_function@@12'{$ELSE}'add_function'{$ENDIF});

  // -- sub_function
  LFunc(@sub_function, {$IFDEF PHP7}'sub_function@@12'{$ELSE}'sub_function'{$ENDIF});

  // -- mul_function
  LFunc(@mul_function, {$IFDEF PHP7}'mul_function@@12'{$ELSE}'mul_function'{$ENDIF});

  // -- div_function
  LFunc(@div_function, {$IFDEF PHP7}'div_function@@12'{$ELSE}'div_function'{$ENDIF});

  // -- mod_function
  LFunc(@mod_function, {$IFDEF PHP7}'mod_function@@12'{$ELSE}'mod_function'{$ENDIF});

  // -- boolean_xor_function
  LFunc(@boolean_xor_function, {$IFDEF PHP7}'boolean_xor_function@@12'{$ELSE}'boolean_xor_function'{$ENDIF});

  // -- boolean_not_function
  LFunc(@boolean_not_function, {$IFDEF PHP7}'boolean_not_function@@8'{$ELSE}'boolean_not_function'{$ENDIF});

  // -- bitwise_not_function
  LFunc(@bitwise_not_function, {$IFDEF PHP7}'bitwise_not_function@@8'{$ELSE}'bitwise_not_function'{$ENDIF});

  // -- bitwise_or_function
  LFunc(@bitwise_or_function, {$IFDEF PHP7}'bitwise_or_function@@12'{$ELSE}'bitwise_or_function'{$ENDIF});

  // -- bitwise_and_function
  LFunc(@bitwise_and_function, {$IFDEF PHP7}'bitwise_and_function@@12'{$ELSE}'bitwise_and_function'{$ENDIF});

  // -- bitwise_xor_function
  LFunc(@bitwise_xor_function, {$IFDEF PHP7}'bitwise_xor_function@@12'{$ELSE}'bitwise_xor_function'{$ENDIF});

  // -- shift_left_function
  LFunc(@shift_left_function, {$IFDEF PHP7}'shift_left_function@@12'{$ELSE}'shift_left_function'{$ENDIF});

  // -- shift_right_function
  LFunc(@shift_right_function, {$IFDEF PHP7}'shift_right_function@@12'{$ELSE}'shift_right_function'{$ENDIF});

  // -- concat_function
  LFunc(@concat_function, {$IFDEF PHP7}'concat_function@@12'{$ELSE}'concat_function'{$ENDIF});

  // -- is_equal_function
  LFunc(@is_equal_function, {$IFDEF PHP7}'is_equal_function@@12'{$ELSE}'is_equal_function'{$ENDIF});

  // -- is_identical_function
  LFunc(@is_identical_function, {$IFDEF PHP7}'is_identical_function@@12'{$ELSE}'is_identical_function'{$ENDIF});

  // -- is_not_identical_function
  LFunc(@is_not_identical_function, {$IFDEF PHP7}'is_not_identical_function@@12'{$ELSE}'is_not_identical_function'{$ENDIF});

  // -- is_not_equal_function
  LFunc(@is_not_equal_function, {$IFDEF PHP7}'is_not_equal_function@@12'{$ELSE}'is_not_equal_function'{$ENDIF});

  // -- is_smaller_function
  LFunc(@is_smaller_function, {$IFDEF PHP7}'is_smaller_function@@12'{$ELSE}'is_smaller_function'{$ENDIF});

  // -- is_smaller_or_equal_function
  LFunc(@is_smaller_or_equal_function, {$IFDEF PHP7}'is_smaller_or_equal_function@@12'{$ELSE}'is_smaller_or_equal_function'{$ENDIF});

  // -- increment_function
  LFunc(@increment_function, {$IFDEF PHP7}'increment_function@@4'{$ELSE}'increment_function'{$ENDIF});

  // -- decrement_function
  LFunc(@decrement_function, {$IFDEF PHP7}'decrement_function@@4'{$ELSE}'decrement_function'{$ENDIF});

  // -- convert_scalar_to_number
  LFunc(@convert_scalar_to_number, {$IFDEF PHP7}'convert_scalar_to_number@@4'{$ELSE}'convert_scalar_to_number'{$ENDIF});

  // -- convert_to_long
  LFunc(@convert_to_long, {$IFDEF PHP7}'convert_to_long@@4'{$ELSE}'convert_to_long'{$ENDIF});

  // -- convert_to_double
  LFunc(@convert_to_double, {$IFDEF PHP7}'convert_to_double@@4'{$ELSE}'convert_to_double'{$ENDIF});

  // -- convert_to_long_base
  LFunc(@convert_to_long_base, {$IFDEF PHP7}'convert_to_long_base@@8'{$ELSE}'convert_to_long_base'{$ENDIF});

  // -- convert_to_null
  LFunc(@convert_to_null, {$IFDEF PHP7}'convert_to_null@@4'{$ELSE}'convert_to_null'{$ENDIF});

  // -- convert_to_boolean
  LFunc(@convert_to_boolean, {$IFDEF PHP7}'convert_to_boolean@@4'{$ELSE}'convert_to_boolean'{$ENDIF});

  // -- convert_to_array
  LFunc(@convert_to_array, {$IFDEF PHP7}'convert_to_array@@4'{$ELSE}'convert_to_array'{$ENDIF});

  // -- convert_to_object
  LFunc(@convert_to_object, {$IFDEF PHP7}'convert_to_object@@4'{$ELSE}'convert_to_object'{$ENDIF});
  {$IFNDEF PHP7}
  // -- add_char_to_string
  LFunc(@add_char_to_string, 'add_char_to_string');

  // -- add_string_to_string
  LFunc(@add_string_to_string, 'add_string_to_string');
  {$ENDIF}
  // -- zend_string_to_double
  LFunc(@zend_string_to_double, {$IFDEF PHP7}'zend_strtod'{$ELSE}'zend_string_to_double'{$ENDIF});

  // -- zval_is_true
  LFunc(@zval_is_true, {$IFDEF PHP7}'zend_is_true@@4'{$ELSE}'zval_is_true'{$ENDIF});

  // -- compare_function
  LFunc(@compare_function, {$IFDEF PHP7}'compare_function@@12'{$ELSE}'compare_function'{$ENDIF});

  // -- numeric_compare_function
  LFunc(@numeric_compare_function, {$IFDEF PHP7}'numeric_compare_function@@8'{$ELSE}'numeric_compare_function'{$ENDIF});

  // -- string_compare_function
  LFunc(@string_compare_function, {$IFDEF PHP7}'string_compare_function@@8'{$ELSE}'string_compare_function'{$ENDIF});

  // -- zend_str_tolower
  LFunc(@zend_str_tolower, {$IFDEF PHP7}'zend_str_tolower@@8'{$ELSE}'zend_str_tolower'{$ENDIF});

  // -- zend_binary_zval_strcmp
  LFunc(@zend_binary_zval_strcmp, {$IFDEF PHP7}'zend_binary_zval_strcmp@@8'{$ELSE}'zend_binary_zval_strcmp'{$ENDIF});

  // -- zend_binary_zval_strncmp
  LFunc(@zend_binary_zval_strncmp, {$IFDEF PHP7}'zend_binary_zval_strncmp@@12'{$ELSE}'zend_binary_zval_strncmp'{$ENDIF});

  // -- zend_binary_zval_strcasecmp
  LFunc(@zend_binary_zval_strcasecmp, {$IFDEF PHP7}'zend_binary_zval_strcasecmp@@8'{$ELSE}'zend_binary_zval_strcasecmp'{$ENDIF});

  // -- zend_binary_zval_strncasecmp
  LFunc(@zend_binary_zval_strncasecmp, {$IFDEF PHP7}'zend_binary_zval_strncasecmp@@12'{$ELSE}'zend_binary_zval_strncasecmp'{$ENDIF});

  // -- zend_binary_strcmp
  LFunc(@zend_binary_strcmp, {$IFDEF PHP7}'zend_binary_strcmp@@16'{$ELSE}'zend_binary_strcmp'{$ENDIF});

  // -- zend_binary_strncmp
  LFunc(@zend_binary_strncmp, {$IFDEF PHP7}'zend_binary_strncmp@@20'{$ELSE}'zend_binary_strncmp'{$ENDIF});

  // -- zend_binary_strcasecmp
  LFunc(@zend_binary_strcasecmp, {$IFDEF PHP7}'zend_binary_strcasecmp@@16'{$ELSE}'zend_binary_strcasecmp'{$ENDIF});

  // -- zend_binary_strncasecmp
  LFunc(@zend_binary_strncasecmp, {$IFDEF PHP7}'zend_binary_strncasecmp@@20'{$ELSE}'zend_binary_strncasecmp'{$ENDIF});

  // -- zendi_smart_strcmp
  LFunc(@zendi_smart_strcmp, {$IFDEF PHP7}'zendi_smart_strcmp@@8'{$ELSE}'zendi_smart_strcmp'{$ENDIF});

  // -- zend_compare_symbol_tables
  LFunc(@zend_compare_symbol_tables, {$IFDEF PHP7}'zend_compare_symbol_tables@@8'{$ELSE}'zend_compare_symbol_tables'{$ENDIF});

  // -- zend_compare_arrays
  LFunc(@zend_compare_arrays, {$IFDEF PHP7}'zend_compare_arrays@@8'{$ELSE}'zend_compare_arrays'{$ENDIF});

  // -- zend_compare_objects
  LFunc(@zend_compare_objects, {$IFDEF PHP7}'zend_compare_objects@@8'{$ELSE}'zend_compare_objects'{$ENDIF});

  // -- zend_atoi
  LFunc(@zend_atoi, {$IFDEF PHP7}'zend_atoi@@8'{$ELSE}'zend_atoi'{$ENDIF});

  // -- get_active_function_name
  LFunc(@get_active_function_name, 'get_active_function_name');

  // -- zend_get_executed_filename
  LFunc(@zend_get_executed_filename, 'zend_get_executed_filename');

  // -- zend_get_executed_lineno
  LFunc(@zend_get_executed_lineno, 'zend_get_executed_lineno');

  // -- zend_set_timeout
  LFunc(@zend_set_timeout, 'zend_set_timeout');

  // -- zend_unset_timeout
  LFunc(@zend_unset_timeout, 'zend_unset_timeout');

  // -- zend_timeout
  LFunc(@zend_timeout, 'zend_timeout');

  // -- zend_highlight
  LFunc(@zend_highlight, 'zend_highlight');

  // -- zend_strip
  LFunc(@zend_strip, 'zend_strip');

  // -- highlight_file
  LFunc(@highlight_file, 'highlight_file');

  // -- highlight_string
  LFunc(@highlight_string, 'highlight_string');

  // -- zend_html_putc
  LFunc(@zend_html_putc, 'zend_html_putc');

  // -- zend_html_puts
  LFunc(@zend_html_puts, 'zend_html_puts');

  LFunc(@zend_parse_method_parameters, 'zend_parse_method_parameters');
  LFunc(@zend_parse_method_parameters_ex, 'zend_parse_method_parameters_ex');

  {$IFDEF PHP7}
  // -- zend_parse_parameters_throw
  LFunc(@zend_parse_parameters_throw, 'zend_parse_parameters_throw');
  LFunc(@ZvalGetArgs, 'zend_get_parameters_ex');
  {$ELSE}
  // -- zend_indent
  LFunc(@zend_indent, 'zend_indent');
  {$ENDIF}
  // -- _zend_get_parameters_array
  LFunc(@_zend_get_parameters_array, '_zend_get_parameters_array');

  // -- _zend_get_parameters_array_ex
  LFunc(@_zend_get_parameters_array_ex, '_zend_get_parameters_array_ex');

  // -- zend_ini_refresh_caches
  LFunc(@zend_ini_refresh_caches, 'zend_ini_refresh_caches');

  // -- zend_alter_ini_entry
  LFunc(@zend_alter_ini_entry, 'zend_alter_ini_entry');
  LFunc(@zend_alter_ini_entry_ex, 'zend_alter_ini_entry_ex');
  // -- zend_restore_ini_entry
  LFunc(@zend_restore_ini_entry, 'zend_restore_ini_entry');

  // -- zend_ini_long
  LFunc(@zend_ini_long, 'zend_ini_long');

  // -- zend_ini_double
  LFunc(@zend_ini_double, 'zend_ini_double');

  // -- zend_ini_string
  LFunc(@zend_ini_string, 'zend_ini_string');

  // -- compile_string
  LFunc(@compile_string, 'compile_string');

  // -- execute
  LFunc(@execute, {$IFDEF PHP550}'zend_execute'{$ELSE}'execute'{$ENDIF});

  // -- zend_wrong_param_count
  LFunc(@zend_wrong_param_count, 'zend_wrong_param_count');

  // -- zend_hash_quick_add_or_update
  LFunc(@_zend_hash_quick_add_or_update, '_zend_hash_quick_add_or_update');

  // -- add_property_long_ex
  LFunc(@add_property_long_ex, 'add_property_long_ex');

  // -- add_property_null_ex
  LFunc(@add_property_null_ex, 'add_property_null_ex');

  // -- add_property_bool_ex
  LFunc(@add_property_bool_ex, 'add_property_bool_ex');

  // -- add_property_resource_ex
  LFunc(@add_property_resource_ex, 'add_property_resource_ex');

  // -- add_property_double_ex
  LFunc(@add_property_double_ex, 'add_property_double_ex');

  // -- add_property_string_ex
  LFunc(@add_property_string_ex, 'add_property_string_ex');

  // -- add_property_stringl_ex
  LFunc(@add_property_stringl_ex, 'add_property_stringl_ex');

  // -- add_property_zval_ex
  LFunc(@add_property_zval_ex, 'add_property_zval_ex');

  LFunc(@call_user_function, {$IFDEF CUTTED_PHP7dll}'__call_function'{$ELSE}'call_user_function'{$ENDIF});
  {$IFNDEF CUTTED_PHP7dll}
  LFunc(@call_user_function_ex, 'call_user_function_ex');
  {$ENDIF}
  // -- add_assoc_long_ex
  LFunc(@add_assoc_long_ex, 'add_assoc_long_ex');

  // -- add_assoc_null_ex
  LFunc(@add_assoc_null_ex, 'add_assoc_null_ex');

  // -- add_assoc_bool_ex
  LFunc(@add_assoc_bool_ex, 'add_assoc_bool_ex');

  // -- add_assoc_resource_ex
  LFunc(@add_assoc_resource_ex, 'add_assoc_resource_ex');

  // -- add_assoc_double_ex
  LFunc(@add_assoc_double_ex, 'add_assoc_double_ex');

  // -- add_assoc_string_ex
  LFunc(@add_assoc_string_ex, 'add_assoc_string_ex');

  // -- add_assoc_stringl_ex
  LFunc(@add_assoc_stringl_ex, 'add_assoc_stringl_ex');

  // -- add_assoc_zval_ex
  LFunc(@add_assoc_zval_ex, 'add_assoc_zval_ex');

  // -- add_index_long
  LFunc(@add_index_long, 'add_index_long');

  // -- add_index_null
  LFunc(@add_index_null, 'add_index_null');

  // -- add_index_bool
  LFunc(@add_index_bool, 'add_index_bool');

  // -- add_index_resource
  LFunc(@add_index_resource, 'add_index_resource');

  // -- add_index_double
  LFunc(@add_index_double, 'add_index_double');

  // -- add_index_string
  LFunc(@add_index_string, 'add_index_string');

  // -- add_index_stringl
  LFunc(@add_index_stringl, 'add_index_stringl');

  // -- add_index_zval
  LFunc(@add_index_zval, 'add_index_zval');

  // -- add_next_index_long
  LFunc(@add_next_index_long, 'add_next_index_long');

  // -- add_next_index_null
  LFunc(@add_next_index_null, 'add_next_index_null');

  // -- add_next_index_bool
  LFunc(@add_next_index_bool, 'add_next_index_bool');

  // -- add_next_index_resource
  LFunc(@add_next_index_resource, 'add_next_index_resource');

  // -- add_next_index_double
  LFunc(@add_next_index_double, 'add_next_index_double');

  // -- add_next_index_string
  LFunc(@add_next_index_string, 'add_next_index_string');

  // -- add_next_index_stringl
  LFunc(@add_next_index_stringl, 'add_next_index_stringl');

  // -- add_next_index_zval
  LFunc(@add_next_index_zval, 'add_next_index_zval');

  // -- add_get_assoc_string_ex
  LFunc(@add_get_assoc_string_ex, 'add_get_assoc_string_ex');

  // -- add_get_assoc_stringl_ex
  LFunc(@add_get_assoc_stringl_ex, 'add_get_assoc_stringl_ex');

  // -- add_get_index_long
  LFunc(@add_get_index_long, 'add_get_index_long');

  // -- add_get_index_double
  LFunc(@add_get_index_double, 'add_get_index_double');

  // -- add_get_index_string
  LFunc(@add_get_index_string, 'add_get_index_string');

  // -- add_get_index_stringl
  LFunc(@add_get_index_stringl, 'add_get_index_stringl');

  // -- _array_init
  LFunc(@_array_init, '_array_init');

  // -- _object_init
  LFunc(@_object_init, '_object_init');

  // -- _object_init_ex
  LFunc(@_object_init_ex, '_object_init_ex');

  // -- _object_and_properties_init
  LFunc(@_object_and_properties_init, '_object_and_properties_init');

  // -- zend_register_internal_class
  LFunc(@zend_register_internal_class, 'zend_register_internal_class');

  // -- zend_register_internal_class_ex
  LFunc(@zend_register_internal_class_ex, 'zend_register_internal_class_ex');

  // -- zend_startup_module
  LFunc(@zend_startup_module, 'zend_startup_module');

  // -- zend_startup_module_ex
  LFunc(@zend_startup_module_ex, 'zend_startup_module_ex');

  // -- zend_register_module_ex
  LFunc(@zend_register_module_ex, 'zend_register_module_ex');

  // --  zend_register_internal_module
  LFunc(@zend_register_internal_module, 'zend_register_internal_module');

  // -- zend_startup_modules
  LFunc(@zend_startup_modules, 'zend_startup_modules');

  // -- zend_collect_module_handlers
  LFunc(@zend_collect_module_handlers, 'zend_collect_module_handlers');

  // -- get_zend_version
  LFunc(@get_zend_version, 'get_zend_version');

  // -- zend_make_printable_zval
  LFunc(@zend_make_printable_zval, 'zend_make_printable_zval');

  // -- zend_print_zval
  LFunc(@zend_print_zval, 'zend_print_zval');

  // -- zend_print_zval_r
  LFunc(@zend_print_zval_r, 'zend_print_zval_r');

  // -- zend_output_debug_string
  LFunc(@zend_output_debug_string, 'zend_output_debug_string');

  // -- zend_get_parameters
  LFunc(@Zend_Get_Parameters, 'zend_get_parameters');

  // - zend_get_parameters_ex (native call)
  LFunc(@zend_get_params_ex, 'zend_get_parameters_ex');
  {$IFDEF PHP5}
  LFunc(@zend_destroy_file_handle, 'zend_destroy_file_handle');
  {$ENDIF}

  LFunc(WriteFuncPtr, 'zend_write');
  if Assigned(WriteFuncPtr) then
    @zend_write := pointer(WriteFuncPtr^);

  Result := true;
end;

procedure ZEND_PUTS(str: zend_pchar);
begin
  if assigned(str) then
    zend_write(str, strlen(str));
end;

procedure convert_to_string(op: pzval);
begin
  _convert_to_string(op, nil, 0);
end;

procedure INIT_CLASS_ENTRY(var class_container: Tzend_class_entry; class_name: zend_pchar; functions: {$IFDEF PHP7}HashTable{$ELSE}pointer{$ENDIF});
begin

  if class_name = nil then
   Exit;

  ZeroMemory(@class_container, sizeof(Tzend_class_entry));

  {$IFNDEF COMPILER_VC9}
  class_container.name := strdup(class_name);
  {$ELSE}
  {$IFDEF PHP7}
      class_container.name.val := estrdup(class_name);
    {$ELSE}
      class_container.name := estrdup(class_name);
    {$ENDIF}
  {$ENDIF}
  {$IFDEF PHP7}
   class_container.name.len := strlen(class_name);
   class_container.function_table := functions;
  {$ELSE}
  class_container.name_length := strlen(class_name);
  class_container.builtin_functions := functions;
  {$ENDIF}
end;
{$IFNDEF PHP7}
function ZEND_FAST_ALLOC: pzval;
begin
  Result := emalloc(sizeof(zval));
end;

function ALLOC_ZVAL: pzval;
begin
  Result := emalloc(sizeof(zval));
end;

procedure ALLOC_ZVAL(out Result: pzval);
begin
  Result := emalloc(sizeof(zval));
end;
{$ENDIF}
procedure INIT_PZVAL(p: pzval);
begin
  {$IFDEF PHP7}
  p^.value.counted.gc.refcount := 1;
  {$ELSE}
  p^.refcount := 1;
  p^.is_ref := 0;
  {$ENDIF}
end;

procedure LOCK_ZVAL(p: pzval);
begin
  Inc({$IFDEF PHP7}
  p^.value.counted.gc.refcount{$ELSE}p^.refcount{$ENDIF});
end;

procedure UNLOCK_ZVAL(p: pzval);
begin
  if {$IFDEF PHP7}
  p^.value.counted.gc.refcount{$ELSE}p^.refcount{$ENDIF} > 0 then
    Dec({$IFDEF PHP7}
  p^.value.counted.gc.refcount{$ELSE}p^.refcount{$ENDIF});
end;

function MAKE_STD_ZVAL: pzval;
begin
  {$IFNDEF PHP7}
    Result := ALLOC_ZVAL;
  {$ENDIF}
  INIT_PZVAL(Result);
end;

function zend_get_parameters_my(number: integer; var Params: pzval_array; TSRMLS_DC: Pointer): integer;
var
  i  : integer;

  p:
  {$IFDEF PHP7}
  pzval
  {$ELSE}
  pppzval
  {$ENDIF};
begin
  if number = 0 then
  begin
    Result := SUCCESS;
    Exit;
  end;
  {$IFDEF PHP7}
  Params.value.arr.nNumOfElements := number;
  for i := 0 to number - 1 do
    zend_hash_index_add_empty_element(Params.value.arr, i);

  p := emalloc(number * sizeOf(zval));
  Result := _zend_get_parameters_array_ex(number, p);

  for i := 0 to number - 1 do
  begin
    _zend_hash_update_ind(Params.value.arr, i, p, '', 0);
     if i <> number then
         inc(integer(p), sizeof(zval));
  end;

  efree(p);
    _zend_get_parameters_array_ex(number, p);
  {$ELSE}
  SetLength(Params, number);
  for i := 0 to number - 1 do
    New(Params[i]);

  p := emalloc(number * sizeOf(ppzval));
  Result := _zend_get_parameters_array_ex(number, p, TSRMLS_DC);

  for i := 0 to number - 1 do
  begin
     Params[i]^ :=  p^^;
     if i <> number then
     {$IFDEF CPUX64}
        p^ := ppzval( integer(p^) + sizeof(ppzval) );
     {$ELSE}
         inc(integer(p^), sizeof(ppzval));
     {$ENDIF}
  end;

  efree(p);
  {$ENDIF}
end;

procedure dispose_pzval_array(Params: pzval_array);
var
  i : integer;
begin
  {$IFDEF PHP7}
  if Params.value.arr.nNumOfElements>0 then
    for i := 0 to Params.value.arr.nNumOfElements-1 do
      Freemem(zend_hash_index_findZval(Params,i));
  {$ELSE}
  if Length(Params)>0 then
  for i := 0 to High(Params) do
    FreeMem(Params[i]);
  {$ENDIF}
  Params := nil;
end;

{ EPHP4DelphiException }

constructor EPHP4DelphiException.Create(const Msg: zend_ustr);
begin
  inherited Create('Unable to link '+ Msg+' function');
end;

{procedure zenderror(Error : zend_pchar);
begin
  zend_error(E_PARSE, Error);
end;}

function zend_hash_get_current_data(ht:  {$IFDEF PHP7} Pzend_array {$ELSE} PHashTable{$ENDIF}; pData: Pointer): Integer; cdecl;
begin
  result := zend_hash_get_current_data_ex(ht, pData, cardinal(nil));
end;

procedure zend_hash_internal_pointer_reset(ht:  {$IFDEF PHP7} Pzend_array {$ELSE} PHashTable{$ENDIF}); cdecl;
begin
  zend_hash_internal_pointer_reset_ex(ht, cardinal(nil));
end;

function ts_resource(id : integer) : pointer;
begin
  result := ts_resource_ex(id, nil);
end;

function tsrmls_fetch : pointer;
begin
  result := ts_resource_ex(0, nil);
end;

function zend_unregister_functions(functions : {$IFDEF PHP7}P_zend_function_entry{$ELSE}pzend_function_entry{$ENDIF}; count : integer; function_table :  {$IFDEF PHP7} Pzend_array {$ELSE} PHashTable{$ENDIF}; TSRMLS_DC : pointer) : integer;
var
 i : integer;
 {$IFDEF PHP7}
 pzs: pzend_string;
 {$ENDIF}
 ptr : {$IFDEF PHP7}P_zend_function_entry{$ELSE}pzend_function_entry{$ENDIF};
begin
  Result := SUCCESS;
  i := 0;
  ptr := functions;
  if ptr = nil then
   Exit;
  while ptr.fname <> nil do
   begin
     if ( count <> -1 ) and (i >= count) then
      break;
      {$IFDEF PHP7}
      pzs^.len := strlen(ptr.fname);
      pzs^.val := estrdup(ptr.fname);
      zend_hash_del_key_or_index(function_table, pzs);
      {$ELSE}
      zend_hash_del_key_or_index(function_table, ptr.fname, strlen(ptr.fname) +1, 0, HASH_DEL_KEY);
      {$ENDIF}
      inc(ptr);
      inc(i);
   end;
end;

// registers all functions in *library_functions in the function hash

function zend_register_functions(functions : {$IFDEF PHP7}P_zend_function_entry{$ELSE}pzend_function_entry{$ENDIF};  function_table :  {$IFDEF PHP7} Pzend_array {$ELSE} PHashTable{$ENDIF}; _type: integer;  TSRMLS_DC : pointer) : integer;
var
 ptr : {$IFDEF PHP7}P_zend_function_entry{$ELSE}pzend_function_entry{$ENDIF};
 _function : {$IFDEF PHP7} _zend_function{$ELSE}zend_function{$ENDIF};
 internal_function :{$IFDEF PHP7}P_zend_internal_function{$ELSE}PzendInternalFunction{$ENDIF};
  count : integer;
  unload : integer;
  target_function_table :  {$IFDEF PHP7} Pzend_array {$ELSE} PHashTable{$ENDIF};
  error_type : integer;

begin
 Result := FAILURE;
 if functions = nil then
  Exit;
  ptr := functions;
  count := 0;
  unload := 0;
  if _type = MODULE_PERSISTENT then
   error_type := E_CORE_WARNING
    else
      error_type := E_WARNING;

  internal_function := @_function;
  target_function_table  := function_table;

  if (target_function_table = nil) then
    target_function_table :=  GetCompilerGlobals.function_table;


  internal_function._type := ZEND_INTERNAL_FUNCTION;

  while (ptr.fname <> nil) do
    begin
      internal_function.handler := ptr.handler;
      {$IFDEF PHP7}
      internal_function.function_name.val := ptr.fname;
      {$ELSE}
      internal_function.function_name := ptr.fname;
      {$ENDIF}
      if not Assigned(internal_function.handler) then begin
     	zend_error(error_type, 'Null function defined as active function');
	zend_unregister_functions(functions, count, target_function_table, TSRMLS_DC);
	Result := FAILURE;
        Exit;
       end;

     if (zend_hash_add_or_update(target_function_table, ptr.fname, strlen(ptr.fname)+1, @_function, sizeof(zend_function), nil, HASH_ADD) = FAILURE) then
       begin
         unload:=1;
         break;
       end;
      inc(ptr);
      inc(count);
     end;


     if (unload = 1) then begin  // before unloading, display all remaining bad function in the module */
	while (ptr.fname<> nil) do begin
          if (zend_hash_exists(target_function_table, ptr.fname, strlen(ptr.fname)+1)) = 1 then
          begin
            zend_error(error_type, zend_pchar(Format('Function registration failed - duplicate name - %s', [ptr.fname])));
	  end;
	   inc(ptr);
	 end;
	 zend_unregister_functions(functions, count, target_function_table, TSRMLS_DC);
         result := FAILURE;
         Exit;
      end;
    Result := SUCCESS;

end;

function __asm_fetchval
{$IFDEF CPUX64}
(val_id: int64; tsrmls_dc_p: pointer)
{$ELSE}
(val_id: integer; tsrmls_dc_p: pointer)
{$ENDIF}
: pointer; assembler; register;
{$IFDEF CPUX64}
asm
  mov rcx, val_id
  mov rdx, dword64 ptr tsrmls_dc_p
  mov rax, dword64 ptr [rdx]
  mov rcx, dword64 ptr [rax+rcx*8-8]
  mov Result, rcx
end;
{$ELSE}
asm
  mov ecx, val_id
  mov edx, dword ptr tsrmls_dc_p
  mov eax, dword ptr [edx]
  mov ecx, dword ptr [eax+ecx*4-4]
  mov Result, ecx
end;
{$ENDIF}

function GetGlobalResource(resource_name: AnsiString) : pointer;
var
 global_id : pointer;
begin
  Result := nil;
  try
    global_id := GetProcAddress(PHPLib, zend_pchar(resource_name));
    if Assigned(global_id) then
     begin
       Result := __asm_fetchval(integer(global_id^), tsrmls_fetch);
     end;
  except
    Result := nil;
  end;
end;

function GetGlobalResourceDC(resource_name: AnsiString;TSRMLS_DC:pointer) : pointer;
var
 global_id : pointer;
begin
  Result := nil;
  try
    global_id := GetProcAddress(PHPLib, zend_pchar(resource_name));
    if Assigned(global_id) then
     begin
       Result := __asm_fetchval(integer(global_id^), TSRMLS_DC);
     end;
  except
    Result := nil;
  end;
end;

function GetCompilerGlobals : Pzend_compiler_globals;
begin
  result := GetGlobalResource('compiler_globals_id');
end;

function GetExecutorGlobals : pzend_executor_globals;
begin
  result := GetGlobalResource('executor_globals_id');
end;

function GetAllocGlobals : pointer;
begin
  result := GetGlobalResource('alloc_globals_id');
end;

{$IFDEF PHP5}

procedure zend_addref_p;
begin
    Inc({$IFDEF PHP7}z.value.counted.gc.refcount{$ELSE}z.refcount{$ENDIF});
end;

procedure my_class_add_ref;
begin
    Inc(aclass^^.refcount,1);
end;

procedure copy_zend_constant(C: PZendConstant); cdecl;
  var
  I: Integer;
begin
    C^.name := zend_strndup(C^.name, C^.name_len - 1);
    I := c^.flags and CONST_PERSISTENT;
    if I > 0 then
        _zval_copy_ctor(@c.value, nil, 0);
end;

function object_init(arg: pzval; ce: pzend_class_entry; TSRMLS_DC : pointer) : integer; cdecl; assembler;
{$IFDEF CPUX64}
asm
  mov rax, [rsp + 32]
  mov rcx, [rsp + 24]
  mov rdx, [rsp + 16]
  pop rbp
  push rax
  push rcx
  push rdx
  call _object_init_ex
  add rsp, $0c
  ret
end;
{$ELSE}
asm
  mov eax, [esp + 16]
  mov ecx, [esp + 12]
  mov edx, [esp + 8]
  pop ebp
  push eax
  push ecx
  push edx
  call _object_init_ex
  add esp, $0c
  ret
end;
{$ENDIF}


function Z_LVAL(z : pzval) : longint;
begin
  if z = nil then
  begin
      Result := 0;
      exit;
  end;

  if {$IFDEF PHP7}z.u1.v._type{$ELSE}z._type{$ENDIF} = IS_LONG then
  Result := z.value.lval
  else
    case {$IFDEF PHP7}z.u1.v._type{$ELSE}z._type{$ENDIF} of
       IS_DOUBLE: Result := Trunc(z.value.dval);
       IS_BOOL  : Result := z.value.lval;
       IS_STRING: Result := StrToIntDef( Z_STRVAL(z), 0 );
       else
          Result := 0;
    end;
end;

function Z_BVAL(z : pzval) : boolean;
begin
  if z = nil then
  begin
      Result := false;
      exit;
  end;

  if {$IFDEF PHP7}z.u1.v._type{$ELSE}z._type{$ENDIF} = IS_BOOL then
     Result := boolean(zend_bool(z.value.lval))
  else
    case {$IFDEF PHP7}z.u1.v._type{$ELSE}z._type{$ENDIF} of
       IS_DOUBLE: if Trunc(z.value.dval) = 0 then Result := false else Result := true;
       IS_LONG  : if z.value.lval = 0 then Result := false else Result := true;
       IS_STRING: if Z_STRVAL(z) = '' then Result := False else Result := True;
       else
          Result := False;
    end;
  //Result := zend_bool(z.value.lval);
end;

function Z_DVAL(z : pzval) : double;
begin
  if z = nil then
  begin
      Result := 0;
      exit;
  end;

  if {$IFDEF PHP7}z.u1.v._type{$ELSE}z._type{$ENDIF} = IS_DOUBLE then
     Result := z.value.dval
  else
    case {$IFDEF PHP7}z.u1.v._type{$ELSE}z._type{$ENDIF} of
       IS_LONG, IS_BOOL:  Result := z.value.lval;
       IS_STRING: Result := StrToFloatDef( Z_STRVAL(z), 0 );
       else
          Result := 0;
    end;
end;

function Z_VARREC(z: pzval): TVarRec;
  Var
  P: zend_ustr;
begin
  if z = nil then
  begin
      Result.VType := vtBoolean;
      Result.VBoolean := false;
      exit;
  end;

    case {$IFDEF PHP7}z.u1.v._type{$ELSE}z._type{$ENDIF} of
        IS_BOOL: begin
            Result.VType := vtBoolean;
            Result.VBoolean := Boolean(z.value.lval);
        end;
        IS_LONG: begin
            Result.VType := vtInteger;
            Result.VInteger := z.value.lval;
        end;
        IS_DOUBLE: begin
            Result.VType := vtExtended;
            New(Result.VExtended);
            Result.VExtended^ := z.value.dval;
        end;
        IS_STRING: begin
            Result.VType := {$IFDEF PHP_UNICE}vtString{$ELSE}vtAnsiString{$ENDIF};

            SetLength(P, z.value.str.len);
            Move(z.value.str.val^, P[1], z.value.str.len);

            {$IFDEF PHP_UNICE}
              Result.VUnicodeString := Pointer(p);
            {$ELSE}
              Result.VAnsiString := Pointer(P);
            {$ENDIF}
        end;
        else
        begin
            Result.VType := vtPointer;
            Result.VPointer := nil;
        end;
    end;
end;

function Z_STRUVAL(z : pzval) : UTF8String;
begin
  if z = nil then
  begin
      Result := '';
      exit;
  end;

  if {$IFDEF PHP7}z.u1.v._type{$ELSE}z._type{$ENDIF} = IS_STRING then
  begin
     SetLength(Result, z.value.str.len);
     Move(z.value.str.val^, Result[1], z.value.str.len);
  end else
    case {$IFDEF PHP7}z.u1.v._type{$ELSE}z._type{$ENDIF} of
       IS_LONG: Result := IntToStr(z.value.lval);
       IS_DOUBLE: Result := FloatToStr(z.value.dval);
       IS_BOOL: if z.value.lval = 0 then Result := '' else Result := '1';
       else
        Result := '';
    end;
end;

function Z_STRVAL(z : pzval) : zend_ustr;
begin
  if z = nil then
  begin
      Result := '';
      exit;
  end;

  if {$IFDEF PHP7}z.u1.v._type{$ELSE}z._type{$ENDIF} = IS_STRING then
  begin
     SetLength(Result, z.value.str.len);
     Move(z.value.str.val^, Result[1], z.value.str.len);
  end else
    case {$IFDEF PHP7}z.u1.v._type{$ELSE}z._type{$ENDIF} of
       IS_LONG: Result := IntToStr(z.value.lval);
       IS_DOUBLE: Result := FloatToStr(z.value.dval);
       IS_BOOL: if z.value.lval = 0 then Result := '' else Result := '1';
       else
        Result := '';
    end;
end;

function Z_STRWVAL(z : pzval) : String;
begin
  if z = nil then
  begin
      Result := '';
      exit;
  end;

  if {$IFDEF PHP7}z.u1.v._type{$ELSE}z._type{$ENDIF} = IS_STRING then
  begin
     SetLength(Result, z.value.str.len);
     Move(z.value.str.val^, Result[1], z.value.str.len);
  end else
    case {$IFDEF PHP7}z.u1.v._type{$ELSE}z._type{$ENDIF} of
       IS_LONG: Result := IntToStr(z.value.lval);
       IS_DOUBLE: Result := FloatToStr(z.value.dval);
       IS_BOOL: if z.value.lval = 0 then Result := '' else Result := '1';
       else
        Result := '';
    end;
end;

function Z_CHAR(z: PZval) : zend_uchar;
var S: zend_ustr;
begin
Result := #0;
  if z = nil then
      exit;

  if {$IFDEF PHP7}z.u1.v._type{$ELSE}z._type{$ENDIF} = IS_STRING then
     S := z.value.str.val
  else
    case {$IFDEF PHP7}z.u1.v._type{$ELSE}z._type{$ENDIF} of
       IS_LONG: S := IntToStr(z.value.lval);
       IS_DOUBLE: S := FloatToStr(z.value.dval);
       IS_BOOL: if z.value.lval = 0 then S := '0' else S := '1';
    end;
  SetLength(S,1);
  Result := zend_uchar(S[1]);
end;
function Z_ACHAR(z: PZVAL): AnsiChar;
var S: AnsiString;
begin
Result := #0;
  if z = nil then
      exit;

  if {$IFDEF PHP7}z.u1.v._type{$ELSE}z._type{$ENDIF} = IS_STRING then
     S := z.value.str.val
  else
    case {$IFDEF PHP7}z.u1.v._type{$ELSE}z._type{$ENDIF} of
       IS_LONG: S := IntToStr(z.value.lval);
       IS_DOUBLE: S := FloatToStr(z.value.dval);
       IS_BOOL: if z.value.lval = 0 then S := '0' else S := '1';
    end;
  SetLength(S,1);
  Result := AnsiChar(S[1]);
end;
function Z_WCHAR(z: PZVAL): WideChar;
var S: WideString;
begin
Result := #0;
  if z = nil then
      exit;

  if {$IFDEF PHP7}z.u1.v._type{$ELSE}z._type{$ENDIF} = IS_STRING then
     S := z.value.str.val
  else
    case {$IFDEF PHP7}z.u1.v._type{$ELSE}z._type{$ENDIF} of
       IS_LONG: S := IntToStr(z.value.lval);
       IS_DOUBLE: S := FloatToStr(z.value.dval);
       IS_BOOL: if z.value.lval = 0 then S := '0' else S := '1';
    end;
  SetLength(S,1);
  Result := WideChar(S[1]);
end;
function Z_UCHAR(z: PZVAL): UTF8Char;
var S: UTF8String;
begin
Result := #0;
  if z = nil then
      exit;

  if {$IFDEF PHP7}z.u1.v._type{$ELSE}z._type{$ENDIF} = IS_STRING then
     S := z.value.str.val
  else
    case {$IFDEF PHP7}z.u1.v._type{$ELSE}z._type{$ENDIF} of
       IS_LONG: S := IntToStr(z.value.lval);
       IS_DOUBLE: S := FloatToStr(z.value.dval);
       IS_BOOL: if z.value.lval = 0 then S := '0' else S := '1';
    end;
  SetLength(S,1);
  Result := Utf8Char(S[1]);
end;

function Z_STRLEN(z : pzval) : longint;
begin
  Result := Length(Z_STRVAL(z));
end;

function Z_ARRVAL(z : pzval ) : {$IFDEF PHP7}Pzend_array{$ELSE}PHashTable{$ENDIF};
begin
  Result := {$IFDEF PHP7} z.value.arr {$ELSE}z.value.ht{$ENDIF};
end;

function Z_OBJ_HANDLE(z :pzval) : {$IFDEF PHP7} P_zend_object_handlers {$ELSE} zend_object_handle{$ENDIF};
begin
  Result := {$IFDEF PHP7}z.value.obj.handlers{$ELSE}z.value.obj.handle{$ENDIF};
end;

function Z_OBJ_HT(z : pzval) : {$IFDEF PHP7}hzend_types.P_zend_object_handlers{$ELSE}pzend_object_handlers{$ENDIF};
begin
  Result := z.value.obj.handlers;
end;

function Z_OBJPROP(z : pzval;TSRMLS_DC:pointer=nil) : {$IFDEF PHP7}hzend_types.PHashTable{$ELSE}PHashTable{$ENDIF};
{$IFDEF PHP7}
begin
  Result := Z_OBJ_HT(z)^.get_properties(z);
end;
{$ELSE}
begin
  if TSRMLS_DC = nil then
  TSRMLS_DC := ts_resource_ex(0, nil);
  Result := Z_OBJ_HT(z)^.get_properties(@z, TSRMLS_DC);
end;
{$ENDIF}


{$ENDIF}

{$IFDEF PHP5}
procedure  _zval_copy_ctor (val: pzval; __zend_filename: zend_pchar; __zend_lineno: uint);
begin
  if {$IFDEF PHP7}val^.u1.v._type{$ELSE}val^._type{$ENDIF} <= IS_BOOL then
   Exit
    else
      _zval_copy_ctor_func(val, __zend_filename, __zend_lineno);
end;

procedure _zval_dtor(val: pzval; __zend_filename: zend_pchar; __zend_lineno: uint);
begin
  if {$IFDEF PHP7}val^.u1.v._type{$ELSE}val^._type{$ENDIF} <= IS_BOOL then
   Exit
     else
       _zval_dtor_func(val, __zend_filename, __zend_lineno);
end;

function zend_hash_init (ht : {$IFDEF PHP7}Pzend_array{$ELSE}PHashTable{$ENDIF}; nSize : uint; pHashFunction : pointer; pDestructor : pointer; persistent: zend_bool) : integer;
begin
  Result := _zend_hash_init(ht, nSize, pHashFunction, pDestructor, persistent, nil, 0);
end;

function zend_hash_add_or_update(ht : {$IFDEF PHP7}Pzend_array{$ELSE}PHashTable{$ENDIF}; arKey : zend_pchar;
    nKeyLength : uint; pData : {$IFDEF PHP7}pzval{$ELSE}pointer{$ENDIF}; nDataSize : uint; pDes : pointer;
    flag : integer) : integer;
{$IFDEF PHP7}
var pz: Pzend_string;
{$ENDIF}
begin
  {$IFDEF PHP7}
    pz^.len := strlen(arKey);
    pz^.val := estrdup(arKey);
   if Assigned(_zend_hash_add_or_update) then
   Result := _zend_hash_add_or_update(ht, pz, pData, flag, '', 0).u2.fe_iter_idx
  {$ELSE}
  if Assigned(_zend_hash_add_or_update) then
   Result := _zend_hash_add_or_update(ht, arKey, nKeyLength, pData, nDataSize, pDes, flag, nil, 0)
  {$ENDIF}
     else
       Result := FAILURE;
end;

function zend_hash_init_ex (ht : {$IFDEF PHP7}Pzend_array{$ELSE}PHashTable{$ENDIF};  nSize : uint; pHashFunction : pointer;
 pDestructor : pointer;  persistent : zend_bool;  bApplyProtection : zend_bool): integer;
begin
  Result := _zend_hash_init_ex(ht, nSize, pHashFunction, pDestructor, persistent, bApplyProtection, nil, 0);
end;

{$ENDIF}

{$IFNDEF PHP_UNICE}
function AnsiFormat(const Format: AnsiString; const Args: array of const): AnsiString;
begin
   Result := Sysutils.Format(Format, Args);
end;
{$ENDIF}
{$IFDEF COMPILER_VC9}
function  DupStr(strSource : zend_pchar) : zend_pchar; cdecl;
var
  P : zend_pchar;
begin

  if (strSource = nil) then
     P := nil
       else
         begin
           P := StrNew(strSource);
         end;
  Result := P;
end;
{$ENDIF}

initialization
{$IFDEF PHP4DELPHI_AUTOLOAD}
  LoadZEND;
{$ENDIF}

finalization
{$IFDEF PHP4DELPHI_AUTOUNLOAD}
  UnloadZEND;
{$ENDIF}

end.



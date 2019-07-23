unit hzend_types;

interface

uses Winapi.Windows;

var
 _TestCreate:Pointer;

const
{#define IS_UNDEF					0
#define IS_NULL						1
#define IS_FALSE					2
#define IS_TRUE						3
#define IS_LONG						4
#define IS_DOUBLE					5
#define IS_STRING					6
#define IS_ARRAY					7
#define IS_OBJECT					8
#define IS_RESOURCE					9
#define IS_REFERENCE				10}

  E_ERROR = 1 shl 0;
  E_WARNING = 1 shl 1;
  E_PARSE = 1 shl 2;
  E_NOTICE = 1 shl 3;
  E_CORE_ERROR = 1 shl 4;
  E_CORE_WARNING = 1 shl 5;
  E_COMPILE_ERROR = 1 shl 6;
  E_COMPILE_WARNING = 1 shl 7;
  E_USER_ERROR = 1 shl 8;
  E_USER_WARNING = 1 shl 9;
  E_USER_NOTICE = 1 shl 10;
  E_STRICT = 1 shl 11;
  E_RECOVERABLE_ERROR = 1 shl 12;
  E_DEPRECATED = 1 shl 13;
  E_USER_DEPRECATED = 1 shl 14;
  E_ALL = (((((((((((((E_ERROR or E_WARNING) or E_PARSE) or E_NOTICE) or E_CORE_ERROR) or E_CORE_WARNING) or E_COMPILE_ERROR) or E_COMPILE_WARNING) or E_USER_ERROR) or E_USER_WARNING) or E_USER_NOTICE) or E_RECOVERABLE_ERROR) or E_DEPRECATED) or E_USER_DEPRECATED) or E_STRICT;
  E_CORE = E_CORE_ERROR or E_CORE_WARNING;


  ZEND_INI_USER	= 1 shl 0;
  ZEND_INI_PERDIR	= 1 shl 1;
  ZEND_INI_SYSTEM	= 1 shl 2;
  ZEND_INI_ALL = (ZEND_INI_USER or ZEND_INI_PERDIR or ZEND_INI_SYSTEM);


 ZEND_INI_DISPLAY_ORIG =	1 ;
 ZEND_INI_DISPLAY_ACTIVE=	2 ;

 ZEND_INI_STAGE_STARTUP	= 1 or 0;
 ZEND_INI_STAGE_SHUTDOWN		= 1 or 1;
ZEND_INI_STAGE_ACTIVATE		= 1 or 2;
 ZEND_INI_STAGE_DEACTIVATE	= 1 or 3;
ZEND_INI_STAGE_RUNTIME		= 1 or 4;
ZEND_INI_STAGE_HTACCESS		= 1 or 5;


  IS_UNDEF			=		0  ;
  IS_NULL			=			1  ;
  IS_FALSE		 =			2  ;
  IS_TRUE			 =			3  ;
  IS_LONG			=			4    ;
  IS_DOUBLE		=			5    ;
  IS_STRING		 =			6   ;
  IS_ARRAY		 =			7   ;
  IS_OBJECT		 =			8   ;
  IS_RESOURCE		=			9   ;
  IS_REFERENCE	 =			10 ;


  IS_CONSTANT			=		11    ;
  IS_CONSTANT_AST	 =			12 ;


  IS_BOOL				=	13      ;
  IS_CALLABLE			=		14    ;

  IS_INDIRECT    =         	15 ;
  IS_PTR				=		17       ;
  //  IS_BOOL = 4;

 IS_TYPE_CONSTANT		 =	(1 SHL 0);
 IS_TYPE_IMMUTABLE	=		(1 SHL 1) ;
 IS_TYPE_REFCOUNTED	 =		(1 SHL 2) ;
IS_TYPE_COLLECTABLE	 =		(1 SHL 3);
 IS_TYPE_COPYABLE		=	(1 SHL 4)      ;
 IS_TYPE_SYMBOLTABLE =			(1 SHL 5)  ;

Z_TYPE_FLAGS_SHIFT =			8 ;
Z_CONST_FLAGS_SHIFT	 =		16;





  IS_STRING_EX = IS_STRING or ((IS_TYPE_REFCOUNTED or IS_TYPE_COPYABLE) shl Z_TYPE_FLAGS_SHIFT);



  SUCCESS = 0;
  FAILURE = -1;



  HASH_UPDATE = 1 SHL 0;
  HASH_ADD = 1 SHL 1;
  HASH_NEXT_INSERT = 1 SHL 2;

  HASH_DEL_KEY = 0;
  HASH_DEL_INDEX = 1;
  HASH_DEL_KEY_QUICK = 2;

 ZEND_AST_SPECIAL_SHIFT   =   6;
ZEND_AST_IS_LIST_SHIFT    =  7;
ZEND_AST_NUM_CHILDREN_SHIFT = 8;

 PHP_API_VERSION = 20151012 ;
 YYDEBUG = 0            ;
 PHP_DEFAULT_CHARSET = 'UTF-8';

  MODULE_PERSISTENT = 1;
  MODULE_TEMPORARY = 2;

   SAPI_HEADER_ADD			= 1 shr 0;

 SAPI_HEADER_SENT_SUCCESSFULLY =	1 ;
SAPI_HEADER_DO_SEND			=	2        ;
 SAPI_HEADER_SEND_FAILED		=	3   ;

 SAPI_DEFAULT_MIMETYPE	=	'text/html';
 SAPI_DEFAULT_CHARSET	=	PHP_DEFAULT_CHARSET;
 SAPI_PHP_VERSION_HEADER	=	'X-Powered-By: PHP/" PHP_VERSION';

   //zend_constants.h
const
  CONST_CS                                        = (1 shl 0) { Case Sensitive }
  ;
  CONST_PERSISTENT                                = (1 shl 1) { Persistent }
  ;
const
  ZEND_INTERNAL_FUNCTION                          = 1;
  ZEND_USER_FUNCTION                              = 2;
  ZEND_OVERLOADED_FUNCTION                        = 3;
  ZEND_EVAL_CODE                                  = 4;
  ZEND_INTERNAL_CLASS                             = 1;
  ZEND_USER_CLASS                                 = 2;
  ZEND_EVAL                                       = (1 shl 0);
  ZEND_INCLUDE                                    = (1 shl 1);
  ZEND_INCLUDE_ONCE                               = (1 shl 2);
  ZEND_REQUIRE                                    = (1 shl 3);
  ZEND_REQUIRE_ONCE                               = (1 shl 4);
  ZEND_ISSET                                      = (1 shl 0);
  ZEND_ISEMPTY                                    = (1 shl 1);
  ZEND_CT                                         = (1 shl 0);
  ZEND_RT                                         = (1 shl 1);
type
  pppointer = ^ppointer;





  _zend_ast_kind = (ZEND_AST_ZVAL_ = 1 shl ZEND_AST_SPECIAL_SHIFT,ZEND_AST_ZNODE_,ZEND_AST_FUNC_DECL,
    ZEND_AST_CLOSURE,ZEND_AST_METHOD,ZEND_AST_CLASS,
    ZEND_AST_ARG_LIST = 1 shl ZEND_AST_IS_LIST_SHIFT,ZEND_AST_LIST_,ZEND_AST_ARRAY,
    ZEND_AST_ENCAPS_LIST,ZEND_AST_EXPR_LIST,
    ZEND_AST_STMT_LIST,ZEND_AST_IF,ZEND_AST_SWITCH_LIST,
    ZEND_AST_CATCH_LIST,ZEND_AST_PARAM_LIST,
    ZEND_AST_CLOSURE_USES,ZEND_AST_PROP_DECL,
    ZEND_AST_CONST_DECL,ZEND_AST_CLASS_CONST_DECL,
    ZEND_AST_NAME_LIST,ZEND_AST_TRAIT_ADAPTATIONS,
    ZEND_AST_USE,ZEND_AST_MAGIC_CONST = 0 shl ZEND_AST_NUM_CHILDREN_SHIFT,
    ZEND_AST_TYPE,ZEND_AST_VAR = 1 shl ZEND_AST_NUM_CHILDREN_SHIFT,ZEND_AST_CONST,
    ZEND_AST_UNPACK,ZEND_AST_UNARY_PLUS,ZEND_AST_UNARY_MINUS,
    ZEND_AST_CAST,ZEND_AST_EMPTY,ZEND_AST_ISSET,
    ZEND_AST_SILENCE,ZEND_AST_SHELL_EXEC,ZEND_AST_CLONE,
    ZEND_AST_EXIT,ZEND_AST_PRINT,ZEND_AST_INCLUDE_OR_EVAL,
    ZEND_AST_UNARY_OP,ZEND_AST_PRE_INC,ZEND_AST_PRE_DEC,
    ZEND_AST_POST_INC,ZEND_AST_POST_DEC,ZEND_AST_YIELD_FROM,
    ZEND_AST_GLOBAL,ZEND_AST_UNSET,ZEND_AST_RETURN,
    ZEND_AST_LABEL,ZEND_AST_REF_,ZEND_AST_HALT_COMPILER,
    ZEND_AST_ECHO,ZEND_AST_THROW,ZEND_AST_GOTO,
    ZEND_AST_BREAK,ZEND_AST_CONTINUE,ZEND_AST_DIM = 2 shl ZEND_AST_NUM_CHILDREN_SHIFT,
    ZEND_AST_PROP,ZEND_AST_STATIC_PROP,ZEND_AST_CALL,
    ZEND_AST_CLASS_CONST,ZEND_AST_ASSIGN,ZEND_AST_ASSIGN_REF,
    ZEND_AST_ASSIGN_OP,ZEND_AST_BINARY_OP,ZEND_AST_GREATER,
    ZEND_AST_GREATER_EQUAL,ZEND_AST_AND,ZEND_AST_OR,
    ZEND_AST_ARRAY_ELEM,ZEND_AST_NEW,ZEND_AST_INSTANCEOF,
    ZEND_AST_YIELD,ZEND_AST_COALESCE,ZEND_AST_STATIC,
    ZEND_AST_WHILE,ZEND_AST_DO_WHILE,ZEND_AST_IF_ELEM,
    ZEND_AST_SWITCH,ZEND_AST_SWITCH_CASE,ZEND_AST_DECLARE,
    ZEND_AST_CONST_ELEM,ZEND_AST_USE_TRAIT,
    ZEND_AST_TRAIT_PRECEDENCE,ZEND_AST_METHOD_REFERENCE,
    ZEND_AST_NAMESPACE,ZEND_AST_USE_ELEM,ZEND_AST_TRAIT_ALIAS,
    ZEND_AST_GROUP_USE,ZEND_AST_METHOD_CALL = 3 shl ZEND_AST_NUM_CHILDREN_SHIFT,
    ZEND_AST_STATIC_CALL,ZEND_AST_CONDITIONAL,
    ZEND_AST_TRY,ZEND_AST_CATCH,ZEND_AST_PARAM,
    ZEND_AST_PROP_ELEM,ZEND_AST_FOR = 4 shl ZEND_AST_NUM_CHILDREN_SHIFT,ZEND_AST_FOREACH
    );
 plongint = ^longint;

  P_zend_objects_store = ^_zend_objects_store;
   Pzend_objects_store = ^zend_objects_store;
   uint32_t = CARDINAL;


  zend_pchar  = {$IFDEF PHP_UNICE}PUtf8Char{$ELSE}PAnsiChar{$ENDIF};
  zend_pstr   = {$IFDEF PHP_UNICE}PUtf8String{$ELSE}PAnsiString{$ENDIF};

  //zend_uchar  = {$IFDEF PHP_UNICE}Utf8Char{$ELSE}AnsiChar{$ENDIF};
  zend_ustr   = {$IFDEF PHP_UNICE}Utf8String{$ELSE}AnsiString{$ENDIF};








  P_zend_object = ^_zend_object;
  PP_zend_object = ^P_zend_object;
  PPP_zend_object = ^PP_zend_object;
  Pzend_object = ^_zend_object;
  PPzend_object = ^P_zend_object;
  PPPzend_object = ^PP_zend_object;

  P_zend_refcounted = ^_zend_refcounted;
  P_zend_string = ^_zend_string;
  PP_zend_string = ^P_zend_string;
  PPP_zend_string = ^PP_zend_string;
  Pzend_string = ^_zend_string;
  PPzend_string = ^P_zend_string;
  PPPzend_string = ^PP_zend_string;

  Pzend_mm_chunk_alloc_t = ^zend_mm_chunk_alloc_t;
  P_zend_resource = ^_zend_resource;
  PP_zend_resource =^P_zend_resource;
  PPP_zend_resource =^PP_zend_resource;
  Pzend_resource = ^_zend_resource;
  PPzend_resource =^P_zend_resource;
  PPPzend_resource =^PP_zend_resource;
  P_zend_ast_ref = ^_zend_ast_ref;
  P_zend_reference = ^_zend_reference;
  P_zend_array = ^_zend_array;
  PP_zend_array = ^P_zend_array;
  PPP_zend_array = ^PP_zend_array;
  Pzend_array = ^_zend_array;
  PPzend_array = ^P_zend_array;
  PPPzend_array = ^PP_zend_array;

  P_zval_struct = ^_zval_struct;
  P_zend_function = ^_zend_function;
  PP_zend_function = ^P_zend_function;
  PPP_zend_function = ^PP_zend_function;
  Pzend_function = ^_zend_function;
  PPzend_function = ^P_zend_function;
  PPPzend_function = ^PP_zend_function;
  P_zend_value = ^_zend_value;
  Pzend_ast_kind = ^zend_ast_kind;
  zend_ast_kind = Word;
  Pzend_ast_attr = ^zend_ast_attr;
  zend_ast_attr = Word;
  Pzend_bool = ^zend_bool;
  zend_bool = byte;
  Pzend_uchar = ^zend_uchar;
  zend_uchar = byte;
  zend_long = integer;
  Pzend_long = ^zend_long;
  PPzend_long = ^Pzend_long;
 Pzend_stack = ^zend_stack;
  P_zend_stack = ^_zend_stack;


  zend_ulong = FixedUInt;
  P_zend_ulong = ^zend_ulong;
  zend_off_t = integer;
  Pzend_off_t = ^zend_off_t;
  PPzend_off_t = ^Pzend_off_t;
     P_zend_mm_huge_list = ^_zend_mm_huge_list;

  P_zend_mm_free_slot = ^_zend_mm_free_slot;
  P_zend_mm_bin = ^_zend_mm_bin;
  P_zend_mm_page = ^_zend_mm_page;
  P_zend_mm_chunk = ^_zend_mm_chunk;
 P_zend_mm_heap = ^_zend_mm_heap;
 PP_zend_mm_heap = ^P_zend_mm_heap;
 PPP_zend_mm_heap = ^PP_zend_mm_heap;
 Pzend_mm_heap = ^_zend_mm_heap;
 PPzend_mm_heap = ^P_zend_mm_heap;
 PPPzend_mm_heap = ^PP_zend_mm_heap;
   P_zend_mm_debug_info = ^_zend_mm_debug_info;

   Pzend_ini_entry_def = ^zend_ini_entry_def;

  P_zend_ini_entry = ^_zend_ini_entry;
  P_zend_ini_entry_def = ^_zend_ini_entry_def;

  zend_uint = uint;
  zend_ushort = ushort;
  Pzend_value = ^zend_value;
  Pzend_file_handle = ^zend_file_handle;
  P_zend_ast = ^_zend_ast;
  P_zend_ast_list = ^_zend_ast_list;
  Pzend_ast_list = ^zend_ast_list;
  Pzend_ast_decl = ^zend_ast_decl;
  P_zend_ast_zval = ^_zend_ast_zval;
  Pzend_ast_zval = ^zend_ast_zval;
  P_zend_ast_decl = ^_zend_ast_decl;
  PHashTable = Pzend_array;
  PPHashTable = ^PHashTable;
  Pzend_intptr_t = ^zend_intptr_t;
  Pzend_uintptr_t = ^zend_uintptr_t;
  pzval = ^zval;
  ppzval = ^pzval;
  pppzval = ^ppzval;
  Pzend_utility_values = ^zend_utility_values;
  Pzend_utility_functions = ^zend_utility_functions;
  Pzend_trait_alias = ^zend_trait_alias;
  Pzend_trait_precedence = ^zend_trait_precedence;
  Pzend_trait_method_reference = ^zend_trait_method_reference;
  PZEND_RESULT_CODE = ^ZEND_RESULT_CODE;
  P_zend_serialize_data = ^_zend_serialize_data;
  P_zend_unserialize_data = ^_zend_unserialize_data;
  P_zend_trait_method_reference = ^_zend_trait_method_reference;
  P_zend_trait_precedence = ^_zend_trait_precedence;
  P_zend_trait_alias = ^_zend_trait_alias;
  P_zend_class_entry = ^_zend_class_entry;
  PP_zend_class_entry  = ^P_zend_class_entry;
  PPP_zend_class_entry = ^PP_zend_class_entry;
  Pzend_class_entry = ^_zend_class_entry;
  PPzend_class_entry  = ^P_zend_class_entry;
  PPPzend_class_entry = ^PP_zend_class_entry;

  P_zend_utility_functions = ^_zend_utility_functions;
  P_zend_utility_values = ^_zend_utility_values;
  Pzend_error_handling_t = ^zend_error_handling_t;
  Pzend_error_handling = ^zend_error_handling;
  Pzend_stream_type = ^zend_stream_type;

  P_zend_op = ^_zend_op;
  P_zend_execute_data = ^_zend_execute_data;
  PP_zend_execute_data = ^P_zend_execute_data;
  PPP_zend_execute_data = ^PP_zend_execute_data;
  Pzend_execute_data = ^_zend_execute_data;
  PPzend_execute_data = ^P_zend_execute_data;
  PPPzend_execute_data = ^PP_zend_execute_data;
  P_zend_function_entry = ^_zend_function_entry;
  P_zend_fcall_info_cache = ^_zend_fcall_info_cache;
  Pzend_function_entry = ^zend_function_entry;
  Pzend_declarables = ^zend_declarables;
  Pzend_ast_znode = ^zend_ast_znode;
  Pznode = ^znode;
  Pznode_op = ^znode_op;
  Pzend_stream = ^zend_stream;
  Pzend_mmap = ^zend_mmap;
  Pzend_fcall_info_cache = ^zend_fcall_info_cache;
  P_zend_mmap = ^_zend_mmap;
  P_zend_stream = ^_zend_stream;
  P_zend_file_handle = ^_zend_file_handle;
  P_znode_op = ^_znode_op;
  P_znode = ^_znode;
  P_zend_ast_znode = ^_zend_ast_znode;
  P_zend_declarables = ^_zend_declarables;
  P_zend_oparray_context = ^_zend_oparray_context;
  Pzend_internal_function_info = ^zend_internal_function_info;
  Pzend_arg_info = ^zend_arg_info;
  Pzend_internal_arg_info = ^zend_internal_arg_info;
  Pzend_property_info = ^zend_property_info;
  Pzend_try_catch_element = ^zend_try_catch_element;
  Pzend_label = ^zend_label;
    Pzend_closure = ^zend_closure;
  P_zend_closure = ^_zend_closure;
  P_zend_multibyte_functions = ^_zend_multibyte_functions;
  Pzend_encoding_internal_encoding_getter = ^zend_encoding_internal_encoding_getter;
  Pzend_encoding_detector = ^zend_encoding_detector;

  Pzend_brk_cont_element = ^zend_brk_cont_element;
  Pzend_parser_stack_elem = ^zend_parser_stack_elem;
  Pzend_file_context = ^zend_file_context;
  Pzend_oparray_context = ^zend_oparray_context;
  P_zend_file_context = ^_zend_file_context;
  P_zend_parser_stack_elem = ^_zend_parser_stack_elem;
  P_zend_brk_cont_element = ^_zend_brk_cont_element;
  P_zend_label = ^_zend_label;
  P_zend_try_catch_element = ^_zend_try_catch_element;
  P_zend_property_info = ^_zend_property_info;
  P_zend_internal_arg_info = ^_zend_internal_arg_info;
  P_zend_arg_info = ^_zend_arg_info;
  P_zend_internal_function_info = ^_zend_internal_function_info;
  P_zend_op_array = ^_zend_op_array;
  PP_zend_op_array = ^P_zend_op_array;
  PPP_zend_op_array = ^PP_zend_op_array;
  Pzend_op_array = ^_zend_op_array;
  PPzend_op_array = ^P_zend_op_array;
  PPPzend_op_array = ^PP_zend_op_array;
  PHashTableIterator = ^HashTableIterator;
  P_zend_object_handlers = ^_zend_object_handlers;
  PBucket = ^Bucket;
  Pzend_refcounted_h = ^zend_refcounted_h;
  Pzend_auto_global = ^zend_auto_global;
  Pzend_internal_function = ^tzend_internal_function;
  P_zend_internal_function = ^_zend_internal_function;
  P_zend_call_kind = ^_zend_call_kind;
  P_zend_auto_global = ^_zend_auto_global;
  P_zend_refcounted_h = ^_zend_refcounted_h;
  P_Bucket = ^_Bucket;
  PHashPosition = ^HashPosition;
  P_HashTableIterator = ^_HashTableIterator;
  Pzend_object_read_property_t = ^zend_object_read_property_t;
  Pzend_object_read_dimension_t = ^zend_object_read_dimension_t;
  Pzend_object_get_property_ptr_ptr_t = ^zend_object_get_property_ptr_ptr_t;
  Pzend_object_get_t = ^zend_object_get_t;
  Pzend_object_get_properties_t = ^zend_object_get_properties_t;
  Pzend_object_get_method_t = ^zend_object_get_method_t;
  Pzend_object_get_constructor_t = ^zend_object_get_constructor_t;
  Pzend_object_get_debug_info_t = ^zend_object_get_debug_info_t;
  Pzend_call_kind = ^zend_call_kind;
  Pzend_object_clone_obj_t = ^zend_object_clone_obj_t;
  Pzend_object_get_class_name_t = ^zend_object_get_class_name_t;
  Pzend_object_get_gc_t = ^zend_object_get_gc_t;
  P_zend_class_iterator_funcs = ^_zend_class_iterator_funcs;
  P_zend_object_iterator_funcs = ^_zend_object_iterator_funcs;
  Pzend_object_iterator_funcs = ^zend_object_iterator_funcs;
   P_zend_arena = ^_zend_arena;
  Pzend_leak_info = ^zend_leak_info;
  Pzend_mm_debug_info = ^zend_mm_debug_info;
  Pzend_mm_handlers = ^zend_mm_handlers;
  P_zend_mm_storage = ^_zend_mm_storage;
  P_zend_mm_handlers = ^_zend_mm_handlers;
 P_zend_leak_info = ^_zend_leak_info;
  P_zend_object_iterator = ^_zend_object_iterator;
  PP_zend_object_iterator = ^P_zend_object_iterator;
  PPP_zend_object_iterator = ^PP_zend_object_iterator;
  Pzend_object_iterator = ^_zend_object_iterator;
  PPzend_object_iterator = ^P_zend_object_iterator;
  PPPzend_object_iterator = ^PP_zend_object_iterator;
  Pzend_class_iterator_funcs = ^zend_class_iterator_funcs;
  P_zend_module_dep = ^_zend_module_dep;
  P_zend_module_entry = ^_zend_module_entry;
  PP_zend_module_entry    = ^P_zend_module_entry;
  PPP_zend_module_entry    = ^PP_zend_module_entry;
  Pzend_module_entry = ^_zend_module_entry;
  PPzend_module_entry    = ^P_zend_module_entry;
  PPPzend_module_entry    = ^PP_zend_module_entry;
    psmart_str = ^Tsmart_str;

  Psapi_globals_struct = ^sapi_globals_struct;
  Psapi_header_struct = ^sapi_header_struct;
  Psapi_headers_struct = ^sapi_headers_struct;
  Pzend_mm_chunk_free_t = ^zend_mm_chunk_free_t;
  Pzend_mm_chunk_truncate_t = ^zend_mm_chunk_truncate_t;
   Pzend_mm_chunk_extend_tt = ^zend_mm_chunk_extend_t;
  Psapi_request_info = ^sapi_request_info;
  P_sapi_globals_struct = ^_sapi_globals_struct;
  Psapi_header_line = ^sapi_header_line;
  Psapi_header_op_enum = ^sapi_header_op_enum;
  P_sapi_module_struct = ^_sapi_module_struct;
  PP_sapi_module_struct = ^P_sapi_module_struct;
  PPP_sapi_module_struct = ^PP_sapi_module_struct;
  Psapi_module_struct = ^_sapi_module_struct;
  PPsapi_module_struct = ^P_sapi_module_struct;
  PPPsapi_module_struct = ^PP_sapi_module_struct;
  P_sapi_post_entry = ^_sapi_post_entry;
  PP_sapi_post_entry = ^P_sapi_post_entry;
  PPP_sapi_post_entry = ^PP_sapi_post_entry;
  Psapi_post_entry = ^_sapi_post_entry;
  PPsapi_post_entry = ^P_sapi_post_entry;
  PPPsapi_post_entry = ^PP_sapi_post_entry;
  Pphp_stream_dirent = ^php_stream_dirent;
  Pphp_stream_ops = ^php_stream_ops;
  P_php_stream = ^_php_stream;
  PP_php_stream = ^P_php_stream;
  PPP_php_stream = ^PP_php_stream;
  Pphp_stream = ^_php_stream;
  PPphp_stream = ^P_php_stream;
  PPPphp_stream = ^PP_php_stream;
  P_php_stream_wrapper = ^_php_stream_wrapper;
  PP_php_stream_wrapper = ^P_php_stream_wrapper;
  PPP_php_stream_wrapper = ^PP_php_stream_wrapper;
  Pphp_stream_wrapper = ^_php_stream_wrapper;
  PPphp_stream_wrapper = ^P_php_stream_wrapper;
  PPPphp_stream_wrapper = ^PP_php_stream_wrapper;
  P_php_stream_wrapper_ops = ^_php_stream_wrapper_ops;
  P_php_stream_ops = ^_php_stream_ops;
  P_php_stream_statbuf = ^_php_stream_statbuf;
  Pzend_llist = ^zend_llist;
  Pzend_llist_element = ^zend_llist_element;
  P_zend_llist_element = ^_zend_llist_element;
  P_zend_llist = ^_zend_llist;
  Pzend_llist_position = ^zend_llist_position;
  Pphp_stream_filter_ops = ^php_stream_filter_ops;
  Pphp_stream_filter_chain = ^php_stream_filter_chain;
   Pphp_stream_filter_factory = ^php_stream_filter_factory;
  P_php_stream_filter_factory = ^_php_stream_filter_factory;
  P_php_stream_filter = ^_php_stream_filter;
  PP_php_stream_filter = ^P_php_stream_filter;
  PPP_php_stream_filter = ^PP_php_stream_filter;
  Pphp_stream_filter = ^_php_stream_filter;
  PPphp_stream_filter = ^P_php_stream_filter;
  PPPphp_stream_filter = ^PP_php_stream_filter;
  P_php_stream_filter_chain = ^_php_stream_filter_chain;
  P_php_stream_filter_ops = ^_php_stream_filter_ops;
  Pphp_stream_filter_status_t = ^php_stream_filter_status_t;
  P_php_stream_bucket_brigade = ^_php_stream_bucket_brigade;
  PP_php_stream_bucket_brigade = ^P_php_stream_bucket_brigade;
  PPP_php_stream_bucket_brigade = ^PP_php_stream_bucket_brigade;
  Pphp_stream_bucket_brigade = ^_php_stream_bucket_brigade;
  PPphp_stream_bucket_brigade = ^P_php_stream_bucket_brigade;
  PPPphp_stream_bucket_brigade = ^PP_php_stream_bucket_brigade;
  P_php_stream_bucket = ^_php_stream_bucket;
  PP_php_stream_bucket = ^P_php_stream_bucket;
  PPP_php_stream_bucket = ^PP_php_stream_bucket;
  Pphp_stream_bucket = ^_php_stream_bucket;
  PPphp_stream_bucket = ^P_php_stream_bucket;
  PPPphp_stream_bucket = ^PP_php_stream_bucket;
  Puid_t = ^uid_t;
  uid_t = longint;
 Pphp_stream_wrapper_ops = ^php_stream_wrapper_ops;                                          zend_encoding = pointer ;
  Pzend_encoding= ^zend_encoding;
  PPzend_encoding = ^Pzend_encoding;
  PPPzend_encoding = ^PPzend_encoding;
  Pgid_t = ^gid_t;
  gid_t = longint;
Pzend_ptr_stack = ^zend_ptr_stack;
  P_zend_ptr_stack = ^_zend_ptr_stack;
  Pzend_free_op = ^zend_free_op;
  zend_free_op = Pzval;

  Pzend_vm_stack = ^_zend_vm_stack;
     Pzend_ini_parser_param = ^zend_ini_parser_param;
   P_zend_ini_parser_param = ^_zend_ini_parser_param;

    P_zend_php_scanner_globals = ^_zend_php_scanner_globals;
  Pzend_php_scanner_event = ^zend_php_scanner_event;
  zend_php_scanner_event = (ON_TOKEN,ON_FEEDBACK,ON_STOP);
  P_zend_ini_scanner_globals = ^_zend_ini_scanner_globals;
  P_zend_executor_globals = ^_zend_executor_globals;
  P_zend_compiler_globals = ^_zend_compiler_globals;


  Pcaddr_t = ^caddr_t;
  caddr_t = zend_pchar;
  _zend_fcall_info_cache = record
      initialized : zend_bool;
      function_handler : P_zend_function;
      calling_scope : P_zend_class_entry;
      called_scope : P_zend_class_entry;
      _object : P_zend_object;
    end;
  zend_fcall_info_cache = _zend_fcall_info_cache;
  Pphp_stream_statbuf = ^php_stream_statbuf;
  P_php_stream_notifier = ^_php_stream_notifier;
  P_php_stream_context = ^_php_stream_context;
  PP_php_stream_context = ^P_php_stream_context;
  PPP_php_stream_context = ^PP_php_stream_context;
  Pphp_stream_context = ^_php_stream_context;
  PPphp_stream_context = ^P_php_stream_context;
  PPPphp_stream_context = ^PP_php_stream_context;

  P_php_stream_dirent = ^_php_stream_dirent;

  PP_zend_llist_element = ^P_zend_llist_element;
  PPP_zend_llist_element = ^PP_zend_llist_element;

   zend_stat_t = pointer;
   P_zend_stat_t =^zend_stat_t;
   PP_zend_stat_t = ^P_zend_stat_t;
   PPP_zend_stat_t = ^PP_zend_stat_t;
  _zend_value = Packed  record
      case longint of
        0 : ( lval : zend_long );
        1 : ( dval : double );
        2 : ( counted : P_zend_refcounted );
        3 : ( str : Pzend_string );
        4 : ( arr : Pzend_array );
        5 : ( obj : Pzend_object );
        6 : ( res : Pzend_resource );
        7 : ( ref : P_zend_reference );
        8 : ( ast : P_zend_ast_ref );
        9 : ( zv : Pzval );
        10 : ( ptr : pointer );
        11 : ( ce : P_zend_class_entry );
        12 : ( func : P_zend_function );
        13 : ( ww : Packed record
            w1 : cardinal;
            w2 : cardinal;
          end );
      end;
    zend_value = _zend_value;

  _zval_struct = Packed  record
      value : zend_value;
      u1 : Packed  record
          case longint of
            0 : ( v : record
                _type : zend_uchar;
                type_flags : zend_uchar;
                const_flags : zend_uchar;
                reserved : zend_uchar;
              end );
            1 : ( type_info : cardinal );
          end;
      u2 :  Packed  record
          case longint of
            0 : ( var_flags : LongWord );
            1 : ( next : cardinal );
            2 : ( cache_slot : cardinal );
            3 : ( lineno : cardinal );
            4 : ( num_args : cardinal );
            5 : ( fe_pos : cardinal );
            6 : ( fe_iter_idx : cardinal );
          end;
    end;
    zval = _zval_struct;
  PZendConstant = ^TZendConstant;
  zend_constant = record
    value: zval;
    flags: Integer;
    name: zend_pchar;
    name_len: uint;
    module_number: Integer;
  end;
  TZendConstant = zend_constant;
  Pzend_syntax_highlighter_ini = ^Tzend_syntax_highlighter_ini;
  zend_syntax_highlighter_ini =
    record
    highlight_html    : zend_pchar;
    highlight_comment : zend_pchar;
    highlight_default : zend_pchar;
    highlight_string  : zend_pchar;
    highlight_keyword : zend_pchar;
  end;
    PStat = ^TStat;
  TStat = record
    st_dev: Word;
    st_ino: Word;
    st_mode: Word;
    st_nlink: SmallInt;
    st_uid: SmallInt;
    st_gid: SmallInt;
    st_rdev: Word;
    st_size: Longint;
    st_atime: Longint;
    st_mtime: Longint;
    st_ctime: Longint;
  end;
  Stat = TStat;
  Tzend_syntax_highlighter_ini = zend_syntax_highlighter_ini;
  compare_func_t = function (_para1:pointer; _para2:pointer):longint;cdecl;

  swap_func_t = procedure (_para1:pointer; _para2:pointer);cdecl;

  sort_func_t = procedure (_para1:pointer; _para2:size_t; _para3:size_t; _para4:compare_func_t; _para5:swap_func_t);cdecl;

  dtor_func_t = procedure (pDest:pzval);cdecl;

  copy_ctor_func_t = procedure (pElement:pzval);cdecl;


  P_zend_vm_stack = ^_zend_vm_stack;

  _zend_vm_stack = record
      top : Pzval;
      _end : Pzval;
      prev : POINTER;
    end;


  _zend_refcounted_h = record
      refcount : cardinal;
      u : record
          case longint of
            0 : ( v : record
                _type : zend_uchar;
                flags : zend_uchar;
                gc_info : word;
              end );
            1 : ( type_info : cardinal );
          end;
    end;


  zend_refcounted_h = _zend_refcounted_h;

  _zend_refcounted = record
      gc : zend_refcounted_h;
    end;
 zend_refcounted = _zend_refcounted;



  _zend_string = record
      gc : zend_refcounted_h;
      h : zend_ulong;
      len : size_t;
      val : zend_pchar;
    end;
    zend_string = _zend_string;

  _Bucket = record
      val : zval;
      h : zend_ulong;
      key : P_zend_string;
    end;
  Bucket = _Bucket;
  _zend_ini_entry = record
      name : P_zend_string;
      on_modify : pointer;
      mh_arg1 : pointer;
      mh_arg2 : pointer;
      mh_arg3 : pointer;
      value : P_zend_string;
      orig_value : P_zend_string;
      displayer : procedure (ini_entry:p_zend_ini_entry; _type:longint);cdecl;
      modifiable : longint;
      orig_modifiable : longint;
      modified : longint;
      module_number : longint;
    end;

  _zend_ini_entry_def = record
      name : zend_pchar;
      on_modify : pointer;
      mh_arg1 : pointer;
      mh_arg2 : pointer;
      mh_arg3 : pointer;
      value : zend_pchar;
      displayer : procedure (ini_entry:p_zend_ini_entry; _type:longint);cdecl;
      modifiable : longint;
      name_length : uint;
      value_length : uint;
    end;
  zend_ini_entry_def = _zend_ini_entry_def;
zend_ini_parser_cb_t = procedure (arg1:pzval; arg2:pzval; arg3:pzval; callback_type:longint; arg:pointer);cdecl;



  _zend_array = record
      gc : zend_refcounted_h;
      u : record
          case longint of
            0 : ( v : record
                flags : zend_uchar;
                nApplyCount : zend_uchar;
                nIteratorsCount : zend_uchar;
                reserve : zend_uchar;
              end );
            1 : ( flags : cardinal );
          end;
      nTableMask : cardinal;
      arData : PBucket;
      nNumUsed : cardinal;
      nNumOfElements : cardinal;
      nTableSize : cardinal;
      nInternalPointer : cardinal;
      nNextFreeElement : zend_long;
      pDestructor : dtor_func_t;
    end;
    HashTable = _zend_array ;
    	zend_array = _zend_array;
    pzval_array = pzval;
  _zend_ast = record
      kind : zend_ast_kind;
      attr : zend_ast_attr;
      lineno : Cardinal;
      child : array[0..0] of P_zend_ast;
    end;

  	zend_ast = _zend_ast;
   pzend_ast = ^zend_ast;
   ppzend_ast = ^pzend_ast;
   pppzend_ast = ^ppzend_ast;

  _zend_ast_list = record
      kind : zend_ast_kind;
      attr : zend_ast_attr;
      lineno : Cardinal;
      children : Cardinal;
      child : array[0..0] of P_zend_ast;
    end;
  zend_ast_list = _zend_ast_list;




  P_zend_fcall_info = ^_zend_fcall_info;
  _zend_fcall_info = record
      size : size_t;
      function_table : PHashTable;
      function_name : zval;
      symbol_table : P_zend_array;
      retval : Pzval;
      params : Pzval;
      _object : P_zend_object;
      no_separation : zend_bool;
      param_count : cardinal;
    end;
  zend_fcall_info = _zend_fcall_info;
  Pzend_fcall_info = ^zend_fcall_info;


  _zend_ast_zval = record
      kind : zend_ast_kind;
      attr : zend_ast_attr;
      val : zval;
    end;
  zend_ast_zval = _zend_ast_zval;

  _zend_ast_decl = record
      kind : zend_ast_kind;
      attr : zend_ast_attr;
      start_lineno : Cardinal;
      end_lineno : Cardinal;
      flags : Cardinal;
      lex_pos : Pbyte;
      doc_comment : P_zend_string;
      name : P_zend_string;
      child : array[0..3] of P_zend_ast;
    end;
  zend_ast_decl = _zend_ast_decl;

  zend_ast_process_t = procedure (ast:pzend_ast);cdecl;


  zend_ast_apply_func = procedure (ast_ptr:pPzend_ast);cdecl;





  {$IFDEF _WIN64}
  IntPtr = Int64;
  UIntPtr = UInt64;
  {$ELSE}
  IntPtr = Longint;
  UIntPtr = LongWord;
  {$ENDIF}



  uintptr_t = Cardinal;


  ZEND_RESULT_CODE = (SUCCESS_ = 0,FAILURE_ = -(1));

  zend_intptr_t = intptr;

  zend_uintptr_t = uintptr_t;
	//zend_object_handlers = _zend_object_handlers;


 // Pzend_function = ^zend_function;


  Pzend_mm_page_info = ^zend_mm_page_info;
  zend_mm_page_info = uint32_t;


  Pzend_mm_bitset = ^zend_mm_bitset;
  zend_mm_bitset = zend_ulong;








  _zend_serialize_data = record end;

  _zend_unserialize_data = record end;

   zend_serialize_data = _zend_serialize_data;
 zend_unserialize_data = _zend_unserialize_data;

  _zend_trait_method_reference = record
      method_name : P_zend_string;
      ce : P_zend_class_entry;
      class_name : P_zend_string;
    end;
  zend_trait_method_reference = _zend_trait_method_reference;


  hgerhrh343erg = record
          case longint of
            0 : ( ce : P_zend_class_entry );
            1 : ( class_name : P_zend_string );
          end;
  _zend_trait_precedence = record
      trait_method : Pzend_trait_method_reference;
      exclude_from_classes : ^hgerhrh343erg;
    end;
  zend_trait_precedence = _zend_trait_precedence;

  _zend_trait_alias = record
      trait_method : Pzend_trait_method_reference;
      alias : P_zend_string;
      modifiers : Cardinal;
    end;
  zend_trait_alias = _zend_trait_alias;

  _zend_class_iterator_funcs = record
      funcs : Pzend_object_iterator_funcs;
      zf_new_iterator : P_zend_function;
      zf_valid : P_zend_function;
      zf_current : P_zend_function;
      zf_key : P_zend_function;
      zf_next : P_zend_function;
      zf_rewind : P_zend_function;
    end;
  zend_class_iterator_funcs = _zend_class_iterator_funcs;

  _zend_class_entry = record
      _type : char;
      name : P_zend_string;
      parent : P_zend_class_entry;
      refcount : longint;
      ce_flags : Cardinal;
      default_properties_count : longint;
      default_static_members_count : longint;
      default_properties_table : Pzval;
      default_static_members_table : Pzval;
      static_members_table : Pzval;
      function_table : HashTable;
      properties_info : HashTable;
      constants_table : HashTable;
      _constructor : P_zend_function;
      _destructor : P_zend_function;
      clone : P_zend_function;
      __get : P_zend_function;
      __set : P_zend_function;
      __unset : P_zend_function;
      __isset : P_zend_function;
      __call : P_zend_function;
      __callstatic : P_zend_function;
      __tostring : P_zend_function;
      __debugInfo : P_zend_function;
      serialize_func : P_zend_function;
      unserialize_func : P_zend_function;
      iterator_funcs : zend_class_iterator_funcs;
      create_object : function (class_type:p_zend_class_entry):P_zend_object;cdecl;
      get_iterator : function (ce:p_zend_class_entry; _object:pzval; by_ref:longint):P_zend_object_iterator;cdecl;
      interface_gets_implemented : function (iface:p_zend_class_entry; class_type:p_zend_class_entry):longint;cdecl;
      get_static_method : function (ce:p_zend_class_entry; method:p_zend_string):P_zend_function;cdecl;
      serialize : function (_object:pzval; buffer:LPBYTE; buf_len:Psize_t; data:p_zend_serialize_data):longint;cdecl;
      unserialize : function (_object:pzval; ce:p_zend_class_entry; buf:pbyte; buf_len:size_t; data:p_zend_unserialize_data):longint;cdecl;
      num_interfaces : Cardinal;
      num_traits : Cardinal;
      interfaces : ^P_zend_class_entry;
      traits : ^P_zend_class_entry;
      trait_aliases : ^Pzend_trait_alias;
      trait_precedences : ^Pzend_trait_precedence;
      info : record
          case longint of
            0 : ( user : record
                filename : P_zend_string;
                line_start : Cardinal;
                line_end : Cardinal;
                doc_comment : P_zend_string;
              end );
            1 : ( internal : record
                builtin_functions : P_zend_function_entry;
                module : P_zend_module_entry;
              end );
          end;
    end;
    	zend_class_entry = _zend_class_entry;
  TZend_class_entry = _zend_class_entry;

  zend_stream_fsizer_t = function ( handle:pointer):size_t;cdecl;

  zend_stream_reader_t = function ( handle:pointer; buf:zend_pchar; len:size_t):size_t;cdecl;

  zend_stream_closer_t = procedure ( handle:pointer);cdecl;



 // __stat64 = zend_stat_t;
 // stat = zend_stat_t;

  zend_stream_type = (ZEND_HANDLE_FILENAME,ZEND_HANDLE_FD,ZEND_HANDLE_FP,
    ZEND_HANDLE_STREAM,ZEND_HANDLE_MAPPED);

_zend_mmap = record
  len : size_t;
  pos : size_t;
  map : pointer;
  buf : zend_pchar;
  old_handle : pointer;
  old_closer : zend_stream_closer_t;
end;
  zend_mmap = _zend_mmap;

  _zend_stream = record
      handle : pointer;
      isatty : longint;
      mmap : zend_mmap;
      reader : zend_stream_reader_t;
      fsizer : zend_stream_fsizer_t;
      closer : zend_stream_closer_t;
    end;
  zend_stream = _zend_stream;

  PZendFileHandle = ^_zend_file_handle;
  _zend_file_handle = record
      handle : record
          case longint of
            0 : ( fd : longint );
            1 : ( fp : pointer );
            2 : ( stream : zend_stream );
          end;
      filename : zend_pchar;
      opened_path : P_zend_string;
      _type : zend_stream_type;
      free_filename : zend_bool;
    end;
  zend_file_handle = _zend_file_handle;


  _zend_utility_functions = record
      error_function : procedure (_type:longint; error_filename:zend_pchar; error_lineno:uint; format:zend_pchar; args:va_list);cdecl;
      printf_function : function (format:zend_pchar):size_t;cdecl varargs;
      write_function : function (str:zend_pchar; str_length:size_t):size_t;cdecl;
      fopen_function : function (filename:zend_pchar; opened_path:pP_zend_string):POINTER;cdecl;
      message_handler : procedure (message:zend_long; data:pointer);cdecl;
      block_interruptions : procedure ;cdecl;
      unblock_interruptions : procedure ;cdecl;
      get_configuration_directive : function (name:p_zend_string):Pzval;cdecl;
      ticks_function : procedure (ticks:longint);cdecl;
      on_timeout : procedure (seconds:longint);cdecl;
      stream_open_function : function (filename:zend_pchar; handle:pzend_file_handle):longint;cdecl;
      vspprintf_function : function (pbuf:PPchar; max_len:size_t; format:zend_pchar; ap:va_list):size_t;cdecl;
      vstrpprintf_function : function (max_len:size_t; format:zend_pchar; ap:va_list):P_zend_string;cdecl;
      getenv_function : function (name:zend_pchar; name_len:size_t):zend_pchar;cdecl;
      resolve_path_function : function (filename:zend_pchar; filename_len:longint):P_zend_string;cdecl;
    end;
  zend_utility_functions = _zend_utility_functions;

  _zend_utility_values = record
      import_use_extension : zend_pchar;
      import_use_extension_length : uint;
      html_errors : zend_bool;
    end;
  zend_utility_values = _zend_utility_values;

  zend_write_func_t = function (str:zend_pchar; str_length:size_t):longint;cdecl;
  zend_write_t = zend_write_func_t;

  zend_error_handling_t = (EH_NORMAL = 0,EH_SUPPRESS,EH_THROW);

  zend_error_handling = record
      handling : zend_error_handling_t;
      exception : P_zend_class_entry;
      user_handler : zval;
    end;






  _znode_op = record
      case longint of
        0 : ( constant : cardinal );
        1 : ( _var : cardinal );
        2 : ( num : cardinal );
        3 : ( opline_num : cardinal );
        4 : ( jmp_offset : cardinal );
        5 : ( zv : Pzval );
      end;
  znode_op = _znode_op;

  _znode = record
      op_type : zend_uchar;
      flag : zend_uchar;
      u : record
          case longint of
            0 : ( op : znode_op );
            1 : ( constant : zval );
          end;
    end;
  znode = _znode;

  _zend_ast_znode = record
      kind : zend_ast_kind;
      attr : zend_ast_attr;
      lineno : Cardinal;
      node : znode;
    end;
  zend_ast_znode = _zend_ast_znode;

  _zend_declarables = record
      ticks : zend_long;
    end;
  zend_declarables = _zend_declarables;

  _zend_oparray_context = record
      opcodes_size : Cardinal;
      vars_size : longint;
      literals_size : longint;
      current_brk_cont : longint;
      backpatch_count : longint;
      in_finally : longint;
      fast_call_var : Cardinal;
      labels : PHashTable;
    end;
  zend_oparray_context = _zend_oparray_context;

  _zend_file_context = record
      declarables : zend_declarables;
      implementing_class : znode;
      current_namespace : P_zend_string;
      in_namespace : zend_bool;
      has_bracketed_namespaces : zend_bool;
      imports : PHashTable;
      imports_function : PHashTable;
      imports_const : PHashTable;
    end;
  zend_file_context = _zend_file_context;

  _zend_parser_stack_elem = record
      case longint of
        0 : ( ast : P_zend_ast );
        1 : ( str : P_zend_string );
        2 : ( num : zend_ulong );
      end;
  zend_parser_stack_elem = _zend_parser_stack_elem;


  _zend_execute_data = record
      opline : P_zend_op;
      call :P_zend_execute_data;
      return_value :Pzval;
      func : P_zend_function;
      This : zval;
      called_scope : P_zend_class_entry;
      prev_execute_data :P_zend_execute_data;
      symbol_table :P_zend_array;
      run_time_cache : ^pointer;
      literals : Pzval;
    end;
   zend_execute_data = _zend_execute_data;

  user_opcode_handler_t = function (execute_data:p_zend_execute_data):longint;cdecl;

  _zend_op = record
      handler : pointer;
      op1 : znode_op;
      op2 : znode_op;
      result : znode_op;
      extended_value : Cardinal;
      lineno : Cardinal;
      opcode : zend_uchar;
      op1_type : zend_uchar;
      op2_type : zend_uchar;
      result_type : zend_uchar;
    end;
    zend_op = _zend_op ;


  _zend_brk_cont_element = record
      start : longint;
      cont : longint;
      brk : longint;
      parent : longint;
    end;
  zend_brk_cont_element = _zend_brk_cont_element;

  _zend_label = record
      brk_cont : longint;
      opline_num : Cardinal;
    end;
  zend_label = _zend_label;

  _zend_try_catch_element = record
      try_op : Cardinal;
      catch_op : Cardinal;
      finally_op : Cardinal;
      finally_end : Cardinal;
    end;
  zend_try_catch_element = _zend_try_catch_element;

  _zend_property_info = record
      offset : Cardinal;
      flags : Cardinal;
      name : P_zend_string;
      doc_comment : P_zend_string;
      ce : P_zend_class_entry;
    end;
  zend_property_info = _zend_property_info;

  _zend_internal_arg_info = record
      name : zend_pchar;
      class_name : zend_pchar;
      type_hint : zend_uchar;
      pass_by_reference : zend_uchar;
      allow_null : zend_bool;
      is_variadic : zend_bool;
    end;
  zend_internal_arg_info = _zend_internal_arg_info;

  _zend_arg_info = record
      name : P_zend_string;
      class_name : P_zend_string;
      type_hint : zend_uchar;
      pass_by_reference : zend_uchar;
      allow_null : zend_bool;
      is_variadic : zend_bool;
    end;
  zend_arg_info = _zend_arg_info;

  _zend_internal_function_info = record
      required_num_args : zend_uintptr_t;
      class_name : zend_pchar;
      type_hint : zend_uchar;
      return_reference : zend_bool;
      allow_null : zend_bool;
      _is_variadic : zend_bool;
    end;
  zend_internal_function_info = _zend_internal_function_info;

  _zend_op_array = record
      _type : zend_uchar;
      arg_flags : array[0..2] of zend_uchar;
      fn_flags : Cardinal;
      function_name : P_zend_string;
      scope : P_zend_class_entry;
      prototype : P_zend_function;
      num_args : Cardinal;
      required_num_args : Cardinal;
      arg_info : Pzend_arg_info;
      refcount : ^Cardinal;
      this_var : Cardinal;
      last : Cardinal;
      opcodes : P_zend_op;
      last_var : longint;
      T : Cardinal;
      vars : ^P_zend_string;
      last_brk_cont : longint;
      last_try_catch : longint;
      brk_cont_array : Pzend_brk_cont_element;
      try_catch_array : Pzend_try_catch_element;
      static_variables : PHashTable;
      filename : P_zend_string;
      line_start : Cardinal;
      line_end : Cardinal;
      doc_comment : P_zend_string;
      early_binding : Cardinal;
      last_literal : longint;
      literals : Pzval;
      cache_size : longint;
      run_time_cache : ^pointer;
      reserved : array[0..3] of pointer;
    end;
     zend_op_array = _zend_op_array;


  _zend_internal_function = record
      _type : zend_uchar;
      arg_flags : array[0..2] of zend_uchar;
      fn_flags : Cardinal;
      function_name : P_zend_string;
      scope : P_zend_class_entry;
      prototype : P_zend_function;
      num_args : Cardinal;
      required_num_args : Cardinal;
      arg_info : Pzend_internal_arg_info;
      handler : procedure (execute_data:p_zend_execute_data; return_value:pzval);cdecl;
      module : P_zend_module_entry;
      reserved : array[0..3] of pointer;
    end;
  tzend_internal_function = _zend_internal_function;




  _zend_function = record
      case longint of
        0 : ( _type : zend_uchar );
        1 : ( common : record
            _type : zend_uchar;
            arg_flags : array[0..2] of zend_uchar;
            fn_flags : Cardinal;
            function_name : P_zend_string;
            scope : P_zend_class_entry;
            prototype : P_zend_function;
            num_args : Cardinal;
            required_num_args : Cardinal;
            arg_info : Pzend_arg_info;
          end );
        2 : ( op_array : zend_op_array );
        3 : ( internal_function : tzend_internal_function );
      end;

  zend_function = _zend_function;




  _zend_call_kind = (ZEND_CALL_NESTED_FUNCTION,ZEND_CALL_NESTED_CODE,
    ZEND_CALL_TOP_FUNCTION,ZEND_CALL_TOP_CODE
    );
  zend_call_kind = _zend_call_kind;







  unary_op_type = function (a:pzval; b:pzval):longint;cdecl;

  binary_op_type = function (a:pzval; b:pzval; c:pzval):longint;cdecl;
  zend_auto_global_callback = function (name:p_zend_string):zend_bool;cdecl;


  _zend_auto_global = record
      name : P_zend_string;
      auto_global_callback : zend_auto_global_callback;
      jit : zend_bool;
      armed : zend_bool;
    end;
  zend_auto_global = _zend_auto_global;













  HashPosition = cardinal;

  _HashTableIterator = record
      ht : PHashTable;
      pos : HashPosition;
    end;
  HashTableIterator = _HashTableIterator;

  _zend_object = record
      gc : zend_refcounted_h;
      handle : cardinal;
      ce : P_zend_class_entry;
      handlers : P_zend_object_handlers;
      properties : PHashTable;
      properties_table : array[0..0] of zval;
    end;
   zend_object = _zend_object;

  _zend_resource = record
      gc : zend_refcounted_h;
      handle : longint;
      _type : longint;
      ptr : pointer;
    end;
   zend_resource = _zend_resource;

  _zend_reference = record
      gc : zend_refcounted_h;
      val : zval;
    end;
    zend_reference = _zend_reference;

  _zend_ast_ref = record
      gc : zend_refcounted_h;
      ast : P_zend_ast;
    end;
   zend_ast_ref = _zend_ast_ref;


  zend_object_read_property_t = function (_object:pzval; member:pzval; _type:longint; cache_slot:ppointer; rv:pzval):Pzval;cdecl;

  zend_object_read_dimension_t = function (_object:pzval; offset:pzval; _type:longint; rv:pzval):Pzval;cdecl;

  zend_object_write_property_t = procedure (_object:pzval; member:pzval; value:pzval; cache_slot:ppointer);cdecl;

  zend_object_write_dimension_t = procedure (_object:Pzval; offset:Pzval; value:pzval);cdecl;

  zend_object_get_property_ptr_ptr_t = function (_object:Pzval; member:Pzval; _type:longint; cache_slot:pointer):Pzval;cdecl;

  zend_object_set_t = procedure (_object:Pzval; value:pzval);cdecl;

  zend_object_get_t = function (_object:Pzval; rv:pzval):Pzval;cdecl;

  zend_object_has_property_t = function (_object:Pzval; member:Pzval; has_set_exists:longint; cache_slot:pointer):longint;cdecl;


  zend_object_has_dimension_t = function (_object:Pzval; member:Pzval; check_empty:longint):longint;cdecl;


  zend_object_unset_property_t = procedure (_object:Pzval; member:Pzval; cache_slot:pointer);cdecl;


  zend_object_unset_dimension_t = procedure (_object:Pzval; offset:pzval);cdecl;


  zend_object_get_properties_t = function (_object:pzval):PHashTable;cdecl;


  zend_object_get_debug_info_t = function (_object:Pzval; is_temp:plongint):PHashTable;cdecl;




  zend_object_call_method_t = function (method:P_zend_string; _object:P_zend_object; execute_data:P_zend_execute_data; return_value:pzval):longint;cdecl;

  zend_object_get_method_t = function (_object:PP_zend_object; method:P_zend_string; key:pzval):P_zend_function;cdecl;

  zend_object_get_constructor_t = function (_object:pzend_object):P_zend_function;cdecl;


  zend_object_dtor_obj_t = procedure (_object:pzend_object);cdecl;

  zend_object_free_obj_t = procedure (_object:pzend_object);cdecl;

  zend_object_clone_obj_t = function (_object:pzval):P_zend_object;cdecl;

  zend_object_get_class_name_t = function (_object:pzend_object):P_zend_string;cdecl;

  zend_object_compare_t = function (object1:Pzval; object2:pzval):longint;cdecl;

  zend_object_compare_zvals_t = function (resul:Pzval; op1:Pzval; op2:pzval):longint;cdecl;


  zend_object_cast_t = function (readobj:Pzval; retval:Pzval; _type:longint):longint;cdecl;


  zend_object_count_elements_t = function (_object:Pzval; count:pzend_long):longint;cdecl;

  zend_object_get_closure_t = function (obj:Pzval; ce_ptr:PP_zend_class_entry; fptr_ptr:PP_zend_function; obj_ptr:pP_zend_object):longint;cdecl;

  zend_object_get_gc_t = function (_object:Pzval; table:PPzval; n:plongint):PHashTable;cdecl;

  zend_object_do_operation_t = function (opcode:zend_uchar; result:Pzval; op1:Pzval; op2:pzval):longint;cdecl;


  _zend_stack = record
      size : longint;
      top : longint;
      max : longint;
      elements : pointer;
    end;
  zend_stack = _zend_stack;


  _zend_object_handlers = record
      offset : longint;
      free_obj : zend_object_free_obj_t;
      dtor_obj : zend_object_dtor_obj_t;
      clone_obj : zend_object_clone_obj_t;
      read_property : zend_object_read_property_t;
      write_property : zend_object_write_property_t;
      read_dimension : zend_object_read_dimension_t;
      write_dimension : zend_object_write_dimension_t;
      get_property_ptr_ptr : zend_object_get_property_ptr_ptr_t;
      get : zend_object_get_t;
      _set : zend_object_set_t;
      has_property : zend_object_has_property_t;
      unset_property : zend_object_unset_property_t;
      has_dimension : zend_object_has_dimension_t;
      unset_dimension : zend_object_unset_dimension_t;
      get_properties : zend_object_get_properties_t;
      get_method : zend_object_get_method_t;
      call_method : zend_object_call_method_t;
      get_constructor : zend_object_get_constructor_t;
      get_class_name : zend_object_get_class_name_t;
      compare_objects : zend_object_compare_t;
      cast_object : zend_object_cast_t;
      count_elements : zend_object_count_elements_t;
      get_debug_info : zend_object_get_debug_info_t;
      get_closure : zend_object_get_closure_t;
      get_gc : zend_object_get_gc_t;
      do_operation : zend_object_do_operation_t;
      compare : zend_object_compare_zvals_t;
    end;






  _zend_object_iterator = record
      std : zend_object;
      data : zval;
      funcs : Pzend_object_iterator_funcs;
      index : zend_ulong;
    end;


     zend_object_iterator = _zend_object_iterator;
  _zend_object_iterator_funcs = record
      dtor : procedure (iter:pzend_object_iterator);cdecl;
      valid : function (iter:pzend_object_iterator):longint;cdecl;
      get_current_data : function (iter:pzend_object_iterator):Pzval;cdecl;
      get_current_key : procedure (iter:P_zend_object_iterator; key:pzval);cdecl;
      move_forward : procedure (iter:pzend_object_iterator);cdecl;
      rewind : procedure (iter:pzend_object_iterator);cdecl;
      invalidate_current : procedure (iter:pzend_object_iterator);cdecl;
    end;
  zend_object_iterator_funcs = _zend_object_iterator_funcs;



  _zend_ini_parser_param = record
      ini_parser_cb : zend_ini_parser_cb_t;
      arg : pointer;
    end;
  zend_ini_parser_param = _zend_ini_parser_param;


  _zend_module_entry = record
      size : word;
      zend_api : dword;
      zend_debug : byte;
      zts : byte;
      ini_entry : P_zend_ini_entry;
      deps : P_zend_module_dep;
      name : zend_pchar;
      functions : P_zend_function_entry;
      module_startup_func : function (_type:longint; module_number:longint):longint;cdecl;
      module_shutdown_func : function (_type:longint; module_number:longint):longint;cdecl;
      request_startup_func : function (_type:longint; module_number:longint):longint;cdecl;
      request_shutdown_func : function (_type:longint; module_number:longint):longint;cdecl;
      info_func : procedure (zend_module:p_zend_module_entry);cdecl;
      version : zend_pchar;
      globals_size : size_t;
      globals_ptr : pointer;
      globals_ctor : procedure (global:pointer);cdecl;
      globals_dtor : procedure (global:pointer);cdecl;
      post_deactivate_func : function :longint;cdecl;
      module_started : longint;
      _type : byte;
      handle : pointer;
      module_number : longint;
      build_id : zend_pchar;
    end;
    zend_module_entry = _zend_module_entry;





  _zend_module_dep = record
      name : zend_pchar;
      rel : zend_pchar;
      version : zend_pchar;
      _type : byte;
    end;

      zend_module_dep = _zend_module_dep;

  _zend_function_entry = record
      fname : zend_pchar;
      handler : pointer;
      //handler: procedure (execute_data:P_zend_execute_data; return_value:Pointer);cdecl;
      arg_info : P_zend_internal_arg_info;
      num_args : Cardinal;
      flags : Cardinal;
    end;
  zend_function_entry = _zend_function_entry;

  _php_stream_context = record
      notifier : P_php_stream_notifier;
      options : zval;
      res : P_zend_resource;
    end;
   php_stream_context = _php_stream_context ;
  php_stream_notification_func = procedure (context:P_php_stream_context; notifycode:longint; severity:longint; xmsg:zend_pchar; xcode:longint;
                bytes_sofar:size_t; bytes_max:size_t; ptr:pointer);cdecl;


  _php_stream_notifier = record
      func : php_stream_notification_func;
      dtor : procedure (notifier:p_php_stream_notifier);
      ptr : zval;
      mask : longint;
      progress : size_t;
      progress_max : size_t;
    end;









  _php_stream_bucket = record
      next : P_php_stream_bucket;
      prev : P_php_stream_bucket;
      brigade : P_php_stream_bucket_brigade;
      buf : zend_pchar;
      buflen : size_t;
      own_buf : longint;
      is_persistent : longint;
      refcount : longint;
    end;

  _php_stream_bucket_brigade = record
      head : P_php_stream_bucket;
      tail : P_php_stream_bucket;
    end;

  php_stream_bucket = _php_stream_bucket ;
  php_stream_bucket_brigade = _php_stream_bucket_brigade ;

  php_stream_filter_status_t = (PSFS_ERR_FATAL,PSFS_FEED_ME,PSFS_PASS_ON
    );


  _php_stream_filter_chain = record
      head : P_php_stream_filter;
      tail : P_php_stream_filter;
      stream : P_php_stream;
    end;
  php_stream_filter_chain = _php_stream_filter_chain;
  _php_stream = record
      ops : Pphp_stream_ops;
      _abstract : pointer;
      readfilters : php_stream_filter_chain;
      writefilters : php_stream_filter_chain;
      wrapper : P_php_stream_wrapper;
      wrapperthis : pointer;
      wrapperdata : zval;
      fgetss_state : longint;
      is_persistent : longint;
      mode : array[0..15] of char;
      res : P_zend_resource;
      in_free : longint;
      fclose_stdiocast : longint;
      stdiocast : POINTER;
      __exposed : longint;
      orig_path : zend_pchar;
      ctx : P_zend_resource;
      flags : longint;
      eof : longint;
      position : zend_off_t;
      readbuf : Pbyte;
      readbuflen : size_t;
      readpos : zend_off_t;
      writepos : zend_off_t;
      chunk_size : size_t;
      open_filename : zend_pchar;
      open_lineno : uint;
      enclosing_stream : P_php_stream;
    end;

    php_stream = _php_stream   ;
  _php_stream_filter = record
      fops : Pphp_stream_filter_ops;
      _abstract : zval;
      next : P_php_stream_filter;
      prev : P_php_stream_filter;
      is_persistent : longint;
      chain : Pphp_stream_filter_chain;
      buffer : php_stream_bucket_brigade;
      res : P_zend_resource;
    end;
    php_stream_filter = _php_stream_filter  ;
  _php_stream_filter_ops = record
      filter : function (stream:P_php_stream; thisfilter:P_php_stream_filter; buckets_in:P_php_stream_bucket_brigade; buckets_out:P_php_stream_bucket_brigade; bytes_consumed:Psize_t;
                   flags:longint):php_stream_filter_status_t;cdecl;
      dtor : procedure (thisfilter:p_php_stream_filter);cdecl;
      _label : zend_pchar;
    end;
  php_stream_filter_ops = _php_stream_filter_ops;





  _php_stream_filter_factory = record
      create_filter : function (filtername:zend_pchar; filterparams:Pzval; persistent:longint):P_php_stream_filter;cdecl;
    end;
  php_stream_filter_factory = _php_stream_filter_factory;






  _php_stream_statbuf = record
      sb : zend_stat_t;
    end;
  php_stream_statbuf = _php_stream_statbuf;

  _php_stream_dirent = record
      d_name : array[0..(256)-1] of char;
    end;
  php_stream_dirent = _php_stream_dirent;



  _php_stream_ops = record
      write : function (stream:P_php_stream; buf:zend_pchar; count:size_t):size_t;cdecl;
      read : function (stream:P_php_stream; buf:zend_pchar; count:size_t):size_t;cdecl;
      close : function (stream:P_php_stream; close_handle:longint):longint;cdecl;
      flush : function (stream:p_php_stream):longint;cdecl;
      _label : zend_pchar;
      seek : function (stream:P_php_stream; offset:zend_off_t; whence:longint; newoffset:pzend_off_t):longint;cdecl;
      cast : function (stream:P_php_stream; castas:longint; ret:ppointer):longint;cdecl;
      stat : function (stream:P_php_stream; ssb:pphp_stream_statbuf):longint;cdecl;
      set_option : function (stream:P_php_stream; option:longint; value:longint; ptrparam:pointer):longint;cdecl;
    end;
  php_stream_ops = _php_stream_ops;

  _php_stream_wrapper = record
      wops : Pphp_stream_wrapper_ops;
      _abstract : pointer;
      is_url : longint;
    end;
  php_stream_wrapper = _php_stream_wrapper   ;

  _php_stream_wrapper_ops = record
      stream_opener : function (wrapper:P_php_stream_wrapper; filename:zend_pchar; mode:zend_pchar; options:longint; opened_path:PP_zend_string; context:P_php_stream_context; __php_stream_call_depth:longint; __zend_filename:zend_pchar; __zend_lineno:uint; __zend_orig_filename:zend_pchar;  __zend_orig_lineno:uint):P_php_stream;cdecl;
      stream_closer : function (wrapper:P_php_stream_wrapper; stream:p_php_stream):longint;cdecl;
      stream_stat : function (wrapper:P_php_stream_wrapper; stream:P_php_stream; ssb:pphp_stream_statbuf):longint;cdecl;
      url_stat : function (wrapper:P_php_stream_wrapper; url:zend_pchar; flags:longint; ssb:Pphp_stream_statbuf; context:pphp_stream_context):longint;cdecl;
      dir_opener : function (wrapper:P_php_stream_wrapper; filename:zend_pchar; mode:zend_pchar; options:longint; opened_path:PP_zend_string; context:P_php_stream_context; __php_stream_call_depth:longint; __zend_filename:zend_pchar; __zend_lineno:uint; __zend_orig_filename:zend_pchar;  __zend_orig_lineno:uint):P_php_stream;cdecl;
      _label : zend_pchar;
      unlink : function (wrapper:P_php_stream_wrapper; url:zend_pchar; options:longint; context:pphp_stream_context):longint;cdecl;
      rename : function (wrapper:P_php_stream_wrapper; url_from:zend_pchar; url_to:zend_pchar; options:longint; context:pphp_stream_context):longint;cdecl;
      stream_mkdir : function (wrapper:P_php_stream_wrapper; url:zend_pchar; mode:longint; options:longint; context:pphp_stream_context):longint;cdecl;
      stream_rmdir : function (wrapper:P_php_stream_wrapper; url:zend_pchar; options:longint; context:Pphp_stream_context):longint;cdecl;
      stream_metadata : function (wrapper:P_php_stream_wrapper; url:zend_pchar; options:longint; value:Ppointer; context:Pphp_stream_context):longint;cdecl;
    end;
  php_stream_wrapper_ops = _php_stream_wrapper_ops;







  sapi_header_struct = record
      header : zend_pchar;
      header_len : size_t;
    end;




  _zend_llist_element = record
      next : P_zend_llist_element;
      prev : P_zend_llist_element;
      data : array[0..0] of char;
    end;
  zend_llist_element = _zend_llist_element;


  llist_dtor_func_t = procedure (_para1:pointer);cdecl;

  llist_compare_func_t = function (_para1:PP_zend_llist_element; _para2:PP_zend_llist_element):longint;cdecl;

  llist_apply_with_args_func_t = procedure (data:Ppointer; num_args:longint; args:va_list);cdecl;

  llist_apply_with_arg_func_t = procedure (data:Ppointer; arg:Ppointer);cdecl;

  llist_apply_func_t = procedure (_para1:pointer);cdecl;

  _zend_llist = record
      head : Pzend_llist_element;
      tail : Pzend_llist_element;
      count : size_t;
      size : size_t;
      dtor : llist_dtor_func_t;
      persistent : byte;
      traverse_ptr : Pzend_llist_element;
    end;
  zend_llist = _zend_llist;

  zend_llist_position = Pzend_llist_element;


  sapi_headers_struct = record
      headers : zend_llist;
      http_response_code : longint;
      send_default_content_type : byte;
      mimetype : zend_pchar;
      http_status_line : zend_pchar;
    end;

  _sapi_post_entry = record
      content_type : zend_pchar;
      content_type_len : uint;
      post_reader : procedure ;cdecl;
      post_handler : procedure (content_type_dup:zend_pchar; arg:Ppointer);cdecl;
    end;
  sapi_post_entry = _sapi_post_entry;



  sapi_request_info = record
      request_method : zend_pchar;
      query_string : zend_pchar;
      cookie_data : zend_pchar;
      content_length : zend_long;
      path_translated : zend_pchar;
      request_uri : zend_pchar;
      request_body : P_php_stream;
      content_type : zend_pchar;
      headers_only : zend_bool;
      no_headers : zend_bool;
      headers_read : zend_bool;
      post_entry : P_sapi_post_entry;
      content_type_dup : zend_pchar;
      auth_user : zend_pchar;
      auth_password : zend_pchar;
      auth_digest : zend_pchar;
      argv0 : zend_pchar;
      current_user : zend_pchar;
      current_user_length : longint;
      argc : longint;
      argv : ^zend_pchar;
      proto_num : longint;
    end;


  _sapi_globals_struct = record
      server_context : pointer;
      request_info : sapi_request_info;
      sapi_headers : sapi_headers_struct;
      read_post_bytes : FixedUInt ;
      post_read : byte;
      headers_sent : byte;
      global_stat : zend_stat_t;
      default_mimetype : zend_pchar;
      default_charset : zend_pchar;
      rfc1867_uploaded_files : PHashTable;
      post_max_size : zend_long;
      options : longint;
      sapi_started : zend_bool;
      global_request_time : double;
      known_post_content_types : HashTable;
      callback_func : zval;
      fci_cache : zend_fcall_info_cache;
    end;
  sapi_globals_struct = _sapi_globals_struct;

  sapi_header_line = record
      line : zend_pchar;
      line_len : size_t;
      response_code : zend_long;
    end;





  sapi_header_op_enum = (SAPI_HEADER_REPLACE,SAPI_HEADER_ADD_,SAPI_HEADER_DELETE,
    SAPI_HEADER_DELETE_ALL,SAPI_HEADER_SET_STATUS
    );


  _sapi_module_struct = record
      name : zend_pchar;
      pretty_name : zend_pchar;
      startup : function (sapi_module:P_sapi_module_struct):longint;cdecl;
      shutdown : function (sapi_module:P_sapi_module_struct):longint;cdecl;
      activate : function :longint;cdecl;
      deactivate : function :longint;cdecl;
      ub_write : function (str:zend_pchar; str_length:size_t):size_t;cdecl;
      flush : procedure (server_context:Ppointer);cdecl;
      get_stat : function :P_zend_stat_t;cdecl;
      getenv : function (name:zend_pchar; name_len:size_t):zend_pchar;cdecl;
      sapi_error : procedure (_type:longint; error_msg:zend_pchar);cdecl varargs;
      header_handler : function (sapi_header:Psapi_header_struct; op:sapi_header_op_enum; sapi_headers:Psapi_headers_struct):longint;cdecl;
      send_headers : function (sapi_headers:Psapi_headers_struct):longint;cdecl;
      send_header : procedure (sapi_header:Psapi_header_struct; server_context:Ppointer);cdecl;
      read_post : function (buffer:zend_pchar; count_bytes:size_t):size_t;cdecl;
      read_cookies : function :zend_pchar;cdecl;
      register_server_variables : procedure (track_vars_array:Pzval);cdecl;
      log_message : procedure (message:zend_pchar);cdecl;
      get_request_time : function :double;cdecl;
      terminate_process : procedure ;cdecl;
      php_ini_path_override : zend_pchar;
      block_interruptions : procedure ;cdecl;
      unblock_interruptions : procedure ;cdecl;
      default_post_reader : procedure ;cdecl;
      treat_data : procedure (arg:longint; str:zend_pchar; destArray:Pzval);cdecl;
      executable_location : zend_pchar;
      php_ini_ignore : longint;
      php_ini_ignore_cwd : longint;
      get_fd : function (fd:Plongint):longint;cdecl;
      force_http_10 : function :longint;cdecl;
      get_target_uid : function (_para1:Puid_t):longint;cdecl;
      get_target_gid : function (_para1:Pgid_t):longint;cdecl;
      input_filter : function (arg:longint; _var:zend_pchar; val:PPchar; val_len:size_t; new_val_len:Psize_t):dword;cdecl;
      ini_defaults : procedure (configuration_hash:PHashTable);cdecl;
      phpinfo_as_text : longint;
      ini_entries : zend_pchar;
      additional_functions : Pzend_function_entry;
      input_filter_init : function :dword;cdecl;
    end;
     sapi_module_struct = _sapi_module_struct;


  Ptsrm_intptr_t = ^tsrm_intptr_t;
  Ptsrm_uintptr_t = ^tsrm_uintptr_t;
   Pts_rsrc_id = ^ts_rsrc_id;

  tsrm_intptr_t = intptr;
  tsrm_uintptr_t = uintptr_t;


  ts_rsrc_id = longint;

  Pbeos_ben = ^beos_ben;
  beos_ben = record
      sem : integer;
      ben : longint;
    end;

  ts_allocate_ctor = procedure (_para1:pointer);cdecl;

  ts_allocate_dtor = procedure (_para1:pointer);cdecl;

  tsrm_thread_begin_func_t = procedure (thread_id:DWORD);cdecl;

  tsrm_thread_end_func_t = procedure (thread_id:DWORD);cdecl;



  zend_ini_entry = _zend_ini_entry ;



  _zend_arena = record
      ptr : zend_pchar;
      _end : zend_pchar;
      prev : P_zend_arena;
    end;
   zend_arena = _zend_arena;
  Pzend_compiler_globals = ^_zend_compiler_globals;
  _zend_compiler_globals = record
      loop_var_stack : zend_stack;
      active_class_entry : P_zend_class_entry;
      compiled_filename : P_zend_string;
      zend_lineno : longint;
      active_op_array : P_zend_op_array;
      function_table : PHashTable;
      class_table : PHashTable;
      filenames_table : HashTable;
      auto_globals : PHashTable;
      parse_error : zend_bool;
      in_compilation : zend_bool;
      short_tags : zend_bool;
      unclean_shutdown : zend_bool;
      ini_parser_unbuffered_errors : zend_bool;
      open_files : zend_llist;
      ini_parser_param : P_zend_ini_parser_param;
      start_lineno : uint32_t;
      increment_lineno : zend_bool;
      doc_comment : P_zend_string;
      compiler_options : uint32_t;
      const_filenames : HashTable;
      context : zend_oparray_context;
      file_context : zend_file_context;
      arena : P_zend_arena;
      empty_string : P_zend_string;
      one_char_string : array[0..255] of P_zend_string;
      interned_strings : HashTable;
      script_encoding_list : PPzend_encoding;
      script_encoding_list_size : size_t;
      multibyte : zend_bool;
      detect_unicode : zend_bool;
      encoding_declared : zend_bool;
      ast : P_zend_ast;
      ast_arena : P_zend_arena;
      delayed_oplines_stack : pointer;
      static_members_table : ^Pzval;
      last_static_member : longint;
    end;


  _zend_objects_store = record
      object_buckets : ^P_zend_object;
      top : uint32_t;
      size : uint32_t;
      free_list_head : longint;
    end;
  zend_objects_store = _zend_objects_store;

  Pzend_executor_globals = ^_zend_executor_globals;
  _zend_executor_globals = record
      uninitialized_zval : zval;
      error_zval : zval;
      symtable_cache : array[0..(32)-1] of P_zend_array;
      symtable_cache_limit : ^P_zend_array;
      symtable_cache_ptr : ^P_zend_array;
      symbol_table : zend_array;
      included_files : HashTable;
      bailout : pointer;
      error_reporting : longint;
      exit_status : longint;
      function_table : PHashTable;
      class_table : PHashTable;
      zend_constants : PHashTable;
      vm_stack_top : Pzval;
      vm_stack_end : Pzval;
      vm_stack : _zend_vm_stack;
      current_execute_data : P_zend_execute_data;
      scope : P_zend_class_entry;
      precision : zend_long;
      ticks_count : longint;
      in_autoload : PHashTable;
      autoload_func : P_zend_function;
      full_tables_cleanup : zend_bool;
      no_extensions : zend_bool;
      timed_out : zend_bool;
      windows_version_info : OSVERSIONINFOEX;
      regular_list : HashTable;
      persistent_list : HashTable;
      user_error_handler_error_reporting : longint;
      user_error_handler : zval;
      user_exception_handler : zval;
      user_error_handlers_error_reporting : zend_stack;
      user_error_handlers : zend_stack;
      user_exception_handlers : zend_stack;
      error_handling : zend_error_handling_t;
      exception_class : P_zend_class_entry;
      timeout_seconds : zend_long;
      lambda_count : longint;
      ini_directives : PHashTable;
      modified_ini_directives : PHashTable;
      error_reporting_ini_entry : P_zend_ini_entry;
      objects_store : zend_objects_store;
      exception : P_zend_object;
      prev_exception : P_zend_object;
      opline_before_exception : P_zend_op;
      exception_op : array[0..2] of zend_op;
      current_module : P_zend_module_entry;
      active : zend_bool;
      valid_symbol_table : zend_bool;
      assertions : zend_long;
      ht_iterators_count : uint32_t;
      ht_iterators_used : uint32_t;
      ht_iterators : PHashTableIterator;
      ht_iterators_slots : array[0..15] of HashTableIterator;
     // saved_fpu_cw_ptr : pointer;
      saved_fpu_cw : LONGINT;
      trampoline : zend_function;
      call_trampoline_op : zend_op;
      reserved : array[0..(4)-1] of pointer;
    end;

  _zend_ini_scanner_globals = record
      yy_in : Pzend_file_handle;
      yy_out : Pzend_file_handle;
      yy_leng : dword;
      yy_start : Pbyte;
      yy_text : Pbyte;
      yy_cursor : Pbyte;
      yy_marker : Pbyte;
      yy_limit : Pbyte;
      yy_state : longint;
      state_stack : zend_stack;
      filename : zend_pchar;
      lineno : longint;
      scanner_mode : longint;
    end;

  _zend_ptr_stack = record
      top : longint;
      max : longint;
      elements : ^pointer;
      top_element : ^pointer;
      persistent : zend_bool;
    end;
  zend_ptr_stack = _zend_ptr_stack;




  zend_encoding_filter = function (str:LPBYTE; str_length:Psize_t; buf:Pbyte; length:size_t):size_t;cdecl;

  Pzend_encoding_fetcher = ^zend_encoding_fetcher;
  zend_encoding_fetcher = function (encoding_name:zend_pchar):Pzend_encoding;cdecl;

  Pzend_encoding_name_getter = ^zend_encoding_name_getter;
  zend_encoding_name_getter = function (encoding:Pzend_encoding):zend_pchar;cdecl;

  zend_encoding_lexer_compatibility_checker = function (encoding:Pzend_encoding):longint;cdecl;

  zend_encoding_detector = function (_string:Pbyte; length:size_t; list:PPzend_encoding; list_size:size_t):Pzend_encoding;cdecl;

  zend_encoding_converter = function (_to:LPBYTE; to_length:Psize_t; from:Pbyte; from_length:size_t; encoding_to:Pzend_encoding;
               encoding_from:Pzend_encoding):size_t;cdecl;

  zend_encoding_list_parser = function (encoding_list:zend_pchar; encoding_list_len:size_t; return_list:PPPzend_encoding; return_size:Psize_t; persistent:longint):longint;cdecl;

  zend_encoding_internal_encoding_getter = function :Pzend_encoding;cdecl;

  zend_encoding_internal_encoding_setter = function (encoding:Pzend_encoding):longint;cdecl;


  _zend_multibyte_functions = record
      provider_name : zend_pchar;
      encoding_fetcher : zend_encoding_fetcher;
      encoding_name_getter : zend_encoding_name_getter;
      lexer_compatibility_checker : zend_encoding_lexer_compatibility_checker;
      encoding_detector : zend_encoding_detector;
      encoding_converter : zend_encoding_converter;
      encoding_list_parser : zend_encoding_list_parser;
      internal_encoding_getter : zend_encoding_internal_encoding_getter;
      internal_encoding_setter : zend_encoding_internal_encoding_setter;
    end;
  zend_multibyte_functions = _zend_multibyte_functions;

  _zend_leak_info = record
      addr : pointer;
      size : size_t;
      filename : zend_pchar;
      orig_filename : zend_pchar;
      lineno : uint;
      orig_lineno : uint;
    end;
  zend_leak_info = _zend_leak_info;



  _zend_mm_debug_info = record
      size : size_t;
      filename : zend_pchar;
      orig_filename : zend_pchar;
      lineno : uint;
      orig_lineno : uint;
    end;
  zend_mm_debug_info = _zend_mm_debug_info;

  _zend_mm_heap = record
      use_custom_heap : longint;
      storage : P_zend_mm_storage;
      size : size_t;
      peak : size_t;
      free_slot : array[0..(30)-1] of P_zend_mm_free_slot;
      real_size : size_t;
      real_peak : size_t;
      limit : size_t;
      overflow : longint;
      huge_list : P_zend_mm_huge_list;
      main_chunk : P_zend_mm_chunk;
      cached_chunks : P_zend_mm_chunk;
      chunks_count : longint;
      peak_chunks_count : longint;
      cached_chunks_count : longint;
      avg_chunks_count : double;
      custom_heap : record
          case longint of
            0 : ( std : record
                _malloc : function (_para1:size_t):pointer;cdecl;
                _free : procedure (_para1:pointer);cdecl;
                _realloc : function (_para1:pointer; _para2:size_t):pointer;cdecl;
              end );
            1 : ( debug : record
                _malloc : function (g:size_t; __zend_filename:zend_pchar; __zend_lineno:uint; __zend_orig_filename:zend_pchar; __zend_orig_lineno:uint):pointer;cdecl;
                _free : procedure (g:Ppointer; __zend_filename:zend_pchar; __zend_lineno:uint; __zend_orig_filename:zend_pchar; __zend_orig_lineno:uint);cdecl;
                _realloc : function (g:Ppointer; gg:size_t; __zend_filename:zend_pchar; __zend_lineno:uint; __zend_orig_filename:zend_pchar;
                             __zend_orig_lineno:uint):pointer;cdecl;
              end );
          end;
    end;


  _zend_mm_chunk = record
      heap : P_zend_mm_heap;
      next : P_zend_mm_chunk;
      prev : P_zend_mm_chunk;
      free_pages : longint;
      free_tail : longint;
      num : longint;
      reserve : array[0..(64 - (sizeof(POINTER) * 3 + sizeof(integer) * 3))] of char;
      heap_slot : _zend_mm_heap;
      free_map : pointer;
      map : Pointer;
    end;

  _zend_mm_page = record
      bytes : array[0..(4 * 1024)-1] of char;
    end;

  _zend_mm_bin = record
      bytes : array[0..(4 * 1024*8)-1] of char;
    end;

  _zend_mm_free_slot = record
      next_free_slot : P_zend_mm_free_slot;
    end;


  _zend_mm_huge_list = record
      ptr : pointer;
      size : size_t;
      next : P_zend_mm_huge_list;
      dbg : zend_mm_debug_info;
    end;



  zend_mm_chunk_alloc_t = function (storage:PPointer; size:size_t; alignment:size_t):pointer;cdecl;

  zend_mm_chunk_free_t = procedure (storage:PPointer; chunk:Ppointer; size:size_t);cdecl;

  zend_mm_chunk_truncate_t = function (storage:PPointer; chunk:Ppointer; old_size:size_t; new_size:size_t):longint;cdecl;

  zend_mm_chunk_extend_t = function (storage:PPointer; chunk:Ppointer; old_size:size_t; new_size:size_t):longint;cdecl;



  zend_mm_heap =_zend_mm_heap ;
   _zend_mm_handlers = record
      chunk_alloc : zend_mm_chunk_alloc_t;
      chunk_free : zend_mm_chunk_free_t;
      chunk_truncate : zend_mm_chunk_truncate_t;
      chunk_extend : zend_mm_chunk_extend_t;
    end;
  zend_mm_handlers = _zend_mm_handlers;
  _zend_mm_storage = record
      handlers : zend_mm_handlers;
      data : pointer;
    end;
    zend_mm_storage = _zend_mm_storage ;


  _zend_closure = record
      std : zend_object;
      func : zend_function;
      this_ptr : zval;
      called_scope : Pzend_class_entry;
      orig_internal_handler : procedure (var execute_data:zend_execute_data; var return_value:zval);cdecl;
    end;
  zend_closure = _zend_closure;



  _zend_php_scanner_globals = record
      yy_in : Pzend_file_handle;
      yy_out : Pzend_file_handle;
      yy_leng : dword;
      yy_start : Pbyte;
      yy_text : Pbyte;
      yy_cursor : Pbyte;
      yy_marker : Pbyte;
      yy_limit : Pbyte;
      yy_state : longint;
      state_stack : zend_stack;
      heredoc_label_stack : zend_ptr_stack;
      script_org : Pbyte;
      script_org_size : size_t;
      script_filtered : Pbyte;
      script_filtered_size : size_t;
      input_filter : zend_encoding_filter;
      output_filter : zend_encoding_filter;
      script_encoding : Pzend_encoding;
      scanned_string_len : longint;
      on_event : procedure (event:zend_php_scanner_event; token:longint; line:longint);cdecl;
    end;

  Pzend_hash_key = ^Tzend_hash_key;
  Tzend_hash_key = record
      h : zend_ulong;
      key : Pzend_string;
    end;

   Tsmart_str = record
      s:Pzend_string;
      a:size_t;
   end;





  Tmerge_checker_func_t = function (target_ht:PHashTable; source_data:Pzval; hash_key:Pzend_hash_key; pParam:Ppointer):zend_bool;cdecl;
  Tapply_func_t = function (pDest:Pzval):longint;cdecl;
  Tapply_func_arg_t = function (pDest:Pzval; argument:Ppointer):longint;cdecl;
  Tapply_func_args_t = function (pDest:Pzval; num_args:longint; args:va_list; hash_key:Pzend_hash_key):longint;cdecl;





IEJORGJIERGE = procedure (ini_entry:P_zend_ini_entry; _type:longint);
EWKGERGJ945YG45 = procedure (_para1:size_t);
OERGJOERJGIERGHRE = procedure (_para1:size_t);

ERG4JG09E84GJ8945H45H = procedure (_para1:pointer; _para2:size_t; __zend_filename:zend_pchar; __zend_lineno:uint; __zend_orig_filename:zend_pchar; __zend_orig_lineno:uint);
EWFG439EGRG45 =   procedure (_para1:pointer);
G5J90E4GK495Y4  = procedure (_para1:pointer);
  f584hj4i5hth = procedure (_para1:pointer);
  KD45T5H65HTHRTH = function (element:Ppointer; arg:Ppointer):longint;
  IEJG9458U9845Y45 = function (element:Ppointer):longint;
  ERGERG43T4T545YH546 = function (element1:Ppointer; element2:Ppointer):longint;
 RGEKG34I9TI3434 = function (data:Ppointer):longint;
var
smart_str_erealloc:procedure(str:psmart_str; len:size_t);cdecl;
smart_str_realloc:procedure(str:psmart_str; len:size_t); cdecl;
tsrm_set_new_thread_begin_handler:function(new_thread_begin_handler:tsrm_thread_begin_func_t):pointer; cdecl;
tsrm_set_new_thread_end_handler:function(new_thread_end_handler:tsrm_thread_end_func_t):pointer; cdecl;
tsrm_new_interpreter_context:function:pointer; cdecl;
tsrm_set_interpreter_context:function(new_ctx:Ppointer):pointer; cdecl;
tsrm_free_interpreter_context:procedure(context:Ppointer); cdecl;
tsrm_get_ls_cache:function:pointer; cdecl;
tsrm_error_set:procedure(level:longint; debug_filename:zend_pchar); cdecl;
tsrm_thread_id:function:DWORD; cdecl;
tsrm_mutex_alloc:function:pointer; cdecl;
tsrm_mutex_free:procedure(mutexp:Ppointer); cdecl;
tsrm_mutex_lock:function(mutexp:Ppointer):longint; cdecl;
tsrm_mutex_unlock:function(mutexp:Ppointer):longint; cdecl;
tsrm_startup:function(expected_threads:longint; expected_resources:longint; debug_level:longint; debug_filename:zend_pchar):longint; cdecl;
tsrm_shutdown:procedure; cdecl;
ts_allocate_id:function(rsrc_id:Pts_rsrc_id; size:size_t; ctor:ts_allocate_ctor; dtor:ts_allocate_dtor):ts_rsrc_id; cdecl;
ts_resource_ex:function(id:ts_rsrc_id; th_id:pointer):pointer; cdecl;
ts_free_thread:procedure; cdecl;
ts_free_id:procedure(id:ts_rsrc_id); cdecl;
php_request_startup:function:longint; cdecl;
php_request_shutdown:procedure( dummy:pointer); cdecl;
php_request_shutdown_for_exec:procedure(dummy:Ppointer); cdecl;
php_module_startup:function( sf:p_sapi_module_struct; additional_modules:p_zend_module_entry; num_additional_modules:uint):longint; cdecl;
php_module_shutdown:procedure; cdecl;
php_module_shutdown_for_exec:procedure; cdecl;
php_module_shutdown_wrapper:function(sapi_globals:Psapi_module_struct):longint; cdecl;
php_request_startup_for_hook:function:longint; cdecl;
php_request_shutdown_for_hook:procedure(dummy:Ppointer); cdecl;
php_register_extensions:function(ptr:PP_zend_module_entry; count:longint):longint; cdecl;
php_execute_script:function( primary_file:p_zend_file_handle):longint; cdecl;
php_execute_simple_script:function(primary_file:Pzend_file_handle; ret:Pzval):longint; cdecl;
php_handle_special_queries:function:longint; cdecl;
php_lint_script:function(_file:Pzend_file_handle):longint; cdecl;
php_handle_aborted_connection:procedure; cdecl;
php_handle_auth_data:function(auth:zend_pchar):longint; cdecl;
php_html_puts:procedure(str:zend_pchar; siz:size_t); cdecl;
php_stream_open_for_zend_ex:function(filename:zend_pchar; handle:Pzend_file_handle; mode:longint):longint; cdecl;


zend_strndup:function(s:zend_pchar; length:size_t):zend_pchar; cdecl;
_emalloc:function(size:size_t; __zend_filename:zend_pchar; __zend_lineno:uint; __zend_orig_filename:zend_pchar; __zend_orig_lineno:uint):pointer; cdecl;
_safe_emalloc:function(nmemb:size_t; size:size_t; offset:size_t; __zend_filename:zend_pchar; __zend_lineno:uint;  __zend_orig_filename:zend_pchar; __zend_orig_lineno:uint):pointer; cdecl;
_safe_malloc:function(nmemb:size_t; size:size_t; offset:size_t):pointer; cdecl;
_efree:procedure(ptr:Ppointer; __zend_filename:zend_pchar; __zend_lineno:uint; __zend_orig_filename:zend_pchar; __zend_orig_lineno:uint); cdecl;
_ecalloc:function(nmemb:size_t; size:size_t; __zend_filename:zend_pchar; __zend_lineno:uint; __zend_orig_filename:zend_pchar;  __zend_orig_lineno:uint):pointer; cdecl;
_erealloc:function(ptr:Ppointer; size:size_t; __zend_filename:zend_pchar; __zend_lineno:uint; __zend_orig_filename:zend_pchar; __zend_orig_lineno:uint):pointer; cdecl;
_erealloc2:function(ptr:Ppointer; size:size_t; copy_size:size_t; __zend_filename:zend_pchar; __zend_lineno:uint; __zend_orig_filename:zend_pchar; __zend_orig_lineno:uint):pointer; cdecl;
_safe_erealloc:function(ptr:Ppointer; nmemb:size_t; size:size_t; offset:size_t; __zend_filename:zend_pchar; __zend_lineno:uint; __zend_orig_filename:zend_pchar; __zend_orig_lineno:uint):pointer; cdecl;
_safe_realloc:function(ptr:Ppointer; nmemb:size_t; size:size_t; offset:size_t):pointer; cdecl;
_estrdup:function(s:zend_pchar; __zend_filename:zend_pchar; __zend_lineno:uint; __zend_orig_filename:zend_pchar; __zend_orig_lineno:uint):zend_pchar; cdecl;
_estrndup:function(s:zend_pchar; length:size_t; __zend_filename:zend_pchar; __zend_lineno:uint; __zend_orig_filename:zend_pchar; __zend_orig_lineno:uint):zend_pchar; cdecl;
_zend_mem_block_size:function(ptr:Ppointer; __zend_filename:zend_pchar; __zend_lineno:uint; __zend_orig_filename:zend_pchar; __zend_orig_lineno:uint):size_t; cdecl;
_emalloc_large:function(size:size_t):pointer; cdecl;
_emalloc_huge:function(size:size_t):pointer; cdecl;
_efree_large:procedure(_para1:pointer; size:size_t); cdecl;
_efree_huge:procedure(_para1:pointer; size:size_t); cdecl;
__zend_malloc:function(len:size_t):pointer; cdecl;
__zend_calloc:function(nmemb:size_t; len:size_t):pointer; cdecl;
__zend_realloc:function(p:Ppointer; len:size_t):pointer; cdecl;
zend_set_memory_limit:function(memory_limit:size_t):longint; cdecl;
start_memory_manager:procedure; cdecl;
shutdown_memory_manager:procedure(silent:longint; full_shutdown:longint); cdecl;
is_zend_mm:function:longint; cdecl;
zend_memory_usage:function(real_usage:longint):size_t; cdecl;
zend_memory_peak_usage:function(real_usage:longint):size_t; cdecl;
zend_mm_startup:function:P_zend_mm_heap; cdecl;
zend_mm_shutdown:procedure(heap:P_zend_mm_heap; full_shutdown:longint; silent:longint); cdecl;
_zend_mm_alloc:function(heap:P_zend_mm_heap; size:size_t; __zend_filename:zend_pchar; __zend_lineno:uint; __zend_orig_filename:zend_pchar; __zend_orig_lineno:uint):pointer; cdecl;
_zend_mm_free:procedure(heap:P_zend_mm_heap; p:Ppointer; __zend_filename:zend_pchar; __zend_lineno:uint; __zend_orig_filename:zend_pchar; __zend_orig_lineno:uint); cdecl;
_zend_mm_realloc:function(heap:P_zend_mm_heap; p:Ppointer; size:size_t; __zend_filename:zend_pchar; __zend_lineno:uint; __zend_orig_filename:zend_pchar; __zend_orig_lineno:uint):pointer; cdecl;
_zend_mm_realloc2:function(heap:P_zend_mm_heap; p:Ppointer; size:size_t; copy_size:size_t; __zend_filename:zend_pchar; __zend_lineno:uint; __zend_orig_filename:zend_pchar; __zend_orig_lineno:uint):pointer; cdecl;
_zend_mm_block_size:function(heap:P_zend_mm_heap; p:Ppointer; __zend_filename:zend_pchar; __zend_lineno:uint; __zend_orig_filename:zend_pchar; __zend_orig_lineno:uint):size_t; cdecl;
zend_mm_set_heap:function(new_heap:Pzend_mm_heap):P_zend_mm_heap; cdecl;
zend_mm_get_heap:function:P_zend_mm_heap; cdecl;
zend_mm_gc:function(heap:Pzend_mm_heap):size_t; cdecl;
zend_mm_is_custom_heap:function(new_heap:Pzend_mm_heap):longint; cdecl;

zend_mm_get_storage:function(heap:Pzend_mm_heap):P_zend_mm_storage; cdecl;
zend_mm_startup_ex:function(handlers:Pzend_mm_handlers; data:Ppointer; data_size:size_t):P_zend_mm_heap; cdecl;


 zend_stack_init:function(stack:Pzend_stack; size:longint):longint;
 zend_stack_push:function(stack:Pzend_stack; element:Ppointer):longint;
 zend_stack_top:function(stack:Pzend_stack):pointer;
 zend_stack_del_top:function(stack:Pzend_stack):longint;
 zend_stack_int_top:function(stack:Pzend_stack):longint;
 zend_stack_is_empty:function(stack:Pzend_stack):longint;
 zend_stack_destroy:function(stack:Pzend_stack):longint;
 zend_stack_base:function(stack:Pzend_stack):pointer;
 zend_stack_count:function(stack:Pzend_stack):longint;
 zend_stack_apply:procedure(stack:Pzend_stack; _type:longint; apply_function:IEJG9458U9845Y45);
 zend_stack_apply_with_argument:procedure(stack:Pzend_stack; _type:longint; apply_function:KD45T5H65HTHRTH; arg:Ppointer);
 zend_stack_clean:procedure(stack:Pzend_stack; func:f584hj4i5hth; free_elements:zend_bool);

	zend_std_get_static_method:function(ce:P_zend_class_entry; function_name_strval:P_zend_string; key:Pzval):P_zend_function; cdecl;
	zend_std_get_static_property:function(ce:P_zend_class_entry; property_name:P_zend_string; silent:zend_bool):Pzval; cdecl;
	zend_std_unset_static_property:function(ce:P_zend_class_entry; property_name:P_zend_string):zend_bool; cdecl;
	zend_std_get_constructor:function(_object:Pzend_object):P_zend_function; cdecl;
	zend_get_property_info:function(ce:P_zend_class_entry; member:P_zend_string; silent:longint):P_zend_property_info; cdecl;
	zend_std_get_properties:function(_object:Pzval):PHashTable; cdecl;
	zend_std_get_debug_info:function(_object:Pzval; is_temp:Plongint):PHashTable; cdecl;
	zend_std_cast_object_tostring:function(readobj:Pzval; writeobj:Pzval; _type:longint):longint; cdecl;
	zend_std_write_property:procedure(_object:Pzval; member:Pzval; value:Pzval; cache_slot:Ppointer); cdecl;
	rebuild_object_properties:procedure(zobj:Pzend_object); cdecl;
	zend_check_private:function(fbc:P_zend_function; ce:P_zend_class_entry; function_name:Pzend_string):longint; cdecl;
	zend_check_protected:function(ce:P_zend_class_entry; scope:Pzend_class_entry):longint; cdecl;
	zend_check_property_access:function(zobj:P_zend_object; prop_info_name:P_zend_string):longint; cdecl;
	zend_get_call_trampoline_func:function(ce:P_zend_class_entry; method_name:P_zend_string; is_static:longint):P_zend_function; cdecl;
	zend_ast_create_znode:function(node:Pznode):P_zend_ast; cdecl;
	lex_scan:function(zendlval:Pzval):longint; cdecl;
	zend_set_compiled_filename:function(new_compiled_filename:P_zend_string):P_zend_string; cdecl;
	zend_restore_compiled_filename:procedure(original_compiled_filename:P_zend_string); cdecl;
	zend_get_compiled_filename:function:P_zend_string; cdecl;
	zend_get_compiled_lineno:function:longint; cdecl;
	zend_get_scanned_file_offset:function:size_t; cdecl;
	zend_get_compiled_variable_name:function(op_array:P_zend_op_array; _var:Cardinal):P_zend_string; cdecl;
	get_unary_op:function(opcode:longint):unary_op_type; cdecl;
	get_binary_op:function(opcode:longint):binary_op_type; cdecl;
	do_bind_function:function(op_array:P_zend_op_array; opline:P_zend_op; function_table:PHashTable; compile_time:zend_bool):longint; cdecl;
	do_bind_class:function(op_array:P_zend_op_array; opline:P_zend_op; class_table:PHashTable; compile_time:zend_bool):P_zend_class_entry; cdecl;
	do_bind_inherited_class:function(op_array:P_zend_op_array; opline:P_zend_op; class_table:PHashTable; parent_ce:P_zend_class_entry; compile_time:zend_bool):P_zend_class_entry; cdecl;
	zend_do_delayed_early_binding:procedure(op_array:Pzend_op_array); cdecl;
	function_add_ref:procedure(_function:Pzend_function); cdecl;
	compile_file:function(file_handle:Pzend_file_handle; _type:longint):P_zend_op_array; cdecl;
	compile_string:function(source_string:Pzval; filename:zend_pchar):P_zend_op_array; cdecl;
	compile_filename:function(_type:longint; filename:Pzval):P_zend_op_array; cdecl;
	zend_try_exception_handler:procedure; cdecl;
	zend_execute_scripts:function(_type:longint; retval:Pzval; file_count:longint):longint; cdecl varargs;
	open_file_for_scanning:function(file_handle:Pzend_file_handle):longint; cdecl;
	init_op_array:procedure(op_array:P_zend_op_array; _type:zend_uchar; initial_ops_size:longint); cdecl;
	destroy_op_array:procedure(op_array:Pzend_op_array); cdecl;
	zend_destroy_file_handle:procedure(file_handle:Pzend_file_handle); cdecl;
	zend_cleanup_user_class_data:procedure(ce:Pzend_class_entry); cdecl;
	zend_cleanup_internal_class_data:procedure(ce:Pzend_class_entry); cdecl;
	zend_cleanup_internal_classes:procedure; cdecl;
	zend_cleanup_op_array_data:procedure(op_array:Pzend_op_array); cdecl;
	clean_non_persistent_function_full:function(zv:Pzval):longint; cdecl;
	clean_non_persistent_class_full:function(zv:Pzval):longint; cdecl;
	destroy_zend_function:procedure(_function:Pzend_function); cdecl;
	zend_function_dtor:procedure(zv:Pzval); cdecl;
	destroy_zend_class:procedure(zv:Pzval); cdecl;
	zend_mangle_property_name:function(src1:zend_pchar; src1_length:size_t; src2:zend_pchar; src2_length:size_t; internal:longint):P_zend_string; cdecl;
	zend_unmangle_property_name_ex:function(name:Pzend_string; class_name:PPchar; prop_name:PPchar; prop_len:Psize_t):longint; cdecl;
	pass_two:function(op_array:Pzend_op_array):longint; cdecl;
	zend_is_compiling:function:zend_bool; cdecl;
	zend_make_compiled_string_description:function(name:zend_pchar):zend_pchar; cdecl;
	zend_initialize_class_data:procedure(ce:Pzend_class_entry; nullify_handlers:zend_bool); cdecl;
	zend_get_call_op:function(init_op:zend_uchar; fbc:Pzend_function):zend_uchar; cdecl;
	zend_register_auto_global:function(name:Pzend_string; jit:zend_bool; auto_global_callback:zend_auto_global_callback):longint; cdecl;
	zend_activate_auto_globals:procedure; cdecl;
	zend_is_auto_global:function(name:Pzend_string):zend_bool; cdecl;
	zend_is_auto_global_str:function(name:zend_pchar; len:size_t):zend_bool; cdecl;
	zend_dirname:function(path:zend_pchar; len:size_t):size_t; cdecl;
	zend_set_function_arg_flags:procedure(func:Pzend_function); cdecl;
	zend_assert_valid_class_name:procedure(const_name:Pzend_string); cdecl;
	zend_ast_create_zval_ex:function(zv:Pzval; attr:zend_ast_attr):P_zend_ast; cdecl;
	zend_ast_create_ex:function(kind:zend_ast_kind; attr:zend_ast_attr):P_zend_ast; cdecl varargs;
	zend_ast_create:function(kind:zend_ast_kind):P_zend_ast; cdecl varargs;
	zend_ast_create_decl:function(kind:zend_ast_kind; flags:Cardinal; start_lineno:Cardinal; doc_comment:Pzend_string; name:Pzend_string;  child0:Pzend_ast; child1:Pzend_ast; child2:Pzend_ast; child3:Pzend_ast):P_zend_ast; cdecl;
	zend_ast_create_list:function(init_children:Cardinal; kind:zend_ast_kind):P_zend_ast; cdecl varargs;
	zend_ast_list_add:function(list:Pzend_ast; op:Pzend_ast):P_zend_ast; cdecl;
	zend_ast_evaluate:function(result:Pzval; ast:Pzend_ast; scope:Pzend_class_entry):longint; cdecl;
	zend_ast_export:function(prefix:zend_pchar; ast:Pzend_ast; suffix:zend_pchar):P_zend_string; cdecl;
	zend_ast_copy:function(ast:Pzend_ast):P_zend_ast; cdecl;
	zend_ast_destroy:procedure(ast:Pzend_ast); cdecl;
	zend_ast_destroy_and_free:procedure(ast:Pzend_ast); cdecl;
	zend_ast_apply:procedure(ast:Pzend_ast; fn:zend_ast_apply_func); cdecl;
	zend_stream_open:function(filename:zend_pchar; handle:Pzend_file_handle):longint; cdecl;
	zend_stream_fixup:function(file_handle:Pzend_file_handle; buf:PPchar; len:Psize_t):longint; cdecl;
	zend_file_handle_dtor:procedure(fh:Pzend_file_handle); cdecl;
	zend_compare_file_handles:function(fh1:Pzend_file_handle; fh2:Pzend_file_handle):longint; cdecl;
	zend_startup:function(utility_functions:Pzend_utility_functions; extensions:PPchar):longint; cdecl;
	zend_shutdown:procedure; cdecl;
	zend_register_standard_ini_entries:procedure; cdecl;
	zend_post_startup:procedure; cdecl;
	zend_set_utility_values:procedure(utility_values:Pzend_utility_values); cdecl;
	_zend_bailout:procedure(filename:zend_pchar; lineno:uint); cdecl;
	get_zend_version:function:zend_pchar; cdecl;
	zend_make_printable_zval:function(expr:Pzval; expr_copy:Pzval):longint; cdecl;
	zend_print_zval:function(expr:Pzval; indent:longint):size_t; cdecl;
	zend_print_zval_ex:function(write_func:zend_write_func_t; expr:Pzval; indent:longint):size_t; cdecl;
	zend_print_zval_r:procedure(expr:Pzval; indent:longint); cdecl;
	zend_print_flat_zval_r:procedure(expr:Pzval); cdecl;
	zend_print_zval_r_ex:procedure(write_func:zend_write_func_t; expr:Pzval; indent:longint); cdecl;
	zend_output_debug_string:procedure(trigger_break:zend_bool; format:zend_pchar); cdecl varargs;
	zend_activate:procedure; cdecl;
	zend_deactivate:procedure; cdecl;
	zend_call_destructors:procedure; cdecl;
	zend_activate_modules:procedure; cdecl;
	zend_deactivate_modules:procedure; cdecl;
	zend_post_deactivate_modules:procedure; cdecl;
	free_estring:procedure(str_p:PPchar); cdecl;
	zend_error:procedure(_type:longint; format:zend_pchar); cdecl varargs;
	zend_throw_error:procedure(exception_ce:Pzend_class_entry; format:zend_pchar); cdecl varargs;
	zend_type_error:procedure(format:zend_pchar); cdecl varargs;
	zend_internal_type_error:procedure(throw_exception:zend_bool; format:zend_pchar); cdecl varargs;
	zenderror:procedure(error:zend_pchar); cdecl;
	zend_message_dispatcher:procedure(message:zend_long; data:Ppointer); cdecl;
	zend_get_configuration_directive:function(name:Pzend_string):Pzval; cdecl;
	zend_next_free_module:function:longint cdecl;
	zend_get_parameters:function(ht:longint; param_count:longint):longint; cdecl varargs;
	zend_get_parameters_ex:function(param_count:longint):longint; cdecl varargs;
   ZvalGetArgs: function(Count: Integer; Args: ppzval): Integer;cdecl varargs;
	_zend_get_parameters_array_ex:function(param_count:longint; argument_array:Pzval):longint; cdecl;
	zend_copy_parameters_array:function(param_count:longint; argument_array:Pzval):longint; cdecl;
	zend_parse_parameters:function(num_args:longint; type_spec:zend_pchar):longint; cdecl varargs;
	zend_parse_parameters_ex:function(flags:longint; num_args:longint; type_spec:zend_pchar):longint; cdecl varargs;
	zend_parse_parameters_throw:function(num_args:longint; type_spec:zend_pchar):longint; cdecl varargs;
	zend_zval_type_name:function(arg:Pzval):zend_pchar; cdecl;
	zend_parse_method_parameters:function(num_args:longint; this_ptr:Pzval; type_spec:zend_pchar):longint; cdecl varargs;
	zend_parse_method_parameters_ex:function(flags:longint; num_args:longint; this_ptr:Pzval; type_spec:zend_pchar):longint; cdecl varargs;
	zend_parse_parameter:function(flags:longint; arg_num:longint; arg:Pzval; spec:zend_pchar):longint; cdecl varargs;
	zend_register_functions:function(scope:Pzend_class_entry; functions:Pzend_function_entry; function_table:PHashTable; _type:longint):longint; cdecl;
	zend_unregister_functions:procedure(functions:Pzend_function_entry; count:longint; function_table:PHashTable); cdecl;
	zend_startup_module:function(module_entry:Pzend_module_entry):longint; cdecl;
	zend_register_internal_module:function(module_entry:Pzend_module_entry):P_zend_module_entry; cdecl;
	zend_register_module_ex:function(module:Pzend_module_entry):P_zend_module_entry; cdecl;
	zend_startup_module_ex:function(module:Pzend_module_entry):longint; cdecl;
	zend_startup_modules:function:longint cdecl;
	zend_check_magic_method_implementation:procedure(ce:Pzend_class_entry; fptr:Pzend_function; error_type:longint); cdecl;
	zend_register_internal_class:function(class_entry:Pzend_class_entry):P_zend_class_entry; cdecl;
	zend_register_internal_class_ex:function(class_entry:Pzend_class_entry; parent_ce:Pzend_class_entry):P_zend_class_entry; cdecl;
	zend_register_internal_interface:function(orig_class_entry:Pzend_class_entry):P_zend_class_entry; cdecl;
	zend_class_implements:procedure(class_entry:Pzend_class_entry; num_interfaces:longint); cdecl varargs;
	zend_register_class_alias_ex:function(name:zend_pchar; name_len:size_t; ce:Pzend_class_entry):longint; cdecl;
	zend_disable_function:function(function_name:zend_pchar; function_name_length:size_t):longint; cdecl;
	zend_disable_class:function(class_name:zend_pchar; class_name_length:size_t):longint; cdecl;
	zend_is_callable_ex:function(callable:Pzval; _object:Pzend_object; check_flags:uint; callable_name:PP_zend_string; fcc:Pzend_fcall_info_cache; error:PPchar):zend_bool; cdecl;
	zend_is_callable:function(callable:Pzval; check_flags:uint; callable_name:PP_zend_string):zend_bool; cdecl;
	zend_make_callable:function(callable:Pzval; callable_name:PP_zend_string):zend_bool; cdecl;
	zend_get_module_version:function(module_name:zend_pchar):zend_pchar; cdecl;
	zend_get_module_started:function(module_name:zend_pchar):longint; cdecl;
	zend_declare_property_ex:function(ce:Pzend_class_entry; name:Pzend_string; _property:Pzval; access_type:longint; doc_comment:Pzend_string):longint; cdecl;
	zend_declare_property:function(ce:Pzend_class_entry; name:zend_pchar; name_length:size_t; _property:Pzval; access_type:longint):longint; cdecl;
	zend_declare_property_null:function(ce:Pzend_class_entry; name:zend_pchar; name_length:size_t; access_type:longint):longint; cdecl;
	zend_declare_property_bool:function(ce:Pzend_class_entry; name:zend_pchar; name_length:size_t; value:zend_long; access_type:longint):longint; cdecl;
	zend_declare_property_long:function(ce:Pzend_class_entry; name:zend_pchar; name_length:size_t; value:zend_long; access_type:longint):longint; cdecl;
	zend_declare_property_double:function(ce:Pzend_class_entry; name:zend_pchar; name_length:size_t; value:double; access_type:longint):longint; cdecl;
	zend_declare_property_string:function(ce:Pzend_class_entry; name:zend_pchar; name_length:size_t; value:zend_pchar; access_type:longint):longint; cdecl;
	zend_declare_property_stringl:function(ce:Pzend_class_entry; name:zend_pchar; name_length:size_t; value:zend_pchar; value_len:size_t; access_type:longint):longint; cdecl;
	zend_declare_class_constant:function(ce:Pzend_class_entry; name:zend_pchar; name_length:size_t; value:Pzval):longint; cdecl;
	zend_declare_class_constant_null:function(ce:Pzend_class_entry; name:zend_pchar; name_length:size_t):longint; cdecl;
	zend_declare_class_constant_long:function(ce:Pzend_class_entry; name:zend_pchar; name_length:size_t; value:zend_long):longint; cdecl;
	zend_declare_class_constant_bool:function(ce:Pzend_class_entry; name:zend_pchar; name_length:size_t; value:zend_bool):longint; cdecl;
	zend_declare_class_constant_double:function(ce:Pzend_class_entry; name:zend_pchar; name_length:size_t; value:double):longint; cdecl;
	zend_declare_class_constant_stringl:function(ce:Pzend_class_entry; name:zend_pchar; name_length:size_t; value:zend_pchar; value_length:size_t):longint; cdecl;
	zend_declare_class_constant_string:function(ce:Pzend_class_entry; name:zend_pchar; name_length:size_t; value:zend_pchar):longint; cdecl;
	zend_update_class_constants:function(class_type:Pzend_class_entry):longint; cdecl;
	zend_update_property_ex:procedure(scope:Pzend_class_entry; _object:Pzval; name:Pzend_string; value:Pzval); cdecl;
	zend_update_property:procedure(scope:Pzend_class_entry; _object:Pzval; name:zend_pchar; name_length:size_t; value:Pzval); cdecl;
	zend_update_property_null:procedure(scope:Pzend_class_entry; _object:Pzval; name:zend_pchar; name_length:size_t); cdecl;
	zend_update_property_bool:procedure(scope:Pzend_class_entry; _object:Pzval; name:zend_pchar; name_length:size_t; value:zend_long); cdecl;
	zend_update_property_long:procedure(scope:Pzend_class_entry; _object:Pzval; name:zend_pchar; name_length:size_t; value:zend_long); cdecl;
	zend_update_property_double:procedure(scope:Pzend_class_entry; _object:Pzval; name:zend_pchar; name_length:size_t; value:double); cdecl;
	zend_update_property_str:procedure(scope:Pzend_class_entry; _object:Pzval; name:zend_pchar; name_length:size_t; value:Pzend_string); cdecl;
	zend_update_property_string:procedure(scope:Pzend_class_entry; _object:Pzval; name:zend_pchar; name_length:size_t; value:zend_pchar); cdecl;
	zend_update_property_stringl:procedure(scope:Pzend_class_entry; _object:Pzval; name:zend_pchar; name_length:size_t; value:zend_pchar; value_length:size_t); cdecl;
	zend_update_static_property:function(scope:Pzend_class_entry; name:zend_pchar; name_length:size_t; value:Pzval):longint; cdecl;
	zend_update_static_property_null:function(scope:Pzend_class_entry; name:zend_pchar; name_length:size_t):longint; cdecl;
	zend_update_static_property_bool:function(scope:Pzend_class_entry; name:zend_pchar; name_length:size_t; value:zend_long):longint; cdecl;
	zend_update_static_property_long:function(scope:Pzend_class_entry; name:zend_pchar; name_length:size_t; value:zend_long):longint; cdecl;
	zend_update_static_property_double:function(scope:Pzend_class_entry; name:zend_pchar; name_length:size_t; value:double):longint; cdecl;
	zend_update_static_property_string:function(scope:Pzend_class_entry; name:zend_pchar; name_length:size_t; value:zend_pchar):longint; cdecl;
	zend_update_static_property_stringl:function(scope:Pzend_class_entry; name:zend_pchar; name_length:size_t; value:zend_pchar; value_length:size_t):longint; cdecl;
	zend_read_property:function(scope:Pzend_class_entry; _object:Pzval; name:zend_pchar; name_length:size_t; silent:zend_bool; rv:Pzval):Pzval; cdecl;
	zend_read_static_property:function(scope:Pzend_class_entry; name:zend_pchar; name_length:size_t; silent:zend_bool):Pzval; cdecl;
	zend_get_type_by_const:function(_type:longint):zend_pchar; cdecl;
	_array_init:function(arg:Pzval; size:Cardinal):longint; cdecl;
	_object_init:function(arg:Pzval; __zend_filename:zend_pchar; __zend_lineno:uint):longint; cdecl;
	_object_init_ex:function(arg:Pzval; ce:Pzend_class_entry; __zend_filename:zend_pchar; __zend_lineno:uint):longint; cdecl;
	_object_and_properties_init:function(arg:Pzval; ce:Pzend_class_entry; properties:PHashTable; __zend_filename:zend_pchar; __zend_lineno:uint):longint; cdecl;
	object_properties_init:procedure(_object:Pzend_object; class_type:Pzend_class_entry); cdecl;
	object_properties_init_ex:procedure(_object:Pzend_object; properties:PHashTable); cdecl;
	object_properties_load:procedure(_object:Pzend_object; properties:PHashTable); cdecl;
	zend_merge_properties:procedure(obj:Pzval; properties:PHashTable); cdecl;
	add_assoc_long_ex:function(arg:Pzval; key:zend_pchar; key_len:size_t; n:zend_long):longint; cdecl;
	add_assoc_null_ex:function(arg:Pzval; key:zend_pchar; key_len:size_t):longint; cdecl;
	add_assoc_bool_ex:function(arg:Pzval; key:zend_pchar; key_len:size_t; b:longint):longint; cdecl;
	add_assoc_resource_ex:function(arg:Pzval; key:zend_pchar; key_len:size_t; r:Pzend_resource):longint; cdecl;
	add_assoc_double_ex:function(arg:Pzval; key:zend_pchar; key_len:size_t; d:double):longint; cdecl;
	add_assoc_str_ex:function(arg:Pzval; key:zend_pchar; key_len:size_t; str:Pzend_string):longint; cdecl;
	add_assoc_string_ex:function(arg:Pzval; key:zend_pchar; key_len:size_t; str:zend_pchar):longint; cdecl;
	add_assoc_stringl_ex:function(arg:Pzval; key:zend_pchar; key_len:size_t; str:zend_pchar; length:size_t):longint; cdecl;
	add_assoc_zval_ex:function(arg:Pzval; key:zend_pchar; key_len:size_t; value:Pzval):longint; cdecl;
	add_index_long:function(arg:Pzval; idx:zend_ulong; n:zend_long):longint; cdecl;
	add_index_null:function(arg:Pzval; idx:zend_ulong):longint; cdecl;
	add_index_bool:function(arg:Pzval; idx:zend_ulong; b:longint):longint; cdecl;
	add_index_resource:function(arg:Pzval; idx:zend_ulong; r:Pzend_resource):longint; cdecl;
	add_index_double:function(arg:Pzval; idx:zend_ulong; d:double):longint; cdecl;
	add_index_str:function(arg:Pzval; idx:zend_ulong; str:Pzend_string):longint; cdecl;
	add_index_string:function(arg:Pzval; idx:zend_ulong; str:zend_pchar):longint; cdecl;
	add_index_stringl:function(arg:Pzval; idx:zend_ulong; str:zend_pchar; length:size_t):longint; cdecl;
	add_index_zval:function(arg:Pzval; index:zend_ulong; value:Pzval):longint; cdecl;
	add_next_index_long:function(arg:Pzval; n:zend_long):longint; cdecl;
	add_next_index_null:function(arg:Pzval):longint; cdecl;
	add_next_index_bool:function(arg:Pzval; b:longint):longint; cdecl;
	add_next_index_resource:function(arg:Pzval; r:Pzend_resource):longint; cdecl;
	add_next_index_double:function(arg:Pzval; d:double):longint; cdecl;
	add_next_index_str:function(arg:Pzval; str:Pzend_string):longint; cdecl;
	add_next_index_string:function(arg:Pzval; str:zend_pchar):longint; cdecl;
	add_next_index_stringl:function(arg:Pzval; str:zend_pchar; length:size_t):longint; cdecl;
	add_next_index_zval:function(arg:Pzval; value:Pzval):longint; cdecl;
	add_get_assoc_string_ex:function(arg:Pzval; key:zend_pchar; key_len:uint; str:zend_pchar):Pzval; cdecl;
	add_get_assoc_stringl_ex:function(arg:Pzval; key:zend_pchar; key_len:uint; str:zend_pchar; length:size_t):Pzval; cdecl;
	add_get_index_long:function(arg:Pzval; idx:zend_ulong; l:zend_long):Pzval; cdecl;
	add_get_index_double:function(arg:Pzval; idx:zend_ulong; d:double):Pzval; cdecl;
	add_get_index_str:function(arg:Pzval; index:zend_ulong; str:Pzend_string):Pzval; cdecl;
	add_get_index_string:function(arg:Pzval; idx:zend_ulong; str:zend_pchar):Pzval; cdecl;
	add_get_index_stringl:function(arg:Pzval; idx:zend_ulong; str:zend_pchar; length:size_t):Pzval; cdecl;
	array_set_zval_key:function(ht:PHashTable; key:Pzval; value:Pzval):longint; cdecl;
	add_property_long_ex:function(arg:Pzval; key:zend_pchar; key_len:size_t; l:zend_long):longint; cdecl;
	add_property_null_ex:function(arg:Pzval; key:zend_pchar; key_len:size_t):longint; cdecl;
	add_property_bool_ex:function(arg:Pzval; key:zend_pchar; key_len:size_t; b:zend_long):longint; cdecl;
	add_property_resource_ex:function(arg:Pzval; key:zend_pchar; key_len:size_t; r:Pzend_resource):longint; cdecl;
	add_property_double_ex:function(arg:Pzval; key:zend_pchar; key_len:size_t; d:double):longint; cdecl;
	add_property_str_ex:function(arg:Pzval; key:zend_pchar; key_len:size_t; str:Pzend_string):longint; cdecl;
	add_property_string_ex:function(arg:Pzval; key:zend_pchar; key_len:size_t; str:zend_pchar):longint; cdecl;
	add_property_stringl_ex:function(arg:Pzval; key:zend_pchar; key_len:size_t; str:zend_pchar; length:size_t):longint; cdecl;
	add_property_zval_ex:function(arg:Pzval; key:zend_pchar; key_len:size_t; value:Pzval):longint; cdecl;
	call_user_function:function(function_table:PHashTable; _object:Pzval; function_name:Pzval; retval_ptr:Pzval; param_count:Cardinal; params:Pzval):longint; cdecl;
	call_user_function_ex:function(function_table:PHashTable; _object:Pzval; function_name:Pzval; retval_ptr:Pzval; param_count:Cardinal;  params:Pzval; no_separation:longint; symbol_table:Pzend_array):longint; cdecl;
	zend_fcall_info_init:function(callable:Pzval; check_flags:uint; fci:Pzend_fcall_info; fcc:Pzend_fcall_info_cache; callable_name:PP_zend_string;  error:PPchar):longint; cdecl;
	zend_fcall_info_args_clear:procedure(fci:Pzend_fcall_info; free_mem:longint); cdecl;
	zend_fcall_info_args_save:procedure(fci:Pzend_fcall_info; param_count:Plongint; params:PPzval); cdecl;
	zend_fcall_info_args_restore:procedure(fci:Pzend_fcall_info; param_count:longint; params:Pzval); cdecl;
	zend_fcall_info_args:function(fci:Pzend_fcall_info; args:Pzval):longint; cdecl;
	zend_fcall_info_args_ex:function(fci:Pzend_fcall_info; func:Pzend_function; args:Pzval):longint; cdecl;
	zend_fcall_info_argp:function(fci:Pzend_fcall_info; argc:longint; argv:Pzval):longint; cdecl;
	zend_fcall_info_argv:function(fci:Pzend_fcall_info; argc:longint; argv:pPChar):longint; cdecl;
	zend_fcall_info_argn:function(fci:Pzend_fcall_info; argc:longint):longint; cdecl varargs;
	zend_fcall_info_call:function(fci:Pzend_fcall_info; fcc:Pzend_fcall_info_cache; retval:Pzval; args:Pzval):longint; cdecl;
	zend_call_function:function(fci:Pzend_fcall_info; fci_cache:Pzend_fcall_info_cache):longint; cdecl;
	zend_set_hash_symbol:function(symbol:Pzval; name:zend_pchar; name_length:longint; is_ref:zend_bool; num_symbol_tables:longint;  args:array of const):longint; cdecl;
	zend_delete_global_variable:function(name:Pzend_string):longint; cdecl;
	zend_rebuild_symbol_table:function:P_zend_array cdecl;
	zend_attach_symbol_table:procedure(execute_data:P_zend_execute_data); cdecl;
	zend_detach_symbol_table:procedure(execute_data:P_zend_execute_data); cdecl;
	zend_set_local_var:function(name:Pzend_string; value:Pzval; force:longint):longint; cdecl;
	zend_set_local_var_str:function(name:zend_pchar; len:size_t; value:Pzval; force:longint):longint; cdecl;
	zend_find_alias_name:function(ce:Pzend_class_entry; name:Pzend_string):P_zend_string; cdecl;
	zend_resolve_method_name:function(ce:Pzend_class_entry; f:Pzend_function):P_zend_string; cdecl;
	zend_get_object_type:function(ce:Pzend_class_entry):zend_pchar; cdecl;
	zend_wrong_paramers_count_error:procedure(num_args:longint; min_num_args:longint; max_num_args:longint); cdecl;
	zend_wrong_paramer_type_error:procedure(num:longint; expected_type:Ppointer; arg:Pzval); cdecl;
	zend_wrong_paramer_class_error:procedure(num:longint; name:zend_pchar; arg:Pzval); cdecl;
	zend_wrong_callback_error:procedure(severity:longint; num:longint; error:zend_pchar); cdecl;
	zend_parse_arg_class:function(arg:Pzval; pce:PP_zend_class_entry; num:longint; check_null:longint):longint; cdecl;
	zend_parse_arg_bool_slow:function(arg:Pzval; dest:Pzend_bool):longint; cdecl;
	zend_parse_arg_bool_weak:function(arg:Pzval; dest:Pzend_bool):longint; cdecl;
	zend_parse_arg_long_slow:function(arg:Pzval; dest:Pzend_long):longint; cdecl;
	zend_parse_arg_long_weak:function(arg:Pzval; dest:Pzend_long):longint; cdecl;
	zend_parse_arg_long_cap_slow:function(arg:Pzval; dest:Pzend_long):longint; cdecl;
	zend_parse_arg_long_cap_weak:function(arg:Pzval; dest:Pzend_long):longint; cdecl;
	zend_parse_arg_double_slow:function(arg:Pzval; dest:Pdouble):longint; cdecl;
	zend_parse_arg_double_weak:function(arg:Pzval; dest:Pdouble):longint; cdecl;
	zend_parse_arg_str_slow:function(arg:Pzval; dest:PP_zend_string):longint; cdecl;
	zend_parse_arg_str_weak:function(arg:Pzval; dest:PP_zend_string):longint; cdecl;
	module_destructor:procedure(module:Pzend_module_entry); cdecl;
	module_registry_request_startup:function(module:Pzend_module_entry):longint; cdecl;
	module_registry_unload_temp:function(module:Pzend_module_entry):longint; cdecl;


  sapi_startup:procedure( sf:p_sapi_module_struct); cdecl;
  sapi_shutdown:procedure; cdecl;
  sapi_activate:procedure; cdecl;
  sapi_deactivate:procedure; cdecl;
  sapi_initialize_empty_request:procedure; cdecl;
  sapi_header_op:function(op:sapi_header_op_enum; arg:Ppointer):longint; cdecl;
  sapi_add_header_ex:function(header_line:zend_pchar; header_line_len:size_t; duplicate:zend_bool; replace:zend_bool):longint; cdecl;
  sapi_send_headers:function:longint; cdecl;
  sapi_free_header:procedure(sapi_header:Psapi_header_struct); cdecl;
  sapi_handle_post:procedure(arg:Ppointer); cdecl;
  sapi_read_post_block:function(buffer:zend_pchar; buflen:size_t):size_t; cdecl;
  sapi_register_post_entries:function(post_entry:Psapi_post_entry):longint; cdecl;
  sapi_register_post_entry:function(post_entry:Psapi_post_entry):longint; cdecl;
  sapi_unregister_post_entry:procedure(post_entry:Psapi_post_entry); cdecl;
  sapi_register_default_post_reader:pointer;
  sapi_register_treat_data:function(treat_data:pointer):longint;
  sapi_register_input_filter:function(input_filter:pointer; input_filter_init:pointer):longint; 
  sapi_flush:function:longint; cdecl;
  sapi_get_stat:function:P_zend_stat_t; cdecl;
  sapi_getenv:function(name:zend_pchar; name_len:size_t):zend_pchar; cdecl;
  sapi_get_default_content_type:function:zend_pchar; cdecl;
  sapi_get_default_content_type_header:procedure(default_header:Psapi_header_struct); cdecl;
  sapi_apply_default_charset:function(mimetype:PPchar; len:size_t):size_t; cdecl;
  sapi_activate_headers_only:procedure; cdecl;
  sapi_get_fd:function(fd:Plongint):longint; cdecl;
  sapi_force_http_10:function:longint; cdecl;
  sapi_get_target_uid:function(_para1:Puid_t):longint; cdecl;
  sapi_get_target_gid:function(_para1:Pgid_t):longint; cdecl;
  sapi_get_request_time:function:double; cdecl;
  sapi_terminate_process:procedure; cdecl;
_php_stream_alloc:function(ops:Pphp_stream_ops; _abstract:Ppointer; persistent_id:zend_pchar; mode:zend_pchar; __php_stream_call_depth:longint; __zend_filename:zend_pchar; __zend_lineno:uint; __zend_orig_filename:zend_pchar; __zend_orig_lineno:uint):P_php_stream; cdecl;
_php_stream_tell:function(stream:Pphp_stream):zend_off_t; cdecl;
_php_stream_read:function(stream:Pphp_stream; buf:zend_pchar; count:size_t):size_t; cdecl;
_php_stream_write:function(stream:Pphp_stream; buf:zend_pchar; count:size_t):size_t; cdecl;
_php_stream_fill_read_buffer:procedure(stream:Pphp_stream; size:size_t); cdecl;
_php_stream_printf:function(stream:Pphp_stream; fmt:zend_pchar):size_t; cdecl varargs;
_php_stream_eof:function(stream:Pphp_stream):longint; cdecl;
_php_stream_seek:function(stream:Pphp_stream; offset:zend_off_t; whence:longint):longint; cdecl;
_php_stream_free:function(stream:Pphp_stream; close_options:longint):longint; cdecl;
php_stream_encloses:function(enclosing:Pphp_stream; enclosed:Pphp_stream):P_php_stream; cdecl;
_php_stream_free_enclosed:function(stream_enclosed:Pphp_stream; close_options:longint):longint; cdecl;
php_stream_from_persistent_id:function(persistent_id:zend_pchar; stream:PP_php_stream):longint; cdecl;
php_file_le_stream:function:longint; cdecl;
php_file_le_pstream:function:longint; cdecl;
php_file_le_stream_filter:function:longint; cdecl;
_php_stream_getc:function(stream:Pphp_stream):longint; cdecl;
_php_stream_putc:function(stream:Pphp_stream; c:longint):longint; cdecl;
_php_stream_flush:function(stream:Pphp_stream; closing:longint):longint; cdecl;
_php_stream_get_line:function(stream:Pphp_stream; buf:zend_pchar; maxlen:size_t; returned_len:Psize_t):zend_pchar; cdecl;
_php_stream_get_url_stream_wrappers_hash:function:PHashTable; cdecl;
php_stream_get_url_stream_wrappers_hash_global:function:PHashTable; cdecl;
_php_get_stream_filters_hash:function:PHashTable; cdecl;
php_get_stream_filters_hash_global:function:PHashTable; cdecl;
_php_stream_truncate_set_size:function(stream:Pphp_stream; newsize:size_t):longint; cdecl;
_php_stream_make_seekable:function(origstream:Pphp_stream; newstream:PP_php_stream; flags:longint; __php_stream_call_depth:longint; __zend_filename:zend_pchar; __zend_lineno:uint; __zend_orig_filename:zend_pchar; __zend_orig_lineno:uint):longint; cdecl;
_php_stream_copy_to_stream:function(src:Pphp_stream; dest:Pphp_stream; maxlen:size_t; __php_stream_call_depth:longint; __zend_filename:zend_pchar; __zend_lineno:uint; __zend_orig_filename:zend_pchar; __zend_orig_lineno:uint):size_t; cdecl;
_php_stream_copy_to_mem:function(src:Pphp_stream; maxlen:size_t; persistent:longint; __php_stream_call_depth:longint; __zend_filename:zend_pchar; __zend_lineno:uint; __zend_orig_filename:zend_pchar; __zend_orig_lineno:uint):P_zend_string; cdecl;
_php_stream_copy_to_stream_ex:function(src:Pphp_stream; dest:Pphp_stream; maxlen:size_t; len:Psize_t; __php_stream_call_depth:longint; __zend_filename:zend_pchar; __zend_lineno:uint; __zend_orig_filename:zend_pchar; __zend_orig_lineno:uint):longint; cdecl;
_php_stream_passthru:function(src:Pphp_stream; __php_stream_call_depth:longint; __zend_filename:zend_pchar; __zend_lineno:uint; __zend_orig_filename:zend_pchar;  __zend_orig_lineno:uint):size_t; cdecl;
_php_stream_cast:function(stream:Pphp_stream; castas:longint; ret:Ppointer; show_err:longint):longint; cdecl;
php_register_url_stream_wrapper:function(protocol:zend_pchar; wrapper:Pphp_stream_wrapper):longint; cdecl;
php_unregister_url_stream_wrapper:function(protocol:zend_pchar):longint; cdecl;
php_register_url_stream_wrapper_volatile:function(protocol:zend_pchar; wrapper:Pphp_stream_wrapper):longint; cdecl;
php_unregister_url_stream_wrapper_volatile:function(protocol:zend_pchar):longint; cdecl;
_php_stream_open_wrapper_ex:function(path:zend_pchar; mode:zend_pchar; options:longint; opened_path:PP_zend_string; context:Pphp_stream_context;  __php_stream_call_depth:longint; __zend_filename:zend_pchar; __zend_lineno:uint; __zend_orig_filename:zend_pchar; __zend_orig_lineno:uint):P_php_stream; cdecl;
php_stream_locate_url_wrapper:function(path:zend_pchar; path_for_open:PPchar; options:longint):P_php_stream_wrapper; cdecl;
php_stream_locate_eol:function(stream:Pphp_stream; buf:Pzend_string):zend_pchar; cdecl;
php_stream_get_record:function(stream:Pphp_stream; maxlen:size_t; delim:zend_pchar; delim_len:size_t):P_zend_string; cdecl;
php_stream_wrapper_log_error:procedure(wrapper:Pphp_stream_wrapper; options:longint; fmt:zend_pchar); cdecl varargs;
_php_stream_puts:function(stream:Pphp_stream; buf:zend_pchar):longint; cdecl;
_php_stream_stat:function(stream:Pphp_stream; ssb:Pphp_stream_statbuf):longint; cdecl;
_php_stream_stat_path:function(path:zend_pchar; flags:longint; ssb:Pphp_stream_statbuf; context:Pphp_stream_context):longint; cdecl;
_php_stream_mkdir:function(path:zend_pchar; mode:longint; options:longint; context:Pphp_stream_context):longint; cdecl;
_php_stream_rmdir:function(path:zend_pchar; options:longint; context:Pphp_stream_context):longint; cdecl;
_php_stream_opendir:function(path:zend_pchar; options:longint; context:Pphp_stream_context; __php_stream_call_depth:longint; __zend_filename:zend_pchar;  __zend_lineno:uint; __zend_orig_filename:zend_pchar; __zend_orig_lineno:uint):P_php_stream; cdecl;
_php_stream_readdir:function(dirstream:Pphp_stream; ent:Pphp_stream_dirent):Pphp_stream_dirent; cdecl;
php_stream_dirent_alphasort:function(a:PP_zend_string; b:PP_zend_string):longint; cdecl;
php_stream_dirent_alphasortr:function(a:PP_zend_string; b:PP_zend_string):longint; cdecl;
 _php_stream_scandir:function(dirname:zend_pchar; namelist:PPP_zend_string; flags:longint; context:Pphp_stream_context; compare:pointer):longint;
_php_stream_set_option:function(stream:Pphp_stream; option:longint; value:longint; ptrparam:Ppointer):longint; cdecl;
php_stream_context_free:procedure(context:Pphp_stream_context); cdecl;
php_stream_context_alloc:function:P_php_stream_context; cdecl;
php_stream_context_get_option:function(context:Pphp_stream_context; wrappername:zend_pchar; optionname:zend_pchar):Pzval; cdecl;
php_stream_context_set_option:function(context:Pphp_stream_context; wrappername:zend_pchar; optionname:zend_pchar; optionvalue:Pzval):longint; cdecl;
php_stream_notification_alloc:function:P_php_stream_notifier; cdecl;
php_stream_notification_free:procedure(notifier:P_php_stream_notifier); cdecl;
php_stream_notification_notify:procedure(context:Pphp_stream_context; notifycode:longint; severity:longint; xmsg:zend_pchar; xcode:longint;
bytes_sofar:size_t; bytes_max:size_t; ptr:Ppointer);
php_stream_context_set:function(stream:Pphp_stream; context:Pphp_stream_context):P_php_stream_context; cdecl;
zend_llist_init:procedure(l:Pzend_llist; size:size_t; dtor:llist_dtor_func_t; persistent:byte); cdecl;
zend_llist_add_element:procedure(l:Pzend_llist; element:Ppointer); cdecl;
zend_llist_prepend_element:procedure(l:Pzend_llist; element:Ppointer); cdecl;
zend_llist_del_element:procedure(l:Pzend_llist; element:Ppointer; compare:ERGERG43T4T545YH546);
zend_llist_destroy:procedure(l:Pzend_llist); cdecl;
zend_llist_clean:procedure(l:Pzend_llist); cdecl;
zend_llist_remove_tail:procedure(l:Pzend_llist); cdecl;
zend_llist_copy:procedure(dst:Pzend_llist; src:Pzend_llist); cdecl;
zend_llist_apply:procedure(l:Pzend_llist; func:llist_apply_func_t); cdecl;
zend_llist_apply_with_del:procedure(l:Pzend_llist; func:RGEKG34I9TI3434); cdecl;
zend_llist_apply_with_argument:procedure(l:Pzend_llist; func:llist_apply_with_arg_func_t; arg:Ppointer); cdecl;
zend_llist_apply_with_arguments:procedure(l:Pzend_llist; func:llist_apply_with_args_func_t; num_args:longint); cdecl varargs;
zend_llist_count:function(l:Pzend_llist):size_t; cdecl;
zend_llist_sort:procedure(l:Pzend_llist; comp_func:llist_compare_func_t); cdecl;
zend_llist_get_first_ex:function(l:Pzend_llist; pos:Pzend_llist_position):pointer; cdecl;
zend_llist_get_last_ex:function(l:Pzend_llist; pos:Pzend_llist_position):pointer; cdecl;
zend_llist_get_next_ex:function(l:Pzend_llist; pos:Pzend_llist_position):pointer; cdecl;
zend_llist_get_prev_ex:function(l:Pzend_llist; pos:Pzend_llist_position):pointer; cdecl;
php_stream_filter_register_factory:function(filterpattern:zend_pchar; factory:Pphp_stream_filter_factory):longint; cdecl;
php_stream_filter_unregister_factory:function(filterpattern:zend_pchar):longint; cdecl;
php_stream_filter_register_factory_volatile:function(filterpattern:zend_pchar; factory:Pphp_stream_filter_factory):longint; cdecl;
php_stream_filter_create:function(filtername:zend_pchar; filterparams:Pzval; persistent:longint):P_php_stream_filter; cdecl;
_php_stream_filter_prepend:procedure(chain:Pphp_stream_filter_chain; filter:Pphp_stream_filter); cdecl;
php_stream_filter_prepend_ex:function(chain:Pphp_stream_filter_chain; filter:Pphp_stream_filter):longint; cdecl;
_php_stream_filter_append:procedure(chain:Pphp_stream_filter_chain; filter:Pphp_stream_filter); cdecl;
php_stream_filter_append_ex:function(chain:Pphp_stream_filter_chain; filter:Pphp_stream_filter):longint; cdecl;
_php_stream_filter_flush:function(filter:Pphp_stream_filter; finish:longint):longint; cdecl;
php_stream_filter_remove:function(filter:Pphp_stream_filter; call_dtor:longint):P_php_stream_filter; cdecl;
php_stream_filter_free:procedure(filter:Pphp_stream_filter); cdecl;
_php_stream_filter_alloc:function(fops:Pphp_stream_filter_ops; _abstract:Ppointer; persistent:longint; __php_stream_call_depth:longint; __zend_filename:zend_pchar; __zend_lineno:uint; __zend_orig_filename:zend_pchar; __zend_orig_lineno:uint):P_php_stream_filter; cdecl;
php_stream_bucket_new:function(stream:Pphp_stream; buf:zend_pchar; buflen:size_t; own_buf:longint; buf_persistent:longint):P_php_stream_bucket; cdecl;
php_stream_bucket_split:function(_in:Pphp_stream_bucket; left:PP_php_stream_bucket; right:PP_php_stream_bucket; length:size_t):longint; cdecl;
php_stream_bucket_delref:procedure(bucket:Pphp_stream_bucket); cdecl;
php_stream_bucket_prepend:procedure(brigade:Pphp_stream_bucket_brigade; bucket:Pphp_stream_bucket); cdecl;
php_stream_bucket_append:procedure(brigade:Pphp_stream_bucket_brigade; bucket:Pphp_stream_bucket); cdecl;
php_stream_bucket_unlink:procedure(bucket:Pphp_stream_bucket); cdecl;
php_stream_bucket_make_writeable:function(bucket:Pphp_stream_bucket):P_php_stream_bucket; cdecl;
zend_init_execute_data:procedure(execute_data:Pzend_execute_data; op_array:Pzend_op_array; return_value:Pzval); cdecl;
zend_create_generator_execute_data:function(call:Pzend_execute_data; op_array:Pzend_op_array; return_value:Pzval):P_zend_execute_data; cdecl;
zend_execute:procedure(op_array:Pzend_op_array; return_value:Pzval); cdecl;
execute_ex:procedure(execute_data:Pzend_execute_data); cdecl;
execute_internal:procedure(execute_data:Pzend_execute_data; return_value:Pzval); cdecl;
zend_lookup_class:function(name:Pzend_string):P_zend_class_entry; cdecl;
zend_lookup_class_ex:function(name:Pzend_string; key:Pzval; use_autoload:longint):P_zend_class_entry; cdecl;
zend_get_called_scope:function(ex:Pzend_execute_data):P_zend_class_entry; cdecl;
zend_get_this_object:function(ex:Pzend_execute_data):P_zend_object; cdecl;
zend_eval_string:function(str:zend_pchar; retval_ptr:Pzval; string_name:zend_pchar):longint; cdecl;
zend_eval_stringl:function(str:zend_pchar; str_len:size_t; retval_ptr:Pzval; string_name:zend_pchar):longint; cdecl;
zend_eval_string_ex:function(str:zend_pchar;  retval_ptr:pzval; string_name:zend_pchar; handle_exceptions:longint):longint; cdecl;
zend_eval_stringl_ex:function(str:zend_pchar; str_len:size_t; retval_ptr:Pzval; string_name:zend_pchar; handle_exceptions:longint):longint; cdecl;
zval_update_constant:function(pp:Pzval; inline_change:zend_bool):longint; cdecl;
zval_update_constant_ex:function(pp:Pzval; inline_change:zend_bool; scope:Pzend_class_entry):longint; cdecl;
zend_vm_stack_init:procedure; cdecl;
zend_vm_stack_destroy:procedure; cdecl;
zend_vm_stack_extend:function(size:size_t):pointer; cdecl;
get_active_class_name:function(space:PPchar):zend_pchar; cdecl;
get_active_function_name:function:zend_pchar; cdecl;
zend_get_executed_filename:function:zend_pchar; cdecl;
zend_get_executed_filename_ex:function:P_zend_string; cdecl;
zend_get_executed_lineno:function:uint; cdecl;
zend_is_executing:function:zend_bool; cdecl;
zend_set_timeout:procedure(seconds:zend_long; reset_signals:longint); cdecl;
zend_unset_timeout:procedure; cdecl;
zend_timeout:procedure(dummy:longint); cdecl;
zend_fetch_class:function(class_name:Pzend_string; fetch_type:longint):P_zend_class_entry; cdecl;
zend_fetch_class_by_name:function(class_name:Pzend_string; key:Pzval; fetch_type:longint):P_zend_class_entry; cdecl;
zend_fetch_dimension_by_zval:procedure(result:Pzval; container:Pzval; dim:Pzval); cdecl;
zend_fetch_dimension_by_zval_is:procedure(result:Pzval; container:Pzval; dim:Pzval; dim_type:longint); cdecl;
EX_VAR:function(execute_data_ptr:Pzend_execute_data; _var:uint32_t):Pzval; cdecl;
zend_set_user_opcode_handler:function(opcode:zend_uchar; handler:user_opcode_handler_t):longint; cdecl;
zend_get_user_opcode_handler:function(opcode:zend_uchar):user_opcode_handler_t; cdecl;
zend_get_zval_ptr:function(op_type:longint; node:Pznode_op; execute_data:Pzend_execute_data; should_free:Pzend_free_op; _type:longint):Pzval; cdecl;
zend_clean_and_cache_symbol_table:procedure(symbol_table:Pzend_array); cdecl;
zend_objects_store_init:procedure(objects:Pzend_objects_store; init_size:uint32_t); cdecl;
zend_objects_store_call_destructors:procedure(objects:Pzend_objects_store); cdecl;
zend_objects_store_mark_destructed:procedure(objects:Pzend_objects_store); cdecl;
zend_objects_store_destroy:procedure(objects:Pzend_objects_store); cdecl;
zend_objects_store_put:procedure(_object:Pzend_object); cdecl;
zend_objects_store_del:procedure(_object:Pzend_object); cdecl;
zend_objects_store_free:procedure(_object:Pzend_object); cdecl;
zend_object_store_set_object:procedure(zobject:Pzval; _object:Pzend_object); cdecl;
zend_object_store_ctor_failed:procedure(_object:Pzend_object); cdecl;
zend_objects_store_free_object_storage:procedure(objects:Pzend_objects_store); cdecl;
zend_get_std_object_handlers:function:P_zend_object_handlers; cdecl;

zend_ptr_stack_init:procedure(stack:Pzend_ptr_stack); cdecl;
zend_ptr_stack_init_ex:procedure(stack:Pzend_ptr_stack; persistent:zend_bool); cdecl;
zend_ptr_stack_n_push:procedure(stack:Pzend_ptr_stack; count:longint; args:array of const); cdecl;
zend_ptr_stack_n_pop:procedure(stack:Pzend_ptr_stack; count:longint; args:array of const); cdecl;
zend_ptr_stack_destroy:procedure(stack:Pzend_ptr_stack); cdecl;
zend_ptr_stack_apply:procedure(stack:Pzend_ptr_stack; func:EWFG439EGRG45); cdecl;
zend_ptr_stack_clean:procedure(stack:Pzend_ptr_stack; func:G5J90E4GK495Y4; free_elements:zend_bool); cdecl;
zend_ptr_stack_num_elements:function(stack:Pzend_ptr_stack):longint; cdecl;
zend_ini_startup:function:longint; cdecl;
zend_ini_shutdown:function:longint; cdecl;
zend_ini_global_shutdown:function:longint; cdecl;
zend_ini_deactivate:function:longint; cdecl;
zend_ini_dtor:procedure(ini_directives:PHashTable); cdecl;
zend_copy_ini_directives:function:longint; cdecl;
zend_ini_sort_entries:procedure; cdecl;
zend_register_ini_entries:function(ini_entry:Pzend_ini_entry_def; module_number:longint):longint; cdecl;
zend_unregister_ini_entries:procedure(module_number:longint); cdecl;
zend_ini_refresh_caches:procedure(stage:longint); cdecl;
zend_alter_ini_entry:function( name:zend_string; new_value:Pzend_string; modify_type:longint; stage:longint):longint; cdecl;
zend_alter_ini_entry_ex:function(name:Pzend_string; new_value:Pzend_string; modify_type:longint; stage:longint; force_change:longint):longint; cdecl;
zend_alter_ini_entry_chars:function(name:Pzend_string; value:Pchar; value_length:size_t; modify_type:longint; stage:longint):longint; cdecl;
zend_alter_ini_entry_chars_ex:function(name:Pzend_string; value:Pchar; value_length:size_t; modify_type:longint; stage:longint;  force_change:longint):longint; cdecl;
zend_restore_ini_entry:function(name:Pzend_string; stage:longint):longint; cdecl;
display_ini_entries:procedure(module:Pzend_module_entry); cdecl;
zend_ini_long:function(name:Pchar; name_length:uint; orig:longint):zend_long; cdecl;
zend_ini_double:function(name:Pchar; name_length:uint; orig:longint):double; cdecl;
zend_ini_string:function(name:Pchar; name_length:uint; orig:longint):Pchar; cdecl;
zend_ini_string_ex:function(name:Pchar; name_length:uint; orig:longint; exists:Pzend_bool):Pchar; cdecl;
zend_ini_register_displayer:function(name:Pchar; name_length:uint; displayer:IEJORGJIERGE):longint; cdecl;
zend_parse_ini_file:function(fh:Pzend_file_handle; unbuffered_errors:zend_bool; scanner_mode:longint; ini_parser_cb:zend_ini_parser_cb_t; arg:Ppointer):longint; cdecl;
zend_parse_ini_string:function(str:Pchar; unbuffered_errors:zend_bool; scanner_mode:longint; ini_parser_cb:zend_ini_parser_cb_t; arg:Ppointer):longint; cdecl;



_zend_hash_init:procedure(ht:PHashTable; nSize:uint32_t; pDestructor:dtor_func_t; persistent:zend_bool; __zend_filename:Pchar; __zend_lineno:uint); cdecl;
_zend_hash_init_ex:procedure(ht:PHashTable; nSize:uint32_t; pDestructor:dtor_func_t; persistent:zend_bool; bApplyProtection:zend_bool; __zend_filename:Pchar; __zend_lineno:uint); cdecl;
zend_hash_destroy:procedure(ht:PHashTable); cdecl;
zend_hash_clean:procedure(ht:PHashTable); cdecl;
zend_hash_real_init:procedure(ht:PHashTable; _packed:zend_bool); cdecl;
zend_hash_packed_to_hash:procedure(ht:PHashTable); cdecl;
zend_hash_to_packed:procedure(ht:PHashTable); cdecl;
zend_hash_extend:procedure(ht:PHashTable; nSize:uint32_t; _packed:zend_bool); cdecl;
_zend_hash_add_or_update:function(ht:PHashTable; key:Pzend_string; pData:Pzval; flag:uint32_t; __zend_filename:Pchar; __zend_lineno:uint):Pzval; cdecl;
_zend_hash_update:function(ht:PHashTable; key:Pzend_string; pData:Pzval; __zend_filename:Pchar; __zend_lineno:uint):Pzval; cdecl;
_zend_hash_update_ind:function(ht:PHashTable; key:Cardinal; pData:Pzval; __zend_filename:Pchar; __zend_lineno:uint):Pzval; cdecl;
_zend_hash_add:function(ht:PHashTable; key:Pzend_string; pData:Pzval; __zend_filename:Pchar; __zend_lineno:uint):Pzval; cdecl;
_zend_hash_add_new:function(ht:PHashTable; key:Pzend_string; pData:Pzval; __zend_filename:Pchar; __zend_lineno:uint):Pzval; cdecl;
_zend_hash_str_add_or_update:function(ht:PHashTable; key:Pchar; len:size_t; pData:Pzval; flag:uint32_t; __zend_filename:Pchar; __zend_lineno:uint):Pzval; cdecl;
_zend_hash_str_update:function(ht:PHashTable; key:Pchar; len:size_t; pData:Pzval; __zend_filename:Pchar; __zend_lineno:uint):Pzval; cdecl;
_zend_hash_str_update_ind:function(ht:PHashTable; key:Pchar; len:size_t; pData:Pzval; __zend_filename:Pchar; __zend_lineno:uint):Pzval; cdecl;
_zend_hash_str_add:function(ht:PHashTable; key:Pchar; len:size_t; pData:Pzval; __zend_filename:Pchar; __zend_lineno:uint):Pzval; cdecl;
_zend_hash_str_add_new:function(ht:PHashTable; key:Pchar; len:size_t; pData:Pzval; __zend_filename:Pchar; __zend_lineno:uint):Pzval; cdecl;
_zend_hash_index_add_or_update:function(ht:PHashTable; h:zend_ulong; pData:Pzval; flag:uint32_t):Pzval; cdecl;
_zend_hash_index_add:function(ht:PHashTable; h:zend_ulong; pData:Pzval):Pzval; cdecl;
_zend_hash_index_add_new:function(ht:PHashTable; h:zend_ulong; pData:Pzval; __zend_filename:Pchar; __zend_lineno:uint):Pzval; cdecl;
_zend_hash_index_update:function(ht:PHashTable; h:zend_ulong; pData:Pzval; __zend_filename:Pchar; __zend_lineno:uint):Pzval; cdecl;
_zend_hash_next_index_insert:function(ht:PHashTable; pData:Pzval; __zend_filename:Pchar; __zend_lineno:uint):Pzval; cdecl;
_zend_hash_next_index_insert_new:function(ht:PHashTable; pData:zval; __zend_filename:Pchar; __zend_lineno:uint):Pzval; cdecl;
zend_hash_index_add_empty_element:function(ht:PHashTable; h:zend_ulong):Pzval; cdecl;
zend_hash_add_empty_element:function(ht:PHashTable; key:Pzend_string):Pzval; cdecl;
zend_hash_str_add_empty_element:function(ht:PHashTable; key:Pchar; len:size_t):Pzval; cdecl;
zend_hash_graceful_destroy:procedure(ht:PHashTable); cdecl;
zend_hash_graceful_reverse_destroy:procedure(ht:PHashTable); cdecl;
zend_hash_apply:procedure(ht:PHashTable; apply_func:Tapply_func_t); cdecl;
zend_hash_apply_with_argument:procedure(ht:PHashTable; apply_func:Tapply_func_arg_t; para3:pointer); cdecl;
zend_hash_apply_with_arguments:procedure(ht:PHashTable; apply_func:Tapply_func_args_t; para3:longint; args:array of const); cdecl;
zend_hash_reverse_apply:procedure(ht:PHashTable; apply_func:Tapply_func_t); cdecl;
zend_hash_del:function(ht:PHashTable; key:Pzend_string):longint; cdecl;
zend_hash_del_ind:function(ht:PHashTable; key:Pzend_string):longint; cdecl;
zend_hash_str_del:function(ht:PHashTable; key:Pchar; len:size_t):longint; cdecl;
zend_hash_str_del_ind:function(ht:PHashTable; key:Pchar; len:size_t):longint; cdecl;
zend_hash_index_del:function(ht:PHashTable; h:zend_ulong):longint; cdecl;
zend_hash_del_bucket:procedure(ht:PHashTable; p:PBucket); cdecl;
zend_hash_find:function(ht:PHashTable; key:Pzend_string):Pzval; cdecl;
zend_hash_str_find:function(ht:PHashTable; key:Pchar; len:size_t):Pzval; cdecl;

zend_hash_index_findZval:function( ht:pzval; h:zend_ulong):Pzval;    cdecl;
zend_symtable_findTest:function( ht:pzval;  key:pzend_string):Pzval;   cdecl;
zend_hash_index_existsZval:function( ht:pzval; h:zend_ulong):zend_bool;  cdecl;


zend_hash_index_find:function(ht:PHashTable; h:zend_ulong):Pzval; cdecl;

zend_hash_exists:function(ht:PHashTable; key:Pzend_string):zend_bool; cdecl;
zend_hash_str_exists:function(ht:PHashTable; str:Pchar; len:size_t):zend_bool; cdecl;
zend_hash_index_exists:function(ht:PHashTable; h:zend_ulong):zend_bool; cdecl;
zend_hash_has_more_elements_ex:function(ht,pos : longint) : longint; cdecl;
zend_hash_move_forward_ex:function(ht:PHashTable; pos:PHashPosition):longint; cdecl;
zend_hash_move_backwards_ex:function(ht:PHashTable; pos:PHashPosition):longint; cdecl;
zend_hash_get_current_key_ex:function(ht:PHashTable; str_index:PPzend_string; num_index:P_zend_ulong; pos:PHashPosition):longint; cdecl;
zend_hash_get_current_key_zval_ex:procedure(ht:PHashTable; key:Pzval; pos:PHashPosition); cdecl;
zend_hash_get_current_key_type_ex:function(ht:PHashTable; pos:PHashPosition):longint; cdecl;
zend_hash_get_current_data_ex:function(ht:PHashTable; pos:PHashPosition):Pzval; cdecl;
zend_hash_internal_pointer_reset_ex:procedure(ht:PHashTable; pos:PHashPosition); cdecl;
zend_hash_internal_pointer_end_ex:procedure(ht:PHashTable; pos:PHashPosition); cdecl;
zend_hash_copy:procedure(target:PHashTable; source:PHashTable; pCopyConstructor:copy_ctor_func_t; tmp: pointer; size: uint); cdecl;
_zend_hash_merge:procedure(target:PHashTable; source:PHashTable; pCopyConstructor:copy_ctor_func_t; size:uint; overwrite:zend_bool); cdecl;
zend_hash_merge_ex:procedure(target:PHashTable; source:PHashTable; pCopyConstructor:copy_ctor_func_t; pMergeSource:Tmerge_checker_func_t; pParam:Ppointer); cdecl;
zend_hash_bucket_swap:procedure(p:PBucket; q:PBucket); cdecl;
zend_hash_bucket_renum_swap:procedure(p:PBucket; q:PBucket); cdecl;
zend_hash_bucket_packed_swap:procedure(p:PBucket; q:PBucket); cdecl;
zend_hash_compare:function(ht1:PHashTable; ht2:PHashTable; compar:compare_func_t; ordered:zend_bool):longint; cdecl;
zend_hash_sort_ex:function(ht:PHashTable; sort_func:sort_func_t; compare_func:compare_func_t; renumber:zend_bool; TSRMLS_DC: pointer):longint; cdecl;
zend_hash_minmax:function(ht:PHashTable; compar:compare_func_t; flag:uint32_t):Pzval; cdecl;
zend_hash_rehash:function(ht:PHashTable):longint; cdecl;
zend_array_count:function(ht:PHashTable):uint32_t; cdecl;
zend_array_dup:function(source:PHashTable):PHashTable; cdecl;
zend_array_destroy:procedure(ht:PHashTable); cdecl;
zend_symtable_clean:procedure(ht:PHashTable); cdecl;
_zend_handle_numeric_str_ex:function(key:Pchar; length:size_t; idx:P_zend_ulong):longint; cdecl;
zend_hash_iterator_add:function(ht:PHashTable; pos:HashPosition):uint32_t; cdecl;
zend_hash_iterator_pos:function(idx:uint32_t; ht:PHashTable):HashPosition; cdecl;
zend_hash_iterator_pos_ex:function(idx:uint32_t; _array:Pzval):HashPosition; cdecl;
zend_hash_iterator_del:procedure(idx:uint32_t); cdecl;
zend_hash_iterators_lower_pos:function(ht:PHashTable; start:HashPosition):HashPosition; cdecl;
_zend_hash_iterators_update:procedure(ht:PHashTable; from:HashPosition; _to:HashPosition); cdecl;

//tsrm_error:function(level:longint; format:zend_pchar; args:array of const):longint; cdecl;
//zend_mm_set_custom_handlers(heap:Pzend_mm_heap; _malloc:PEWKGERGJ945YG45; _free:procedure (_para1:pointer); var _realloc:procedure :procedure(_para1:pointer; _para2:size_t)); cdecl;
//zend_mm_get_custom_handlers(heap:Pzend_mm_heap; _malloc:PPOERGJOERJGIERGHRE; _free:Pprocedure (_para1:pointer); var _realloc:Pprocedure :procedure(_para1:pointer; _para2:size_t)); cdecl;
//zend_mm_set_custom_debug_handlers(heap:Pzend_mm_heap; var _malloc:procedure (_para1:size_t; __zend_filename:zend_pchar; __zend_lineno:uint; __zend_orig_filename:zend_pchar; __zend_orig_lineno:uint); _free:procedure :procedure(_para1:pointer; __zend_filename:zend_pchar; __zend_lineno:uint; __zend_orig_filename:zend_pchar; __zend_orig_lineno:uint); _realloc:PERG4JG09E84GJ8945H45H); cdecl;
//zend_object_create_proxy:function(_object:Pzval; member:Pzval):P_zend_object; cdecl;
zend_check_internal_arg_type:procedure(zf:P_zend_function; arg_num:uint32_t; arg:Pzval); cdecl;
//zend_check_arg_type:function(zf:Pzend_function; arg_num:uint32_t; arg:Pzval; default_value:Pzval; cache_slot:Ppointer):longint; cdecl;
//zend_check_missing_arg:procedure(execute_data:Pzend_execute_data; arg_num:uint32_t; cache_slot:Ppointer); cdecl;


add_function:function(result:Pzval; op1:Pzval; op2:Pzval):longint; cdecl;
sub_function:function(result:Pzval; op1:Pzval; op2:Pzval):longint; cdecl;
mul_function:function(result:Pzval; op1:Pzval; op2:Pzval):longint; cdecl;
pow_function:function(result:Pzval; op1:Pzval; op2:Pzval):longint; cdecl;
div_function:function(result:Pzval; op1:Pzval; op2:Pzval):longint; cdecl;
mod_function:function(result:Pzval; op1:Pzval; op2:Pzval):longint; cdecl;
boolean_xor_function:function(result:Pzval; op1:Pzval; op2:Pzval):longint; cdecl;
boolean_not_function:function(result:Pzval; op1:Pzval):longint; cdecl;
bitwise_not_function:function(result:Pzval; op1:Pzval):longint; cdecl;
bitwise_or_function:function(result:Pzval; op1:Pzval; op2:Pzval):longint; cdecl;
bitwise_and_function:function(result:Pzval; op1:Pzval; op2:Pzval):longint; cdecl;
bitwise_xor_function:function(result:Pzval; op1:Pzval; op2:Pzval):longint; cdecl;
shift_left_function:function(result:Pzval; op1:Pzval; op2:Pzval):longint; cdecl;
shift_right_function:function(result:Pzval; op1:Pzval; op2:Pzval):longint; cdecl;
concat_function:function(result:Pzval; op1:Pzval; op2:Pzval):longint; cdecl;
zend_is_identical:function(op1:Pzval; op2:Pzval):longint; cdecl;
is_equal_function:function(result:Pzval; op1:Pzval; op2:Pzval):longint; cdecl;
is_identical_function:function(result:Pzval; op1:Pzval; op2:Pzval):longint; cdecl;
is_not_identical_function:function(result:Pzval; op1:Pzval; op2:Pzval):longint; cdecl;
is_not_equal_function:function(result:Pzval; op1:Pzval; op2:Pzval):longint; cdecl;
is_smaller_function:function(result:Pzval; op1:Pzval; op2:Pzval):longint; cdecl;
is_smaller_or_equal_function:function(result:Pzval; op1:Pzval; op2:Pzval):longint; cdecl;
instanceof_function_ex:function(instance_ce:Pzend_class_entry; ce:Pzend_class_entry; interfaces_only:zend_bool):zend_bool; cdecl;
instanceof_function:function(instance_ce:Pzend_class_entry; ce:Pzend_class_entry):zend_bool; cdecl;
_is_numeric_string_ex:function(str:Pchar; length:size_t; lval:Pzend_long; dval:Pdouble; allow_errors:longint; oflow_info:Plongint):zend_uchar; cdecl;
zend_memnstr_ex:function(haystack:Pchar; needle:Pchar; needle_len:size_t; _end:Pchar):Pchar; cdecl;
zend_memnrstr_ex:function(haystack:Pchar; needle:Pchar; needle_len:size_t; _end:Pchar):Pchar; cdecl;
zend_dval_to_lval_slow:function(d:double):zend_long; cdecl;
is_numeric_str_function:function(str:Pzend_string; lval:Pzend_long; dval:Pdouble):zend_uchar; cdecl;
increment_function:function(op1:Pzval):longint; cdecl;
decrement_function:function(op2:Pzval):longint; cdecl;
convert_scalar_to_number:procedure(op:Pzval); cdecl;
_convert_to_cstring:procedure(op:Pzval; __zend_filename:Pchar; __zend_lineno:uint); cdecl;
_convert_to_string:procedure(op:Pzval; __zend_filename:Pchar; __zend_lineno:uint); cdecl;
convert_to_long:procedure(op:Pzval); cdecl;
convert_to_double:procedure(op:Pzval); cdecl;
convert_to_long_base:procedure(op:Pzval; base:longint); cdecl;
convert_to_null:procedure(op:Pzval); cdecl;
convert_to_boolean:procedure(op:Pzval); cdecl;
convert_to_array:procedure(op:Pzval); cdecl;
convert_to_object:procedure(op:Pzval); cdecl;
multi_convert_to_long_ex:procedure(argc:longint; args:array of const); cdecl;
multi_convert_to_double_ex:procedure(argc:longint; args:array of const); cdecl;
multi_convert_to_string_ex:procedure(argc:longint; args:array of const); cdecl;
_zval_get_long_func:function(op:Pzval):zend_long; cdecl;
_zval_get_double_func:function(op:Pzval):double; cdecl;
_zval_get_string_func:function(op:Pzval):Pzend_string; cdecl;
zend_is_true:function(op:Pzval):longint; cdecl;
zend_object_is_true:function(op:Pzval):longint; cdecl;
compare_function:function(result:Pzval; op1:Pzval; op2:Pzval):longint; cdecl;
numeric_compare_function:function(op1:Pzval; op2:Pzval):longint; cdecl;
string_compare_function_ex:function(op1:Pzval; op2:Pzval; case_insensitive:zend_bool):longint; cdecl;
string_compare_function:function(op1:Pzval; op2:Pzval):longint; cdecl;
string_case_compare_function:function(op1:Pzval; op2:Pzval):longint; cdecl;
string_locale_compare_function:function(op1:Pzval; op2:Pzval):longint; cdecl;
zend_str_tolower:procedure(str:Pchar; length:size_t); cdecl;
zend_str_tolower_copy:function(dest:Pchar; source:Pchar; length:size_t):Pchar; cdecl;
zend_str_tolower_dup:function(source:Pchar; length:size_t):Pchar; cdecl;
zend_str_tolower_dup_ex:function(source:Pchar; length:size_t):Pchar; cdecl;
zend_string_tolower:function(str:Pzend_string):Pzend_string; cdecl;
zend_binary_zval_strcmp:function(s1:Pzval; s2:Pzval):longint; cdecl;
zend_binary_zval_strncmp:function(s1:Pzval; s2:Pzval; s3:Pzval):longint; cdecl;
zend_binary_zval_strcasecmp:function(s1:Pzval; s2:Pzval):longint; cdecl;
zend_binary_zval_strncasecmp:function(s1:Pzval; s2:Pzval; s3:Pzval):longint; cdecl;
zend_binary_strcmp:function(s1:Pchar; len1:size_t; s2:Pchar; len2:size_t):longint; cdecl;
zend_binary_strncmp:function(s1:Pchar; len1:size_t; s2:Pchar; len2:size_t; length:size_t):longint; cdecl;
zend_binary_strcasecmp:function(s1:Pchar; len1:size_t; s2:Pchar; len2:size_t):longint; cdecl;
zend_binary_strncasecmp:function(s1:Pchar; len1:size_t; s2:Pchar; len2:size_t; length:size_t):longint; cdecl;
zend_binary_strcasecmp_l:function(s1:Pchar; len1:size_t; s2:Pchar; len2:size_t):longint; cdecl;
zend_binary_strncasecmp_l:function(s1:Pchar; len1:size_t; s2:Pchar; len2:size_t; length:size_t):longint; cdecl;
zendi_smart_strcmp:function(s1:Pzend_string; s2:Pzend_string):zend_long; cdecl;
zend_compare_symbol_tables:function(ht1:PHashTable; ht2:PHashTable):longint; cdecl;
zend_compare_arrays:function(a1:Pzval; a2:Pzval):longint; cdecl;
zend_compare_objects:function(o1:Pzval; o2:Pzval):longint; cdecl;
zend_atoi:function(str:Pchar; str_len:longint):longint; cdecl;
zend_atol:function(str:Pchar; str_len:longint):zend_long; cdecl;
zend_locale_sprintf_double:procedure(op:Pzval; __zend_filename:Pchar; __zend_lineno:uint); cdecl;
zend_update_current_locale:procedure; cdecl;
zend_long_to_str:function(num:zend_long):Pzend_string; cdecl;

ZvalGetPChar:function(z:pzval):zend_pchar; cdecl;
ZvalSetPChar:procedure(z:pzval; p:zend_pchar; l, b:integer); cdecl;

read_property22:function(elem:pzval; name:zend_pchar; flags:Integer):pzval;   cdecl;
isset_property:function(_object:pzval; property_name:zend_pchar):Integer;    cdecl;



lookup_class_ce:function(ce:pzend_class_entry; property_name:zend_pchar; property_length:SIZE_T):pzend_class_entry; cdecl;
class_exists:function(class_name:zend_pchar):Integer;    cdecl;
class_exists2:function(class_name:zend_pchar):Integer;    cdecl;
update_property_zval:function(_object:pzval; property_name:zend_pchar; value:pzval):integer; cdecl;
__create_php_object:function(classname:pzend_string; return_value:pzval; __params:pzval; argc:Integer):pzend_class_entry; cdecl;



__call_function:procedure(func:pzval; argv:pzval; argc:integer);cdecl;
safe_emalloc2:function(nmemb:size_t; size:size_t; offset:size_t):Pointer;cdecl;

ZvalEmalloc:function(nmemb:size_t):pzval;cdecl;

pZVAL_NEW_REF:procedure(arg1, arg2:pointer);cdecl;

NewPzval:function(z:pzval):pzval;cdecl;

CreateCll:function(result:pzval; class_name:zend_pchar; Self:integer):pzval;cdecl;

PHPInitSetValue:procedure(name, new_value:zend_pchar; modify_type, stage:integer);cdecl;

implementation


end.

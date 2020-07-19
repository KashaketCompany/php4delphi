## 7.5-rc1
* Some of the ZVAL_*Type procedures moved:
  ZVAL_*Type -> ZVALVAL( z: pzval, what: Type )
* Major bug fixes (AV, Range Checking, NullPointer, php executing order, etc.)
* Introduced metatypes, so the types can be used regardless of Delphi version (x64/32, dcc version, other)
* Replaced assembler calls with pointer math
* Added procedures: <br> HFunc - hook library function <br> LFunc - load library function

## 7.4 Mar 2019

* Compatible with PHP 5.5.0
* Compatible with PHP 5.6.0
* Compatible with PHP 5.6.x
* Compatible with Delphi 2011, XE8, Seattle, Berlin
* Added unicode support

## 7.3 Jan 2019

* Compatible with PHP 5.4.0
* Removed PHP 4 support

## 7.2 Oct 2009

* Compatible with Delphi 2010
* Compatible with PHP 5.2.11
* Compatible with PHP 5.3.0 (VC6 and VC9 editions : see PHP.INC for more details)

## 7.1 Oct 2008

* Compatible with Delphi 2009

## 7.0 Apr 2007

* Compatible with Delphi 2007
* Compatible with PHP 5.2.1
* Compatible with PHP 4.4.6
* Thread safe TpsvPHP component
* New component TPHPEngine introduced
* RunCode method reimplemented to solve "black horror" of pipes.
* Not fully compatible with previous version due to multithreading, but migration is easy.

## 6.2 Feb 2006

* Compatible with PHP 5.2.0
* Compatible with Delphi 2006
* Compatible with PHP 5.1.1
* Compatible with PHP 5.1.2
* Code reorganized, some crap was removed
* Added headers support (Michael Maroszek)
* New demo projects
* PHP4Applications revisited

## 6.1

* Compatible with PHP 5.0.4
* Compatible with PHP 5.1.0b3
* Compatible with Delphi 2005

## 6.0

* Translated Zend II API
* New PHP Object Model support
* PHP classes support for PHP4 and PHP5
* New demo projects
* TPHPClass component compatible with PHP4 and PHP5
* Added new property DLLFolder to psvPHP component
* New component PHPSystemLibrary

## 5.5 fix 1

* New property RegisterGlobals (boolean) added to psvPHP component
* New property MaxExecutionTime (integer) added to psvPHP component - Maximum execution time of each script, in seconds
* New property MaxInputTime (integer) added to psvPHP component - Maximum amount of time each script may spend parsing request data
* New property SafeMode (boolean) added to psvPHP component
* New property SafeModeGid (boolean) added to psvPHP component -  When safe_mode is on, UID/GID checks are bypassed when
  including files from this directory and its subdirectories. (directory must also be in include_path or full path must
  be used when including)
* Memory leak fixed in phpModules unit
* php_class demo project errors fixed
* psvPHP can load now PHP modules using dl() function

## 5.5

* New component TPHPClass added (only for PHP 4)
* Added support of PHP 5
* Improved speed of unloading of the PHP extensions under Apache 
* Decreased size of the compiled modules (based on API only and developed using Visual FrameWork)
* ZendAPI unit is splitted to ZendAPI and ZendTypes units
* PHPAPI unit is splitted to  PHPAPI and PHPTypes units
* New version of php4App - php4Applications subproject. 
  php4Applications allows to use php scripts in VB, C, C++, etc applications.
  Demo projects for Delphi, VC and MS Word included.
* New property UseDelimiters added to TpsvPHP component. If UseDelimiters = true (by default) the
  syntax of RunCode method parameter ACode should include standard script delimiters "<?" and "?>"
  to make RunCode and Execute method compatible.
* New parameters for OnScriptError event (error type, file name and line number)

## 5.4

* Minor bugs fixed
* Documentation improved 
* New property IniPath (folder where php.ini located) added to TpsvPHP component
* New functions translated in ZendAPI unit

## 5.3
* Added new public property ExecuteMethod to psvPHP component. 
  if ExecuteMethod is emGet, psvPHP receives variables as $_GET["variable"],
  if ExecuteMethod is emServer (default), psvPHP receives variables as $variable.
  Can be used to debug real PHP scripts with GET parameters.
* Added possibility to access published property of Delphi components from PHP
* Fixed problem with loading of PHP extension compiled wihout PHP4DELPHI_AUTOLOAD
  option.

## 5.2
* Added dynamic attachement of all exported functions from php4ts.dll
  in PHPAPI.pas
* New function for safe dynamic functions linking PHPStubInit and ZendStubInit
  This functions can be used if you are planning to work with beta-version of PHP,
  for example
* New unit zend_dynamic_array.pas
* New unit logos.pas

## 5.0.3
* Fixed bug when php function without parameters does not return value.
* New classes: TZendVariable and TZendValue in  phpFunctions.pas
* New subproject: php4App
  Using php4App you can integrate PHP not only with Delphi, but with VB, for example

## 5.0.2 
* Fixed problem with assembler code in ZENDAPI.pas for Delphi 7

## 5.0.1
* Fixed problem with number of parameters of zend_getparameters_ex function

## 5.0
* First version written in Delphi


## 1.0 - 4.0  
* php4Delphi was written in C as a DLL with simple Delphi wrapper
 

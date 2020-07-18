{*******************************************************}
{                     PHP4Delphi                        }
{               PHP - Delphi interface                  }
{                                                       }
{ Author:                                               }
{ Serhiy Perevoznyk                                     }
{ serge_perevoznyk@hotmail.com                          }
{ https://users.chello.be/ws36637                       }
{ https://delphi32.blogspot.com                         }
{*******************************************************}

{ $Id: PHP.INC,v 7.4 07/2020 delphi32 Exp $ }

{IMPORTANT:
Define suitable PHP version, the table is represented below:
| Version |    Directive    |
    5.0      $DEFINE PHP5
   5.0.4     $DEFINE PHP504
   5.1.0     $DEFINE PHP510
   5.1.1     $DEFINE PHP511
   5.1.2     $DEFINE PHP512
    5.2      $DEFINE PHP520
    5.3      $DEFINE PHP530
    5.4      $DEFINE PHP540
    5.5      $DEFINE PHP550
    5.6      $DEFINE PHP560
    7.0      $DEFINE PHP7
    7.1      $DEFINE PHP710

Define suitable visual library
| Library |    Directive    |
    VCL      $DEFINE VCL
    FMX      $DEFINE FMX
}

//Version
{$DEFINE PHP560}
	//PHP Version
{$DEFINE ZTS}
	//Thread Safe mode (php7ts, e.g)
{$DEFINE VCL}
	//visual library - Kylix, VCL, FMX for Delphi and LCL, fpGUI for Lazarus
	
//Features
{$DEFINE PHP_UNICODE}
    //PHP unicode support *Enables WideString and UnicodeString
{.$DEFINE REGISTER_COLOURS} 
    //constants for Delphi colours
{.$DEFINE php_side_handler}
    //enable ability to define own error handler from php side ~NON_TC
{.$DEFINE QUIET_LOAD}
    //Do not show errors while loading php library
{.$DEFINE PHP4DELPHI_AUTOLOAD}
    //Load php library at initialization
{.$DEFINE PHP4DELPHI_AUTOUNLOAD}
    // Unload php library at finalization

//Compiler switches
{.$DEFINE COMPILER_php7pv}
    // use macroses from PHP sources patch 
    // https://github.com/resistancelion/no-name-engine/tree/master/php-src
{.$DEFINE PHP_DEBUG}
    //use debug libraries (php7debug, f.e)













//E N D
{$WARN UNIT_DEPRECATED OFF}
{$IFDEF PHP_UNICODE} {$DEFINE UNICODE} {$ENDIF}

{$IFDEF PHP710} {$DEFINE PHP700} {$ENDIF}
{$IFDEF PHP700} {$DEFINE PHP7} {$ENDIF}

{$IFDEF PHP7} {$DEFINE PHP560} {$ENDIF}
{$IFDEF PHP560} {$DEFINE PHP550} {$ENDIF}
{$IFDEF PHP550} {$DEFINE PHP540} {$ENDIF}
{$IFDEF PHP540} {$DEFINE PHP530} {$ENDIF}
{$IFDEF PHP530}
  {$DEFINE PHP520}
  {$DEFINE ZEND_WIN32}
  {$DEFINE PHP_COMPILER_ID}
{$ENDIF}
{$IFDEF PHP520} {$DEFINE PHP512} {$ENDIF}
{$IFDEF PHP512} {$DEFINE PHP511} {$ENDIF}
{$IFDEF PHP511} {$DEFINE PHP510} {$ENDIF}
{$IFDEF PHP510} {$DEFINE PHP504} {$ENDIF}
{$IFDEF PHP504} {$DEFINE PHP5} {$ENDIF}
{$IFDEF PHP_COMPILER_ID}
 {$DEFINE COMPILER_VC9}
	{$IFNDEF PHP7}
		{$IFDEF PHP550} {$DEFINE COMPILER_VC11} {$ENDIF}
	{$ELSE}
        {$DEFINE COMPILER_VC14}
    {$ENDIF}
{$ENDIF}


{$ifdef FPC}
	{$DEFINE VERSION1}
	{$DEFINE VERSION2}
	{$DEFINE VERSION3}
	{$DEFINE VERSION4}
	{$DEFINE VERSION5}
	{$DEFINE VERSION6}
	{$DEFINE VERSION7}
	{$DEFINE VERSION8}
	{$DEFINE VERSION9}
	{$DEFINE VERSION10}
	{$DEFINE VERSION11}
	{$DEFINE VERSION12}
	{$DEFINE VERSION13}
	{$DEFINE VERSION14}
{$endif}

{$IFNDEF VER80}                                             {Delphi 1.0}
  {$DEFINE VERSION2}                                        {Delphi 2.0 and BCB 1 or higher}
{$ENDIF}

{$IFDEF VERSION2}
  {$IFNDEF VER90}                                           {Delphi 2.0}
    {$IFNDEF VER93}                                         {BCB 1.0}
      {$DEFINE VERSION3}                                    {Delphi 3.0 or BCB 3.0}
    {$ENDIF}
  {$ENDIF}
{$ENDIF}

{$IFDEF VERSION3}
  {$IFNDEF VER100}                                          {Delphi 3}
    {$IFNDEF VER110}                                        {BCB 3}
      {$DEFINE VERSION4}                                    {Delphi 4.0 or higher}
    {$ENDIF}
  {$ENDIF}
{$ENDIF}

{$IFDEF VERSION4}
  {$IFNDEF VER120}                                          {Delphi 4}
    {$IFNDEF VER125}                                        {BCB 4}
      {$DEFINE VERSION5}                                    {Delphi 5.0 or higher}
    {$ENDIF}
  {$ENDIF}
{$ENDIF}

{$IFDEF VERSION5}
  {$IFNDEF VER130}                                          {Delphi 5}
    {$IFNDEF VER135}                                        {BCB 5}
      {$DEFINE VERSION6}                                    {Delphi 6.0 or higher}
    {$ENDIF}
  {$ENDIF}
{$ENDIF}

{$IFDEF VERSION6}
  {$IFNDEF VER140}                                          {Delphi 6}
    {$IFNDEF VER145}                                        {BCB 6}
      {$DEFINE VERSION7}                                    {Delphi 7.0 or higher}
    {$ENDIF}
  {$ENDIF}
{$ENDIF}

{$IFDEF VERSION7}
 {$IFNDEF VER150}                                           {Delphi 7}
     {$DEFINE VERSION9}                                     {Delphi 2005}
 {$ENDIF}
{$ENDIF}

{$IFDEF VERSION9}
  {$IFNDEF VER170}                                          {Delphi 2005}
    {$DEFINE VERSION10}                                     {Delphi 2006}
  {$ENDIF}
{$ENDIF}

{$IFDEF VERSION10}
  {$IFNDEF VER180}                                          {Delphi 2006}
    {$DEFINE VERSION11}                                     {Delphi 2007}
  {$ENDIF}
{$ENDIF}

{$IFDEF VERSION11}
  {$IFNDEF VER185}                                          {Delphi 2007}
    {$DEFINE VERSION12}                                     {Delphi 2009}
  {$ENDIF}
{$ENDIF}

{$IFDEF VERSION12}
  {$IFNDEF VERSION20}
    {$DEFINE VERSION13}                                     {Delphi 2010}
  {$ENDIF}
{$ENDIF}

{$IFNDEF VER180}
	{$DEFINE OLD_PATHS}
{$ENDIF}

{$IFDEF VERSION12}
	{$DEFINE WSTR}
{$ELSE}
	{$IFDEF PHP_UNICODE} {$UNDEF PHP_UNICODE} {$ENDIF}
{$ENDIF}


{$IFDEF VERSION6}
  {$WARN SYMBOL_PLATFORM OFF}
  {$IFDEF VERSION7}
    {$WARN UNIT_PLATFORM OFF}
    {$WARN UNSAFE_CODE OFF}
    {$WARN UNSAFE_TYPE OFF}
    {$WARN UNSAFE_CAST OFF}
    {$WARN UNIT_DEPRECATED OFF}
  {$ENDIF}
{$ENDIF}

{$IFDEF VERSION5}
  {$IFNDEF VERSION6}
    {$DEFINE VERSION5ONLY}
  {$ENDIF}
{$ENDIF}

{$IFDEF VERSION6}
{$A8}
{$ELSE}
{$A+}
{$ENDIF}


{$IFDEF VERSION7}
{$J+}
{$WARNINGS OFF}
{$ENDIF}

{$IFDEF MSWINDOWS} {$DEFINE WINDOWS} {$ENDIF}
{$IFDEF FPC}
    {$IFDEF FMX} {$UNDEF FMX} {$ENDIF}
    {$IFDEF VCL} {$UNDEF VCL} {$ENDIF}
    {$DEFINE LCL}
{$ELSE}
    {$UNDEF LCL}
	{$IFDEF WINDOWS}
		{$DEFINE VCL}
	{$ELSE}
		{$DEFINE KYLIX}
	{$ENDIF}
{$ENDIF}

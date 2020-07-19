# PHP4Delphi library                       

PHP - Delphi interface and PHP extensions development framework                  

{ $Id: readme.txt,v 7.4 07/2020 delphi32 Exp $ } 

PHP4Delphi is a Delphi interface to PHP for Delphi {2009, ..., Rio}

PHP4Delphi consists of 3 big subprojects:

1. PHP scripting (using PHP as a scripting language in Delphi applications) <br>
PHP4Delphi allows to execute the PHP scripts within the Delphi program using <br>
TpsvPHP component directly without a WebServer.  <br>
It is a PHP extension that enables you to write client-side GUI applications.  <br>
One of the goals behind it was to prove that PHP is a capable general-purpose scripting <br> 
language that is suited for more than just Web applications.  <br>
It is used by "Delphi for PHP" from CodeGear. <br>

2. PHP extensions development framework (using Delphi to extend PHP functionality) <br>
Visual Development Framework gives possibility to create custom PHP <br>
Extensions using Delphi.  <br>
PHP extension, in the most basic of terms, is a set of instructions that is <br>
designed to add functionality to PHP. <br>

3. PHP4Applications (integrate PHP in any application) <br>
Supports C, C++, Visual Basic, VBA, C#, Delphi, Delphi .NET, Visual Basic .NET etc. <br> 


More detail information available in <a href="/documentation/php4Delphi.pdf">php4Delphi manual php4Delphi.pdf</a>


This is a source-only release of php4Delphi. <br>
It includes design-time and run-time packages for Delphi 2009 through Delphi Rio <br> <br>

# Features
* Compatible with Delphi 2009, 10.1 Seattle, 10.2 Berlin, 10.3 Tokyo
* PHP 5.0.0 - 5.6.x support
* Unicode support ( php 5.5 & up )
<br> <a href="versions.md">Version history</a>

# Prerequisites
Before using php4Delphi library: <br>

If you have no PHP installed, you have to download and  <br>
install PHP separately. It is not included in the package. <br>
You can download the latest version of PHP from <br>
https://php.net/downloads/ <br>
or <br>
https://windows.php.net/downloads/releases/archives/ <br>

ZEND API documentation available at http://www.zend.com <br>
PHP  API documentation available at http://www.php.net <br>

You need to ensure that the dlls which php uses can be found. <br> 
php5ts.dll is always used. If you are using any php extension dlls then you <br>
will need those as well.  <br>
To make sure that the dlls can be found, you can either copy them to the  <br>
system directory (e.g. winnt/system32 or  windows/system). <br>

Copy the file, php.ini-release to your php installation path <br>
and rename it to php.ini. By default php is located in  <br>
%WINDOWS% or %SYSTEMROOT% directory: <br>
c:\windows for Windows <br>
c:\winnt or c:\winnt40 for NT/2000/XP servers <br>

# Building
Uninstall previous installed version of php4Delphi Library from Delphi IDE. <br>
Remove previously compiled php4Delphi packages from your disk. <br>

Select PHP version you are going to use. php4Delphi supports PHP 5.x,  <br>
but not at the same time - this behaviour is legacy, and therefore will be removed. <br>
You have to compile php4Delphi for selected target version of PHP. <br>

a) Edit PHPver.INC file. <br>
   Specify PHPver constant: <br>
   PHPver = 05604; // php 5.6.4 -> 05 6 04 <br>
b) Edit PHP.INC file. <br>
   Remove dot from preferred features <br>

Use "File\Open..." menu item of Delphi IDE to open php4Delphi group <br>
choose suitable group from /package directory;  <br>
In "Package..." window select php4DelphiR, <br>
click "Compile" button to compile BPL.  <br>
Put compiled BPL file into directory that is accessible through the search PATH  <br>
("PATH" environment variable; <br>
for example, in the Windows\System directory). <br>

After compiling php4Delphi run-time package you must install design-time <br>
package into the IDE. <br>

In "Package..." window select php4DelphiD, <br>
click "Compile" button to compile the package <br>
and then click "Install" button to install php4Delphi components. <br>

# Credits

Since this is a freeware you are strongly encouraged to look  <br>
at the source code and improve on the components if you want to.  <br>
Of course we would appreciate if you create pull request with the  <br>
changes and bug fixes you have made.  <br>

For more information on the PHP Group and the PHP project, <br>
please see <http://www.php.net>. <br>


PHP4Delphi forum <br>
http://sourceforge.net/forum/forum.php?forum_id=324242  <br>

Authors: <br>                                              
Serhiy Perevoznyk <br>                                 
Belgium <br>
serge_perevoznyk@hotmail.com <br>
http://users.telenet.be/ws36637  <br>
http://delphi32.blogspot.com  <br>

Lew Zienin  <br>
Ukraine  <br>
levzenin@pm.me  <br>

Nikita Ganzikov  <br>
Ukraine  <br>
pig-l@mail.ru

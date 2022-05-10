@ECHO OFF

:: No flags passed, so we'll just run the default larafix command
IF "%1"=="" GOTO Default

:Loop
IF "%1"=="" GOTO :EOF
:: Help
IF "%1"=="-h" GOTO help
IF "%1"=="--help" GOTO Help
IF "%1"=="help" GOTO Help

:: Clear
IF "%1"=="-c" GOTO clear
IF "%%A"=="--clear" GOTO clear
IF "%%A"=="clear" GOTO clear

:: Drop
IF "%%A"=="-d" GOTO drop
IF "%%A"=="--drop" GOTO drop
IF "%%A"=="drop" GOTO drop

::Dumpimize
IF "%%A"=="--dumpimize" GOTO dumpimize
IF "%%A"=="dumpimize" GOTO dumpimize

::Migrate
IF "%%A"=="-m" GOTO migrate
IF "%%A"=="--migrate" GOTO migrate
IF "%%A"=="migrate" GOTO migrate

::Serve
IF "%%A"=="-s" GOTO serve
IF "%%A"=="--serve" GOTO serve
IF "%%A"=="serve" GOTO serve

GOTO :EOF

:Help
  ECHO Help menu:
  ECHO By default this script executes the following artisan commands: `optimize`, `migrate:fresh --seed` and `serve`
  ECHO To execute commands, use the following flags:
  ECHO Help:        [-h ^| --help ^| help]        Help command
  ECHO Clear:       [-c ^| --clear ^| clear]      Manual clears (routes, config, view and cache)
  ECHO Drop:        [-d ^| --drop ^| drop]        Drops all tables
  ECHO Dumpimize:   [--dump ^| dump]             Executes composer dump-autoload and artisan optimize command
  ECHO Migrate:     [-m ^| --migrate ^| migrate]  Drops the database and create it again + seeding
  ECHO Serve:       [-s ^| --serve ^| serve]      Serve the application
  ECHO Wipe:        [-w ^| --wipe ^| wipe]        Drops all tables
  ECHO %empty%
  ECHO You can combine flags as the following example:
  ECHO Example: larafix -dump -s
  ECHO This example will execute composer dump-autoload, artisan optimize and artisan serve
  SHIFT
  GOTO :EOF

:Default
  CALL php artisan optimize
  CALL php artisan migrate:fresh --seed
  CALL php artisan serve
  SHIFT 
  GOTO Loop

:Clear
  CALL php artisan route:clear
  CALL php artisan config:clear
  CALL php artisan view:clear
  CALL php artisan cache:clear
  SHIFT
  GOTO Loop

:Drop
  CALL php artisan db:wipe
  SHIFT
  GOTO Loop

:Dumpimize
  CALL composer dump-autoload
  CALL php artisan optimize
  SHIFT
  GOTO Loop

:Migrate
  CALL php artisan migrate:fresh --seed
  SHIFT
  GOTO Loop

:Serve
  php artisan serve
  SHIFT
  GOTO Loop

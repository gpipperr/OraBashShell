define SYSUSER_PWD='&1'

connect "SYS"/"&&SYSUSER_PWD" as SYSDBA
set echo on

spool $SCRIPTS/context.log append
SET VERIFY ON

@$ORACLE_HOME/ctx/admin/catctx change_on_install SYSAUX TEMP NOLOCK
--SET VERIFY ON

connect "SYS"/"&&SYSUSER_PWD" as SYSDBA
set echo on

alter user CTXSYS  account unlock;
alter user CTXSYS  account unlock identified by "change_on_install";


connect "CTXSYS"/"change_on_install"

--SET VERIFY OFF
@$ORACLE_HOME/ctx/admin/defaults/dr0defin.sql "AMERICAN"

SET VERIFY OFF



connect "SYS"/"&&SYSUSER_PWD" as SYSDBA
set echo on

alter user CTXSYS  account lock;



spool off

exit

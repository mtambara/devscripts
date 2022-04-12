if [ -e monitor.sql ]; then
rm -f monitor.sql
fi

echo "use master
exec sp_configure 'SQL batch capture', 1
go
exec sp_configure 'enable monitoring', 1
go
exec sp_configure 'max SQL text monitored', 2048
go
exec sp_configure 'sql text pipe max messages', 3000
go
exec sp_configure 'sql text pipe active', 1
go" > monitor.sql

isql -U sa -P liferay123 -S lportal -i monitor.sql

rm -f monitor.sql

#select * from master..monSysSQLText

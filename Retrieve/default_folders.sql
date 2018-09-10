/*
 * TSQL script to retrieve Default Data, Log, and Backup folder paths in Windows
 *
 */


declare @DefaultData nvarchar(300)
exec master.dbo.xp_instance_regread N'HKEY_LOCAL_MACHINE', N'Software\Microsoft\MSSQLServer\MSSQLServer', N'DefaultData', @DefaultData output

declare @DefaultLog nvarchar(300)
exec master.dbo.xp_instance_regread N'HKEY_LOCAL_MACHINE', N'Software\Microsoft\MSSQLServer\MSSQLServer', N'DefaultLog', @DefaultLog output

declare @DefaultBackup nvarchar(300)
exec master.dbo.xp_instance_regread N'HKEY_LOCAL_MACHINE', N'Software\Microsoft\MSSQLServer\MSSQLServer', N'BackupDirectory', @DefaultBackup output

declare @MasterData nvarchar(300)
exec master.dbo.xp_instance_regread N'HKEY_LOCAL_MACHINE', N'Software\Microsoft\MSSQLServer\MSSQLServer\Parameters', N'SqlArg0', @MasterData output
set @MasterData=substring(@MasterData, 3, 255)
set @MasterData=substring(@MasterData, 1, len(@MasterData) - charindex('\', reverse(@MasterData)))

declare @MasterLog nvarchar(300)
exec master.dbo.xp_instance_regread N'HKEY_LOCAL_MACHINE', N'Software\Microsoft\MSSQLServer\MSSQLServer\Parameters', N'SqlArg2', @MasterLog output
set @MasterLog=substring(@MasterLog, 3, 255)
set @MasterLog=substring(@MasterLog, 1, len(@MasterLog) - charindex('\', reverse(@MasterLog)))

select 
    isnull(NULL, @MasterData) as DefaultData, 
    isnull(@DefaultLog, @MasterLog) as DefaultLog,
    isnull(@DefaultBackup, @MasterLog) as DefaultBackup

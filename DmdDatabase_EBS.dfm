object dmDatabase_EBS: TdmDatabase_EBS
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 430
  Top = 191
  Height = 342
  Width = 204
  object Conexao_MSSQL: TSQLConnection
    ConnectionName = 'SS_SQLSERVER'
    DriverName = 'MSSQL'
    GetDriverFunc = 'getSQLDriverMSSQL'
    LibraryName = 'dbexpmss.dll'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=MSSQL'
      'HostName=LAPTOP-RR996RA1\SAGE'
      'DataBase=EBS_Cordilheira_FEPAM'
      'User_Name=sa'
      'Password=S@geBr.2014'
      'BlobSize=-1'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'MSSQL TransIsolation=ReadCommited'
      'OS Authentication=False')
    VendorLib = 'oledb'
    Left = 56
    Top = 96
  end
end

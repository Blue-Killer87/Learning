program consoleDatabase;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes,
  { you can add units after this }
  IBconnection, sqldb, sysutils;


var
  connection: TIBConnection;
  transaction: TSQLTransaction;
  query: TSQLQuery;

procedure CreateConnection;
begin
     connection:= TIBConnection.create(nil);
     connection.HostName:= 'localhost';
     connection.DatabaseName:='./';
     connection.username:='SYSDBA';
     connection.password:= 'masterkey';
end;

procedure CreateTransaction;
begin
    transaction:= TSQLTransaction.Create(nil);
    transaction.DataBase:=connection;
end;

procedure CreateQuery;
begin
    query:= TSQLQuery.Create(nil);
    query.DataBase:=connection;
    query.Transaction:=transaction;
end;

procedure Prepare;
begin
    CreateConnection;
    CreateTransaction;
    CreateQuery;
end;

procedure Terminate;
begin
    query.Close;
    connection.Close();
    query.Free;
    connection.Free;
    transaction.Free;
end;

procedure writeTable;
begin
    try
      Prepare;
      query.SQL.Text:='select country, currency from country';
      try
          connection.Open;
          query.open;
          while not query.EOF do begin
            writeln('Country: ', query.FieldByName('Country').AsString, ', Currency: ', query.FieldByName('Currency').AsString);
            query.Next;
          end;


      except
        on ex: Exception do begin
          writeln('Exception raised: ', ex.ClassName);
          writeln(ex.Message);
        end;
      end;

    finally
        Terminate;
    end;
end;
procedure WriteIntoTable;
const
  sql = 'INSERT INTO country values (''Slovakia'', ''Euro'')';
begin
     try
       Prepare;
       query.SQL.Text:=sql;
       try
         connection.open;
         query.ExecSQL;
         transaction.Commit;
       except
         on ex: Exception do begin
            transaction.Rollback;
            writeln('Exception raised: ', ex.ClassName);
            writeln(ex.Message);
        end;

       end;
     finally
         terminate;
     end;
end;

procedure InsertWithParam;
var
  values: TStringList;
  i: integer;
begin
    values:=TStringList.Create;
    values.Add('Czechia');
    values.Add('CZK');

    try
      Prepare;
      query.SQL.text:='INSERT INTO country VALUES (:country, :currency)';
      try
          connection.open;
          for i := 0 to 0 do begin
              query.Params.ParamByName('country').AsString:=values[2*i];
              query.Params.ParamByName('currency').AsString:=values[2*i+1];
              query.ExecSQL;
          end;
          transaction.Commit;
      except
        on ex: Exception do begin
            transaction.Rollback;
            writeln('Exception raised: ', ex.ClassName);
            writeln(ex.Message);
        end;
      end;
    finally
        terminate;
    end;
end;

begin
   writeTable;
   //WriteIntoTable;
   InsertWithParam;
   writeTable;
end.


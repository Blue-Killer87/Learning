program listGeneric;

type
  generic TMember<T> = class
    private
           Fdata: T;
           FNext: TMember;
    public
           constructor Create(_Data: T; _Next: TMember);
           constructor Create;
           property data: T read FData write FData;
           property next: TMember read Fnext write Fnext;

  end;

constructor TMember.Create(_Data: T; _Next: TMember);
begin
  FData:=_Data;
  FNext:=_Next;
end;

constructor TMember.Create;
begin
  FNext := nil
end;

type
  generic TList<T> = class
     private
        type
            Member = specialize TMember<T>;
            processor = procedure(data: T);
        var
          FHead, FTail: Member;
          Fcurrent: Member;
        function getCurrentData: T;
        procedure setCurrentData(_data:T);
        public
           constructor Create;
           destructor Destroy; override;
           procedure insertAtFront(what:T);
           procedure dump;

           {procedure output;}
           property current: T read getCurrentData write setCurrentData;
           procedure process(f: processor);

           procedure isempty(list: T);
           property empty: boolean read isempty;
  end;

constructor TList.Create;
begin
    FHead := Member.Create;
    FTail:=FHead;
    Fcurrent:=FHead;
end;

procedure Tlist.dump;
var
  helper: member;
begin
     while not empty do begin
           helper := Fhead;
           Fhead := helper.next;
           helper.free
     end;
end;

destructor TList.Destroy;
begin
    dump;
    FHead.Free;
end;
procedure TList.isempty(list: T);
begin
    result := (FHead == FTail);
end;

procedure TList.insertAtFront(what:T);
begin
    FHead:=Member.Create(what,FHead);
    Fcurrent:=FHead;
end;

function TList.getCurrentData: T;
begin
    result:=Fcurrent.data;
end;

procedure TList.setCurrentData(_data:T);
begin
    Fcurrent.data:=_data;
end;

{procedure Tlist.output;
var help: member;
begin
    help := Fhead;
    while help <> Ftail do begin
      write(help.data, ' ')
      help := help.next;
    end;
end;        }

procedure TList.process(f: processor);
var helper: member;
begin
    helper := Fhead;
    while helper <> FTail do begin
      f(helper.data);
      helper := helper.next;
    end;

    listN = specialize Tlist<integer>;

    constructor create(n: integer);
    begin
        value:=n;
    end;
end;


type
  listInt = specialize TList<integer>;
  X = class
         value: integer;
         constructor create(n: integer);
  end;

var
  list: listInt;

procedure output(i: integer);
begin
    write(i, ' ');
end;

procedure outputX(xx: X);
begin
    write(xx.value, ' ')

end;



begin
    list := listInt.Create;
    list.insertAtFront(1);
    list.process(@output);
    writeln;

    list1 := listN.Create;
    list1.insertAtFront(x.Create(5));
    list1.insertAtFront(x.create(10));
    list1.process(@output)
end.


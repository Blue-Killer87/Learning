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
        var
          FHead, FTail: Member;
          Fcurrent: Member;
        function getCurrentData: T;
        procedure setCurrentData(_data:T);
        public
           constructor Create;
           destructor Destroy; override;
           procedure insertAtFront(what:T);

           //procedure write;
  end;

constructor TList.Create;
begin
    FHead := Member.Create;
    FTail:=FHead;
    Fcurrent:=FHead;
end;

destructor TList.Destroy;
begin
     //dump;
    FHead.Free;
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

type
  listInt = specialize TList<integer>;

var
  list: listInt;

begin
    list := listInt.Create;
    list.insertAtFront(1);
end.


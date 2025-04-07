program genericity;

type
  generic couple<TKey, TValue> = class
    private
      FKey: TKey;
      FValue: TValue;
    public
      Constructor Create(_Key: TKey; _Value: TValue);
      property Key: TKey read FKey write FKey;
      property Value: TValue read FValue write FValue;
  end;


constructor couple.Create(_Key: TKey; _Value: TValue);
begin
    Key:=_Key;
    Value:=_Value;
end;

type
  coupleStrInt = specialize couple<string, integer>;

var
  two: coupleStrInt;

begin
  two := coupleStrInt.Create('Thursday',3);
  writeln(two)
end.


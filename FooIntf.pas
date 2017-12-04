unit FooIntf;

interface

type
  IFoo = interface
    function FooMethod1: IFoo;
    function FooMethod2(SomeParam: string): IFoo;
    procedure FooMethod3;
  end;

  TDecorableFoo = class(TInterfacedObject, IFoo)
  private
    FOrigin: IFoo;
  public
    constructor Create(Origin: IFoo);
    function FooMethod1: IFoo; virtual;
    function FooMethod2(SomeParam: string): IFoo; virtual;
    procedure FooMethod3; virtual;
  end;

implementation

{ TDecorableFoo }

constructor TDecorableFoo.Create(Origin: IFoo);
begin
  FOrigin := Origin;
end;

function TDecorableFoo.FooMethod1: IFoo;
begin
  Result := Self;
  FOrigin.FooMethod1;
end;

function TDecorableFoo.FooMethod2(SomeParam: string): IFoo;
begin
  Result := Self;
  FOrigin.FooMethod2(SomeParam);
end;

procedure TDecorableFoo.FooMethod3;
begin
  FOrigin.FooMethod3;
end;

end.

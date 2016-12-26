unit FooIntf;

interface

type
    IFoo = Interface
      function FooMethod1: IFoo;
      function FooMethod2(SomeParam: String): IFoo;
      procedure FooMethod3;
    End;

    TDecorableFoo = Class(TInterfacedObject, IFoo)
    protected
      FOrigin: IFoo;
    public
      constructor Create(Origin: IFoo);
      function FooMethod1: IFoo; Virtual;
      function FooMethod2(SomeParam: String): IFoo; Virtual;
      procedure FooMethod3; Virtual;
    End;

implementation

{ TDecorableFoo }

constructor TDecorableFoo.Create(Origin: IFoo);
begin
     FOrigin := Origin;
end;

function TDecorableFoo.FooMethod1: IFoo;
begin
     Result := FOrigin.FooMethod1;
end;

function TDecorableFoo.FooMethod2(SomeParam: String): IFoo;
begin
     Result := FOrigin.FooMethod2(SomeParam);
end;

procedure TDecorableFoo.FooMethod3;
begin
     FOrigin.FooMethod3;
end;

end.

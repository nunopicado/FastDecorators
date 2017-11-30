unit FooImpl;

interface

uses
    FooIntf
  ;

type
  TFoo = class(TInterfacedObject, IFoo)
  public
    function FooMethod1: IFoo;
    function FooMethod2(SomeParam: string): IFoo;
    procedure FooMethod3;
  end;

  TSpecialFoo = class(TDecorableFoo, Ifoo)
  public
    procedure FooMethod3; override;
  end;

  TVeryFoo = class(TDecorableFoo, Ifoo)
  public
    procedure FooMethod3; override;
  end;

  TReallyFoo = class(TDecorableFoo, Ifoo)
  public
    procedure FooMethod3; override;
  end;

implementation

uses
    SysUtils
  ;

{ TFoo }

function TFoo.FooMethod1: IFoo;
begin
  Result := Self;
  WriteLn('Foo Method 1');
end;

function TFoo.FooMethod2(SomeParam: String): IFoo;
begin
  Result := Self;
  WriteLn(Format('Foo Method 2 using %s', [SomeParam]));
end;

procedure TFoo.FooMethod3;
begin
  WriteLn('Foo Method 3');
end;

{ TSpecialFoo }

procedure TSpecialFoo.FooMethod3;
begin
  Write('Special ');
  inherited;
end;

{ TVeryFoo }

procedure TVeryFoo.FooMethod3;
begin
  Write('Very ');
  inherited;
end;

{ TReallyFoo }

procedure TReallyFoo.FooMethod3;
begin
  Write('Really ');
  inherited;
end;

end.

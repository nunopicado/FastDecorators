program FastDecoratorTest;

{$APPTYPE CONSOLE}

uses
  FooIntf in 'FooIntf.pas',
  FooImpl in 'FooImpl.pas';

procedure Method3;
begin
     with TFoo.Create do
     begin
          FooMethod3;
          Free;
     end;
end;

procedure SpecialMethod3;
begin
     with TSpecialFoo.Create(TFoo.Create) do
     begin
          FooMethod3;
          Free;
     end;
end;

procedure VerySpecialMethod3;
begin
     with TVeryFoo.Create(TSpecialFoo.Create(TFoo.Create)) do
     begin
          FooMethod3;
          Free;
     end;
end;

procedure ReallyVerySpecialMethod3;
begin
     with TReallyFoo.Create(TVeryFoo.Create(TSpecialFoo.Create(TFoo.Create))) do
     begin
          FooMethod3;
          Free;
     end;
end;

begin
     Method3;
     SpecialMethod3;
     VerySpecialMethod3;
     ReallyVerySpecialMethod3;

     ReadLn;
end.

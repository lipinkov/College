unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  Math;

type

  { TForm1 }

  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    ButtonCalculate: TButton;
    EditNumber: TEdit;
    EditPower: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    MemoResult: TMemo;
    procedure ButtonCalculateClick(Sender: TObject);
    procedure Label2Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Label2Click(Sender: TObject);
begin

end;

procedure TForm1.ButtonCalculateClick(Sender: TObject);
var
  Num, Pow, Res: Double;
  begin
    try
      Num := StrToFloat(EditNumber.Text);
      Pow := StrToFloat(EditPower.Text);
      Res := Power(Num, Pow);
      MemoResult.Lines.Add('Число ' + EditNumber.Text + ' в степени ' + EditPower.Text + ' равно: ' + FloatToStr(Res));
    except
      on E: Exception do
        ShowMessage('Ошибка: ' + E.Message);
    end;

end;

end.


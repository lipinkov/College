unit Edit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons;

type

  { TfEdit }

  TfEdit = class(TForm)
    bCancel: TBitBtn;
    bSave: TBitBtn;
    cbIsPerishable: TComboBox;
    ePricePerUnit: TEdit;
    eQuantity: TEdit;
    eProductName: TEdit;
    eProductID: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure bCancelClick(Sender: TObject);
    procedure bSaveClick(Sender: TObject);
    procedure cbIsPerishableChange(Sender: TObject);
    procedure ePricePerUnitChange(Sender: TObject);
    procedure eProductIDChange(Sender: TObject);
    procedure eProductNameChange(Sender: TObject);
    procedure eQuantityChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    LastValidID: String;  // Последнее корректное значение ID товара
    LastValidQuantity: String;  // Последнее корректное значение количества
    LastValidPrice: String;  // Последнее корректное значение цены за единицу
    LastValidIsPerishable: String;  // Последнее корректное значение для поля "Скоропортящийся"
  public

  end;

var
  fEdit: TfEdit;

implementation

{$R *.lfm}

{ TfEdit }

procedure TfEdit.FormCreate(Sender: TObject);
begin
  // Инициализация последних корректных значений
  LastValidID := '';
  LastValidQuantity := '';
  LastValidPrice := '';
  LastValidIsPerishable := '';
end;

procedure TfEdit.eProductIDChange(Sender: TObject);
begin
  // Проверка на целочисленный ввод для ID товара
  try
    if eProductID.Text <> '' then
      StrToInt(eProductID.Text);
    LastValidID := eProductID.Text;
  except
    on E: EConvertError do
    begin
      ShowMessage('ID товара должен быть целым числом');
      eProductID.Text := LastValidID;
    end;
  end;
end;

procedure TfEdit.eQuantityChange(Sender: TObject);
begin
  // Проверка на целочисленный ввод для количества
  try
    if eQuantity.Text <> '' then
      StrToInt(eQuantity.Text);
    LastValidQuantity := eQuantity.Text;
  except
    on E: EConvertError do
    begin
      ShowMessage('Количество должно быть целым числом');
      eQuantity.Text := LastValidQuantity;
    end;
  end;
end;

procedure TfEdit.ePricePerUnitChange(Sender: TObject);
begin
  // Проверка на вещественный ввод для цены за единицу
  try
    if ePricePerUnit.Text <> '' then
      StrToFloat(ePricePerUnit.Text);
    LastValidPrice := ePricePerUnit.Text;
  except
    on E: EConvertError do
    begin
      ShowMessage('Цена за единицу должна быть вещественным числом');
      ePricePerUnit.Text := LastValidPrice;
    end;
  end;
end;

procedure TfEdit.cbIsPerishableChange(Sender: TObject);
begin
  // Проверка на логический ввод для поля "Скоропортящийся"
  if (cbIsPerishable.Text <> 'True') and (cbIsPerishable.Text <> 'False') then
  begin
    ShowMessage('Скоропортящийся должен быть True или False');
    cbIsPerishable.Text := LastValidIsPerishable;
  end
  else
    LastValidIsPerishable := cbIsPerishable.Text;
end;

procedure TfEdit.bSaveClick(Sender: TObject);
begin
  ModalResult := mrOk;  // Устанавливает результат модального диалога в OK
end;

procedure TfEdit.bCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;  // Устанавливает результат модального диалога в Cancel
end;

procedure TfEdit.eProductNameChange(Sender: TObject);
begin

end;

end.


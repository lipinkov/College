unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  Grids, StdCtrls, Edit;

type

  { TForm1 }

  TForm1 = class(TForm)
    bSaveToFile: TButton;
    bLoadFromFile: TButton;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    bAdd: TSpeedButton;
    bEdit: TSpeedButton;
    bDel: TSpeedButton;
    bSort: TSpeedButton;
    SaveDialog1: TSaveDialog;
    SG: TStringGrid;
    procedure bAddClick(Sender: TObject);
    procedure bDelClick(Sender: TObject);
    procedure bEditClick(Sender: TObject);
    procedure bLoadFromFileClick(Sender: TObject);
    procedure bSaveToFileClick(Sender: TObject);
    procedure bSortClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

type
  TProductRecord = record
    ProductID: string[50];
    ProductName: string[100];
    Quantity: string[20];
    PricePerUnit: string[20];
    IsPerishable: string[20];
  end;

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  // Настройка заголовков и ширины столбцов
  SG.Cells[0, 0] := 'ID товара';
  SG.Cells[1, 0] := 'Название товара';
  SG.Cells[2, 0] := 'Количество';
  SG.Cells[3, 0] := 'Цена за единицу';
  SG.Cells[4, 0] := 'Скоропортящийся';
  SG.ColWidths[0] := 100;
  SG.ColWidths[1] := 200;
  SG.ColWidths[2] := 100;
  SG.ColWidths[3] := 100;
  SG.ColWidths[4] := 100;
end;

procedure TForm1.bAddClick(Sender: TObject);
begin
  // Открытие формы для ввода новой записи
  fEdit.eProductID.Text := '';
  fEdit.eProductName.Text := '';
  fEdit.eQuantity.Text := '';
  fEdit.ePricePerUnit.Text := '';
  fEdit.cbIsPerishable.ItemIndex := -1;
  if fEdit.ShowModal = mrOk then
  begin
    // Добавление новой записи в таблицу
    SG.RowCount := SG.RowCount + 1;
    SG.Cells[0, SG.RowCount - 1] := fEdit.eProductID.Text;
    SG.Cells[1, SG.RowCount - 1] := fEdit.eProductName.Text;
    SG.Cells[2, SG.RowCount - 1] := fEdit.eQuantity.Text;
    SG.Cells[3, SG.RowCount - 1] := fEdit.ePricePerUnit.Text;
    SG.Cells[4, SG.RowCount - 1] := fEdit.cbIsPerishable.Text;
  end;
end;

procedure TForm1.bDelClick(Sender: TObject);
begin
  if SG.RowCount = 1 then exit;
  // Подтверждение удаления записи
  if MessageDlg('Требуется подтверждение', 'Вы действительно хотите удалить товар "' +
    SG.Cells[1, SG.Row] + '"?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    SG.DeleteRow(SG.Row);  // Удаление записи
end;

procedure TForm1.bEditClick(Sender: TObject);
begin
  if SG.RowCount = 1 then exit;
  // Открытие формы для редактирования выбранной записи
  fEdit.eProductID.Text := SG.Cells[0, SG.Row];
  fEdit.eProductName.Text := SG.Cells[1, SG.Row];
  fEdit.eQuantity.Text := SG.Cells[2, SG.Row];
  fEdit.ePricePerUnit.Text := SG.Cells[3, SG.Row];
  fEdit.cbIsPerishable.Text := SG.Cells[4, SG.Row];
  if fEdit.ShowModal = mrOk then
  begin
    // Сохранение изменений
    SG.Cells[0, SG.Row] := fEdit.eProductID.Text;
    SG.Cells[1, SG.Row] := fEdit.eProductName.Text;
    SG.Cells[2, SG.Row] := fEdit.eQuantity.Text;
    SG.Cells[3, SG.Row] := fEdit.ePricePerUnit.Text;
    SG.Cells[4, SG.Row] := fEdit.cbIsPerishable.Text;
  end;
end;

procedure TForm1.bLoadFromFileClick(Sender: TObject);
var
  ProductFile: File of TProductRecord;
  ProductRecord: TProductRecord;
begin
  if OpenDialog1.Execute then
  begin
    AssignFile(ProductFile, OpenDialog1.FileName);  // Открытие файла для чтения
    Reset(ProductFile);
    try
      SG.RowCount := 1;  // Очистка таблицы
      while not Eof(ProductFile) do
      begin
        Read(ProductFile, ProductRecord);  // Чтение записи из файла
        SG.RowCount := SG.RowCount + 1;
        SG.Cells[0, SG.RowCount - 1] := ProductRecord.ProductID;
        SG.Cells[1, SG.RowCount - 1] := ProductRecord.ProductName;
        SG.Cells[2, SG.RowCount - 1] := ProductRecord.Quantity;
        SG.Cells[3, SG.RowCount - 1] := ProductRecord.PricePerUnit;
        SG.Cells[4, SG.RowCount - 1] := ProductRecord.IsPerishable;
      end;
    finally
      CloseFile(ProductFile);  // Закрытие файла
    end;
  end;
end;

procedure TForm1.bSaveToFileClick(Sender: TObject);
var
  ProductFile: File of TProductRecord;
  ProductRecord: TProductRecord;
  i: Integer;
begin
  if SaveDialog1.Execute then
  begin
    AssignFile(ProductFile, SaveDialog1.FileName);  // Открытие файла для записи
    Rewrite(ProductFile);
    try
      for i := 1 to SG.RowCount - 1 do
      begin
        // Запись данных в файл
        ProductRecord.ProductID := SG.Cells[0, i];
        ProductRecord.ProductName := SG.Cells[1, i];
        ProductRecord.Quantity := SG.Cells[2, i];
        ProductRecord.PricePerUnit := SG.Cells[3, i];
        ProductRecord.IsPerishable := SG.Cells[4, i];
        Write(ProductFile, ProductRecord);
      end;
    finally
      CloseFile(ProductFile);  // Закрытие файла
    end;
  end;
end;

procedure TForm1.bSortClick(Sender: TObject);
begin
  if SG.RowCount = 1 then exit;
  SG.SortColRow(true, 0);  // Сортировка записей по первому столбцу (ID товара)
end;

end.


unit formHelloWorld;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.TabControl, FMX.Edit, FMX.Objects, FMX.Controls.Presentation, System.Rtti,
  FMX.Grid.Style, FMX.ScrollBox, FMX.Grid, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.FMXUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.Bind.EngExt, Fmx.Bind.DBEngExt,
  Fmx.Bind.Grid, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope, FireDAC.Comp.DataSet,
  FMX.Memo.Types, FMX.Memo, FMX.ListBox, System.Actions, FMX.ActnList;

type
  TfrmHelloWorld = class(TForm)
    tabs: TTabControl;
    tabHello: TTabItem;
    tabSelectCategory: TTabItem;
    tabSelectItem: TTabItem;
    tabEditItem: TTabItem;
    tabSearch: TTabItem;
    Panel1: TPanel;
    Image1: TImage;
    lblShe: TLabel;
    txtAnswer: TEdit;
    tabResultSearch: TTabItem;
    ToolBar1: TToolBar;
    btnEditCategory: TSpeedButton;
    btnAddCategory: TSpeedButton;
    btnSelectCategory: TSpeedButton;
    grdCategories: TStringGrid;
    tabEditCategory: TTabItem;
    tbrAddCategory: TToolBar;
    btnSaveCategory: TSpeedButton;
    btnCancelCategory: TSpeedButton;
    con: TFDConnection;
    tbl: TFDQuery;
    tblID: TIntegerField;
    tblName_category: TStringField;
    BindSource_Categories: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    tblAsk: TFDQuery;
    ToolBar2: TToolBar;
    btnItemEdit: TSpeedButton;
    btnItemAdd: TSpeedButton;
    grdItems: TStringGrid;
    tblItems: TFDQuery;
    tblItemsID: TIntegerField;
    tblItemsName_Item: TStringField;
    tblItemsWhere_Item: TStringField;
    tblItemsLogin_Item: TStringField;
    tblItemsPsw_Item: TStringField;
    tblItemsContacts: TStringField;
    tblItemsNotes: TStringField;
    tblItemsIDCategory: TIntegerField;
    BindSource_Items: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB2: TLinkGridToDataSource;
    GroupBox1: TGroupBox;
    txtName_Category: TEdit;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    txtItemContacts: TEdit;
    GroupBox4: TGroupBox;
    txtItemPsw: TEdit;
    GroupBox5: TGroupBox;
    txtItemLogin: TEdit;
    GroupBox6: TGroupBox;
    txtItemWhere: TEdit;
    GroupBox7: TGroupBox;
    memItemNote: TMemo;
    GroupBox8: TGroupBox;
    txtItemName: TEdit;
    cmbItemCategory: TComboBox;
    tblCategory: TFDQuery;
    ToolBar3: TToolBar;
    btnItemEditSave: TSpeedButton;
    btnItemEditCancel: TSpeedButton;
    tblCategoryID: TIntegerField;
    tblCategoryName_category: TStringField;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    LinkControlToField4: TLinkControlToField;
    LinkControlToField5: TLinkControlToField;
    LinkControlToField6: TLinkControlToField;
    LinkControlToField7: TLinkControlToField;
    BindSourceDB1: TBindSourceDB;
    LinkFillControlToField1: TLinkFillControlToField;
    btnItemCancel: TSpeedButton;
    ToolBar4: TToolBar;
    btnDeleteCategory: TSpeedButton;
    ToolBar5: TToolBar;
    btnItemDelete: TSpeedButton;
    acl: TActionList;
    actItemEdit: TAction;
    actSelectCategory: TAction;
    procedure Image1Click(Sender: TObject);
    procedure btnAddCategoryClick(Sender: TObject);
    procedure btnCancelCategoryClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnEditCategoryClick(Sender: TObject);
    procedure btnSaveCategoryClick(Sender: TObject);
    procedure btnDeleteCategoryClick(Sender: TObject);
    procedure btnSelectCategoryClick(Sender: TObject);
    procedure btnItemEditClick(Sender: TObject);
    procedure btnItemEditCancelClick(Sender: TObject);
    procedure btnItemEditSaveClick(Sender: TObject);
    procedure btnItemCancelClick(Sender: TObject);
    procedure btnItemAddClick(Sender: TObject);
    procedure grdItemsCellClick(const Column: TColumn; const Row: Integer);
    procedure actItemEditExecute(Sender: TObject);
    procedure actSelectCategoryExecute(Sender: TObject);
    procedure grdCategoriesCellClick(const Column: TColumn; const Row: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmHelloWorld: TfrmHelloWorld;

implementation

{$R *.fmx}

//Изменить строку
procedure TfrmHelloWorld.actItemEditExecute(Sender: TObject);
begin
  tblCategory.Open;
  tblItems.Edit;
  tabEditItem.Visible:= true ;
  tabSelectItem.Visible:=  false;
  tabEditItem.Text:= 'Строка: ' + tblItemsName_Item.AsString;
  tabs.ActiveTab:= tabEditItem;
end;

//Показать все строки по выбранной категории
procedure TfrmHelloWorld.actSelectCategoryExecute(Sender: TObject);
begin
  tblItems.Params.ParamByName('idCateg').Value:= tblID.AsInteger;
  tblItems.Open;
  tabSelectItem.Visible:= true;
  tabSelectCategory.Visible:= false;
  tabSearch.Visible:= false;
  tabs.ActiveTab:= tabSelectItem;
end;

//Переход на добавление категории
procedure TfrmHelloWorld.btnAddCategoryClick(Sender: TObject);
  var sSQL: string;
      id: integer;
begin
  //Расчет нового ID
  sSQL:= 'select MAX(ID) as max_id from Categories';
  tblAsk.SQL.Text:= sSQL;
  tblAsk.Open;
  id:= tblAsk.FieldByName('max_id').Value;
  inc(id);
  tblAsk.Close;
  tbl.Append;
  tblID.Value:= id;

  tabEditCategory.Visible:= true;
  tabHello.Visible:= false;
  tabSelectCategory.Visible:=  false;
  tabSearch.Visible:= false;
  tabEditCategory.Text:= 'Новая Категория';
  tabs.ActiveTab:= tabEditCategory;
end;

//Отменить сохранение категории
procedure TfrmHelloWorld.btnCancelCategoryClick(Sender: TObject);
begin
  tbl.Cancel;
  tabEditCategory.Visible:= false ;
  tabSelectCategory.Visible:=  true;
  tabSearch.Visible:= true;
  tabs.ActiveTab:= tabSelectCategory;
end;

procedure TfrmHelloWorld.btnDeleteCategoryClick(Sender: TObject);
begin
  //пока не делаю
  //нужно подтверждение удаления
  //нужна проверка, что нет связанных строк
end;

//Изменить категорию
procedure TfrmHelloWorld.btnEditCategoryClick(Sender: TObject);
begin
  tbl.Edit;
  tabEditCategory.Visible:= true ;
  tabSelectCategory.Visible:=  false;
  tabSearch.Visible:= false;
  tabEditCategory.Text:= 'Категория: ' + tblName_category.AsString;
  tabs.ActiveTab:= tabEditCategory;
end;
//Добавить строки
procedure TfrmHelloWorld.btnItemAddClick(Sender: TObject);
  var sSQL: string;
    id, idCateg: integer;
begin
  //Расчет нового ID
  sSQL:= 'select MAX(ID) as max_id from Items';
  tblAsk.SQL.Text:= sSQL;
  tblAsk.Open;
  id:= tblAsk.FieldByName('max_id').Value;
  inc(id);
  tblAsk.Close;
  idCateg:= tblItems.Params.ParamByName('IDCateg').Value;

  tblCategory.Open;
  tblItems.Append;
  tblItemsID.Value:= id;
  tblItemsIDCategory.Value:= idCateg;
  tabEditItem.Visible:= true ;
  tabSelectItem.Visible:=  false;
  tabEditItem.Text:= 'Новая Строка';
  tabs.ActiveTab:= tabEditItem;
end;
//Отменить Выбор строки
procedure TfrmHelloWorld.btnItemCancelClick(Sender: TObject);
begin
  tblItems.Close;
  tabSelectItem.Visible:= false;
  tabSelectCategory.Visible:= true;
  tabSearch.Visible:= true;
  tabs.ActiveTab:= tabSelectCategory;
end;
//Отменить редактирование строки
procedure TfrmHelloWorld.btnItemEditCancelClick(Sender: TObject);
begin
  tblItems.Cancel;
  tabEditItem.Visible:= false ;
  tabSelectItem.Visible:=  true;
  tabs.ActiveTab:= tabSelectItem;
end;

procedure TfrmHelloWorld.btnItemEditClick(Sender: TObject);
begin
end;
//Сохранить строку
procedure TfrmHelloWorld.btnItemEditSaveClick(Sender: TObject);
begin
  tblItems.Post;
  tabEditItem.Visible:= false ;
  tabSelectItem.Visible:=  true;
  tblItems.Refresh;
  tabs.ActiveTab:= tabSelectItem;
end;

//Сохранить категорию
procedure TfrmHelloWorld.btnSaveCategoryClick(Sender: TObject);
begin
  tbl.Post;
  tabEditCategory.Visible:= false ;
  tabSelectCategory.Visible:=  true;
  tabSearch.Visible:= true;
  tabs.ActiveTab:= tabSelectCategory;
end;

procedure TfrmHelloWorld.btnSelectCategoryClick(Sender: TObject);
begin
end;

//FormCreate
procedure TfrmHelloWorld.FormCreate(Sender: TObject);
begin
  tabs.ActiveTab:= tabHello;
  tabSelectCategory.Visible:= false;
  tabSearch.Visible:= false;
  tabEditCategory.Visible:= false;
  tabSelectItem.Visible:= false;
  tabEditItem.Visible:= false;
end;

//клик по категории
procedure TfrmHelloWorld.grdCategoriesCellClick(const Column: TColumn;
  const Row: Integer);
begin
  actSelectCategory.Execute;
end;
//Клик по строке
procedure TfrmHelloWorld.grdItemsCellClick(const Column: TColumn;
  const Row: Integer);
begin
  actItemEdit.Execute;
end;

//Пароль
procedure TfrmHelloWorld.Image1Click(Sender: TObject);
begin
  if txtAnswer.Text = 'a+v=2d' then
    begin
      tabSelectCategory.Visible:= true;
      tabSearch.Visible:= true;
//{$IF DEFINED(iOS) or DEFINED(ANDROID)}
//  DBPath := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath, 'carnaval.db');
//  con.Params.Values['Database'] :=  DBPath;
//{$ENDIF}
      con.Connected:= true;
//  tbcTabs.ActiveTab:= tabTable;
//  tbcTabs.TabPosition:= TTabPosition.None;
      tbl.Active:= true;
    end
  else
    lblShe.Text:= 'Как дела?';
end;

end.

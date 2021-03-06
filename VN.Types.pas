unit VN.Types;

interface

uses
  System.SysUtils,
  System.Rtti,
  VN.Framworks;

type
  TvnControl = VN.Framworks.TvnControl;

  TvnControlClass = class of TvnControl;

  TvnCreateDestroyTime = (OnCreateDestroy, OnShowHide);

  TViewStoreParameter = (CreateOnShowAndFreeOnHide, CreateOnCreationAndFreeOnDestroy);

  EViewNavigator = class(Exception);

  IvnDataView = interface
    ['{E83C4096-6C79-4FB3-B23F-7D360A983A0D}']
    procedure DataReceive(AData: TValue);
  end;

implementation

end.

